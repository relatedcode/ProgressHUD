//
// Copyright (c) 2025 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SwiftUI

// MARK: - DisplayMode
enum DisplayMode: Equatable {

	case animation
	case progress
	case liveIcon(LiveIcon)
	case staticImage
}

// MARK: - ProgressHUD
@Observable
public class ProgressHUD {

	// MARK: - Properties
	public static let shared = ProgressHUD()

	var isVisible = false
	var text: String?
	var displayMode = DisplayMode.animation

	var animationType = AnimationType.activityIndicator
	var animationSymbol = "sun.max"

	var progressValue: CGFloat = 0

	var staticImage: Image?
	var staticImageColor: Color?

	var bannerVisible = false
	var bannerTitle: String?
	var bannerMessage: String?
	var bannerTask: Task<Void, Never>?

	var liveIconID = UUID()

	public var mediaSize: CGFloat = 50
	public var marginSize: CGFloat = 25

	public var colorBackground = Color.clear
	public var colorHUD = Color(UIColor.systemGray).opacity(0.1)
	public var colorStatus = Color(UIColor.label)
	public var colorProgress = Color(UIColor.lightGray)
	public var colorAnimation = Color(UIColor.lightGray)

	public var fontStatus = Font.system(size: 16, weight: .bold)

	public var imageSuccess = Image(systemName: "checkmark.circle.fill")
	public var imageError = Image(systemName: "xmark.circle.fill")
	public var colorSuccess = Color.green
	public var colorError = Color.red

	public var colorBanner = Color.clear
	public var colorBannerTitle = Color(UIColor.label)
	public var colorBannerMessage = Color(UIColor.secondaryLabel)
	public var fontBannerTitle = Font.system(size: 16, weight: .semibold)
	public var fontBannerMessage = Font.system(size: 14)

	var interaction = true
	var dismissTask: Task<Void, Never>?
	var dismissAnimTask: Task<Void, Never>?
	var keyboardHeight: CGFloat = 0

	private init() {}
}

// MARK: - ProgressHUDView
public struct ProgressHUDView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	// MARK: - Initialization
	public init() {}

	// MARK: - Body
	public var body: some View {
		GeometryReader { geometry in
			let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
			let centerY = (screenHeight - hud.keyboardHeight) / 2

			ZStack {
				hud.colorBackground
					.ignoresSafeArea()
					.allowsHitTesting(!hud.interaction)

				hudContent
					.scaleEffect(hud.isVisible ? 1 : 0.8)
					.position(x: geometry.size.width / 2, y: centerY)
			}
		}
		.ignoresSafeArea()
		.opacity(hud.isVisible ? 1 : 0)
		.allowsHitTesting(hud.isVisible)
		.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
			if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
				withAnimation(.easeOut(duration: 0.25)) {
					hud.keyboardHeight = frame.height
				}
			}
		}
		.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
			withAnimation(.easeOut(duration: 0.25)) {
				hud.keyboardHeight = 0
			}
		}
	}

	// MARK: - Private Properties
	private var hasText: Bool { hud.text != nil }

	// MARK: - Private Views
	@ViewBuilder
	private var hudContent: some View {
		let size = hud.mediaSize + 40

		VStack(spacing: 10) {
			if !shouldHideMedia {
				mediaView
					.frame(width: hud.mediaSize, height: hud.mediaSize)
			}

			if let text = hud.text {
				Text(text)
					.font(hud.fontStatus)
					.foregroundStyle(hud.colorStatus)
					.multilineTextAlignment(.center)
					.frame(maxWidth: 180)
					.fixedSize(horizontal: false, vertical: true)
			}
		}
		.padding(hasText ? 16 : 20)
		.frame(width: hasText ? nil : size, height: hasText ? nil : size)
		.fixedSize(horizontal: !hasText, vertical: true)
		.background {
			RoundedRectangle(cornerRadius: 10)
				.fill(hud.colorHUD)
				.background {
					RoundedRectangle(cornerRadius: 10)
						.fill(.regularMaterial)
				}
				.clipShape(RoundedRectangle(cornerRadius: 10))
		}
	}

	private var shouldHideMedia: Bool {
		if case .animation = hud.displayMode {
			return hud.animationType == .none
		}
		return false
	}

	@ViewBuilder
	private var mediaView: some View {
		switch hud.displayMode {
		case .animation:
			animationView
				.id(hud.animationType)
		case .progress:
			ProgressCircleView(progress: hud.progressValue, color: hud.colorProgress)
				.id(hud.text != nil)
		case .liveIcon(let icon):
			liveIconView(icon)
		case .staticImage:
			if let image = hud.staticImage {
				if let color = hud.staticImageColor {
					image
						.resizable()
						.scaledToFit()
						.symbolRenderingMode(.palette)
						.foregroundStyle(.white, color)
				} else {
					image
						.resizable()
						.scaledToFit()
						.foregroundStyle(hud.colorAnimation)
				}
			}
		}
	}

	@ViewBuilder
	private func liveIconView(_ icon: LiveIcon) -> some View {
		switch icon {
		case .succeed:
			LiveIconSucceedView(color: hud.colorAnimation, animationID: hud.liveIconID)
		case .failed:
			LiveIconFailedView(color: hud.colorAnimation, animationID: hud.liveIconID)
		case .added:
			LiveIconAddedView(color: hud.colorAnimation, animationID: hud.liveIconID)
		}
	}

	@ViewBuilder
	private var animationView: some View {
		switch hud.animationType {
		case .none:
			EmptyView()
		case .activityIndicator:
			ActivityIndicatorView()
		case .ballVerticalBounce:
			BallVerticalBounceView()
		case .barSweepToggle:
			BarSweepToggleView()
		case .circleArcDotSpin:
			CircleArcDotSpinView()
		case .circleBarSpinFade:
			CircleBarSpinFadeView()
		case .circleDotSpinFade:
			CircleDotSpinFadeView()
		case .circlePulseMultiple:
			CirclePulseMultipleView()
		case .circlePulseSingle:
			CirclePulseSingleView()
		case .circleRippleMultiple:
			CircleRippleMultipleView()
		case .circleRippleSingle:
			CircleRippleSingleView()
		case .circleRotateChase:
			CircleRotateChaseView()
		case .circleStrokeSpin:
			CircleStrokeSpinView()
		case .dualDotSidestep:
			DualDotSidestepView()
		case .horizontalBarScaling:
			HorizontalBarScalingView()
		case .horizontalDotScaling:
			HorizontalDotScalingView()
		case .pacmanProgress:
			PacmanProgressView()
		case .quintupleDotDance:
			QuintupleDotDanceView()
		case .semiRingRotation:
			SemiRingRotationView()
		case .sfSymbolBounce:
			SFSymbolBounceView()
		case .squareCircuitSnake:
			SquareCircuitSnakeView()
		case .triangleDotShift:
			TriangleDotShiftView()
		}
	}
}

// MARK: - ProgressHUDModifier
public struct ProgressHUDModifier: ViewModifier {

	// MARK: - Body
	public func body(content: Content) -> some View {
		content
			.overlay {
				ProgressHUDView()
			}
			.overlay(alignment: .top) {
				ProgressBannerView()
			}
	}
}

// MARK: - View Extension
public extension View {

	func progressHUD() -> some View {
		modifier(ProgressHUDModifier())
	}
}
