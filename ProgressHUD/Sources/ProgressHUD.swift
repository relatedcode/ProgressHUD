//
// Copyright (c) 2024 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public class ProgressHUD: UIView {

	var main: UIWindow!

	// Banner properties
	var viewBanner: UIToolbar?
	var colorBanner = UIColor.clear
	var timerBanner: Timer?
	var observerBanner: NSObjectProtocol?

	var textBannerTitle = ""
	var colorBannerTitle = UIColor.label
	var fontBannerTitle = UIFont.boldSystemFont(ofSize: 16)
	var labelBannerTitle: UILabel?

	var textBannerMessage = ""
	var colorBannerMessage = UIColor.secondaryLabel
	var fontBannerMessage = UIFont.systemFont(ofSize: 14)
	var labelBannerMessage: UILabel?

	// HUD properties
	var timerHUD: Timer?

	var mediaSize: CGFloat = 70
	var marginSize: CGFloat = 30

	var viewBackground: UIView?
	var toolbarHUD: UIToolbar?
	var labelStatus: UILabel?

	var viewProgress: ProgressView?
	var viewLiveIcon: UIView?
	var viewStaticImage: UIImageView?
	var viewAnimation: UIView?

	var animationType	= AnimationType.activityIndicator
	var animationSymbol	= "sun.max"

	var colorBackground	= UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
	var colorHUD		= UIColor.systemGray
	var colorStatus		= UIColor.label
	var colorProgress	= UIColor.lightGray
	var colorAnimation	= UIColor.lightGray

	var fontStatus		= UIFont.boldSystemFont(ofSize: 24)
	var imageSuccess	= UIImage.checkmark.withTintColor(UIColor.systemGreen, renderingMode: .alwaysOriginal)
	var imageError		= UIImage.remove.withTintColor(UIColor.systemRed, renderingMode: .alwaysOriginal)

	var didSetupNotifications	= false
	let keyboardWillShow		= UIResponder.keyboardWillShowNotification
	let keyboardWillHide		= UIResponder.keyboardWillHideNotification
	let keyboardDidShow			= UIResponder.keyboardDidShowNotification
	let keyboardDidHide			= UIResponder.keyboardDidHideNotification
	let orientationDidChange	= UIDevice.orientationDidChangeNotification

	static let shared = ProgressHUD()

	convenience private init() {
		self.init(frame: UIScreen.main.bounds)
		self.alpha = 0
	}

	required internal init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override private init(frame: CGRect) {
		super.init(frame: frame)
	}
}

// MARK: - Progress
extension ProgressHUD {

	func progress(text: String?, value: CGFloat, interaction: Bool) {

		removeDelayTimer()

		setupWindow()
		setupBackground(interaction)
		setupToolbar()
		setupStatus(text)

		removeLiveIcon()
		removeStaticImage()
		removeAnimationView()
		setupProgressView(value)

		setupSizes(text, false)
		setupNotifications()
		setupPosition()
		displayHUD()
	}
}

// MARK: - Live Icon
extension ProgressHUD {

	func liveIcon(text: String?, icon: LiveIcon, interaction: Bool, delay: TimeInterval?) {

		removeDelayTimer()

		setupWindow()
		setupBackground(interaction)
		setupToolbar()
		setupStatus(text)

		removeStaticImage()
		removeProgressView()
		removeAnimationView()
		setupLiveIcon(icon)
		setupDelayTimer(text, delay)

		setupSizes(text, false)
		setupNotifications()
		setupPosition()
		displayHUD()
	}
}

// MARK: - Static Image
extension ProgressHUD {

	func staticImage(text: String?, image: UIImage?, interaction: Bool, delay: TimeInterval?) {

		removeDelayTimer()

		setupWindow()
		setupBackground(interaction)
		setupToolbar()
		setupStatus(text)

		removeLiveIcon()
		removeProgressView()
		removeAnimationView()
		setupStaticImage(image)
		setupDelayTimer(text, delay)

		setupSizes(text, false)
		setupNotifications()
		setupPosition()
		displayHUD()
	}
}

// MARK: - Animation
extension ProgressHUD {

	func animate(text: String?, interaction: Bool) {

		removeDelayTimer()

		setupWindow()
		setupBackground(interaction)
		setupToolbar()
		setupStatus(text)

		removeLiveIcon()
		removeStaticImage()
		removeProgressView()
		setupAnimationView()

		setupSizes(text, true)
		setupNotifications()
		setupPosition()
		displayHUD()
	}
}

// MARK: - Delay Timer
extension ProgressHUD {

	private func removeDelayTimer() {
		timerHUD?.invalidate()
		timerHUD = nil
	}

	private func setupDelayTimer(_ text: String?, _ delay: TimeInterval?) {
		let count = text?.count ?? 0
		let delay = delay ?? Double(count) * 0.03 + 1.25

		timerHUD = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
			guard let self = self else { return }
			dismissHUD()
		}
	}
}

// MARK: - Notifications
extension ProgressHUD {

	private func removeNotifications() {
		if (didSetupNotifications) {
			NotificationCenter.default.removeObserver(self)
			didSetupNotifications = false
		}
	}

	private func setupNotifications() {
		if (!didSetupNotifications) {
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardWillShow, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardWillHide, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardDidShow, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardDidHide, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: orientationDidChange, object: nil)
			didSetupNotifications = true
		}
	}
}

// MARK: - Window
extension ProgressHUD {

	func setupWindow() {
		if (main == nil) {
			main = UIApplication.shared.windows.first
		}
	}
}

// MARK: - Background
extension ProgressHUD {

	private func removeBackground() {
		viewBackground?.removeFromSuperview()
		viewBackground = nil
	}

	private func setupBackground(_ interaction: Bool) {
		if (viewBackground == nil) {
			viewBackground = UIView(frame: bounds)
			main.addSubview(viewBackground!)
		}

		viewBackground?.backgroundColor = interaction ? .clear : colorBackground
		viewBackground?.isUserInteractionEnabled = !interaction
	}
}

// MARK: - Toolbar
extension ProgressHUD {

	private func removeToolbar() {
		toolbarHUD?.removeFromSuperview()
		toolbarHUD = nil
	}

	private func setupToolbar() {
		if (toolbarHUD == nil) {
			toolbarHUD = UIToolbar(frame: CGRect.zero)
			toolbarHUD?.isTranslucent = true
			toolbarHUD?.clipsToBounds = true
			toolbarHUD?.layer.cornerRadius = 10
			toolbarHUD?.layer.masksToBounds = true
			viewBackground?.addSubview(toolbarHUD!)
		}

		toolbarHUD?.backgroundColor = colorHUD
	}
}

// MARK: - Status Label
extension ProgressHUD {

	private func removeStatus() {
		labelStatus?.removeFromSuperview()
		labelStatus = nil
	}

	private func setupStatus(_ text: String?) {
		if (labelStatus == nil) {
			labelStatus = UILabel()
			labelStatus?.textAlignment = .center
			labelStatus?.baselineAdjustment = .alignCenters
			labelStatus?.numberOfLines = 0
			toolbarHUD?.addSubview(labelStatus!)
		}

		labelStatus?.text = text
		labelStatus?.font = fontStatus
		labelStatus?.textColor = colorStatus
		labelStatus?.isHidden = (text == nil) ? true : false
	}
}

// MARK: - Progress View
extension ProgressHUD {

	private func removeProgressView() {
		viewProgress?.removeFromSuperview()
		viewProgress = nil
	}

	private func setupProgressView(_ value: CGFloat) {
		if (viewProgress == nil) {
			viewProgress = ProgressView(colorProgress)
			viewProgress?.frame = CGRect(x: 0, y: 0, width: mediaSize, height: mediaSize)
		}

		guard let viewProgress = viewProgress else { return }

		if (viewProgress.superview == nil) {
			toolbarHUD?.addSubview(viewProgress)
		}

		viewProgress.setProgress(value)
	}
}

// MARK: - Live Icon
extension ProgressHUD {

	private func removeLiveIcon() {
		viewLiveIcon?.removeFromSuperview()
		viewLiveIcon = nil
	}

	private func setupLiveIcon(_ icon: LiveIcon) {
		if (viewLiveIcon == nil) {
			viewLiveIcon = UIView(frame: CGRect(x: 0, y: 0, width: mediaSize, height: mediaSize))
		}

		guard let viewLiveIcon = viewLiveIcon else { return }

		if (viewLiveIcon.superview == nil) {
			toolbarHUD?.addSubview(viewLiveIcon)
		}

		viewLiveIcon.layer.sublayers?.forEach {
			$0.removeFromSuperlayer()
		}

		if (icon == .succeed)	{ liveIconSucceed(viewLiveIcon)	}
		if (icon == .failed)	{ liveIconFailed(viewLiveIcon)	}
		if (icon == .added)		{ liveIconAdded(viewLiveIcon)	}
	}
}

// MARK: - Static Image
extension ProgressHUD {

	private func removeStaticImage() {
		viewStaticImage?.removeFromSuperview()
		viewStaticImage = nil
	}

	private func setupStaticImage(_ image: UIImage?) {
		if (viewStaticImage == nil) {
			viewStaticImage = UIImageView(frame: CGRect(x: 0, y: 0, width: mediaSize, height: mediaSize))
		}

		guard let viewStaticImage = viewStaticImage else { return }

		if (viewStaticImage.superview == nil) {
			toolbarHUD?.addSubview(viewStaticImage)
		}

		viewStaticImage.image = image
		viewStaticImage.contentMode = .scaleAspectFit
	}
}

// MARK: - Animation View
extension ProgressHUD {

	private func removeAnimationView() {
		viewAnimation?.removeFromSuperview()
		viewAnimation = nil
	}

	private func setupAnimationView() {
		if (viewAnimation == nil) {
			viewAnimation = UIView(frame: CGRect(x: 0, y: 0, width: mediaSize, height: mediaSize))
		}

		guard let viewAnimation = viewAnimation else { return }

		if (viewAnimation.superview == nil) {
			toolbarHUD?.addSubview(viewAnimation)
		}

		viewAnimation.subviews.forEach {
			$0.removeFromSuperview()
		}

		viewAnimation.layer.sublayers?.forEach {
			$0.removeFromSuperlayer()
		}

		if (animationType == .activityIndicator)		{ animationActivityIndicator(viewAnimation)		}
		if (animationType == .ballVerticalBounce)		{ animationBallVerticalBounce(viewAnimation)	}
		if (animationType == .barSweepToggle)			{ animationBarSweepToggle(viewAnimation)		}
		if (animationType == .circleArcDotSpin)			{ animationCircleArcDotSpin(viewAnimation)		}
		if (animationType == .circleBarSpinFade)		{ animationCircleBarSpinFade(viewAnimation)		}
		if (animationType == .circleDotSpinFade)		{ animationCircleDotSpinFade(viewAnimation)		}
		if (animationType == .circlePulseMultiple)		{ animationCirclePulseMultiple(viewAnimation)	}
		if (animationType == .circlePulseSingle)		{ animationCirclePulseSingle(viewAnimation)		}
		if (animationType == .circleRippleMultiple)		{ animationCircleRippleMultiple(viewAnimation)	}
		if (animationType == .circleRippleSingle)		{ animationCircleRippleSingle(viewAnimation)	}
		if (animationType == .circleRotateChase)		{ animationCircleRotateChase(viewAnimation)		}
		if (animationType == .circleStrokeSpin)			{ animationCircleStrokeSpin(viewAnimation)		}
		if (animationType == .dualDotSidestep)			{ animationDualDotSidestep(viewAnimation)		}
		if (animationType == .horizontalBarScaling)		{ animationHorizontalBarScaling(viewAnimation)	}
		if (animationType == .horizontalDotScaling)		{ animationHorizontalDotScaling(viewAnimation)	}
		if (animationType == .pacmanProgress)			{ animationPacmanProgress(viewAnimation)		}
		if (animationType == .quintupleDotDance)		{ animationQuintupleDotDance(viewAnimation)		}
		if (animationType == .semiRingRotation)			{ animationSemiRingRotation(viewAnimation)		}
		if (animationType == .sfSymbolBounce)			{ animationSFSymbolBounce(viewAnimation)		}
		if (animationType == .squareCircuitSnake)		{ animationSquareCircuitSnake(viewAnimation)	}
		if (animationType == .triangleDotShift)			{ animationTriangleDotShift(viewAnimation)		}
	}
}

// MARK: - Setup Sizes
extension ProgressHUD {

	private func setupSizes(_ text: String?, _ animation: Bool) {
		if let text {
			if (animation) && (animationType == .none) {
				setupSizesTextOnly(text)
			} else {
				setupSizesBoth(text)
			}
		} else {
			setupSizesTextNone()
		}
	}

	private func setupSizesBoth(_ text: String) {
		var rect = rectText(text)
		let base = mediaSize + 2 * marginSize

		let width = max(base, rect.size.width + 2 * marginSize)
		let height = max(base, rect.size.height + 2 * marginSize + mediaSize)

		let center = CGPoint(x: width / 2, y: marginSize + mediaSize / 2)

		rect.origin.x = (width - rect.size.width) / 2
		rect.origin.y = (height - rect.size.height) / 2 + (mediaSize + marginSize) / 2

		setupSizes(width, height, center, rect)
	}

	private func setupSizesTextOnly(_ text: String) {
		var rect = rectText(text)
		let base = mediaSize + 2 * marginSize

		let width = max(base, rect.size.width + 2 * marginSize)
		let height = max(base, rect.size.height + 2 * marginSize)

		rect.origin.x = (width - rect.size.width) / 2
		rect.origin.y = (height - rect.size.height) / 2

		setupSizes(width, height, CGPointZero, rect)
	}

	private func setupSizesTextNone() {
		let width = mediaSize + 2 * marginSize
		let height = mediaSize + 2 * marginSize

		let center = CGPoint(x: width / 2, y: height / 2)

		setupSizes(width, height, center, CGRectZero)
	}

	private func setupSizes(_ width: CGFloat, _ height: CGFloat, _ center: CGPoint, _ rect: CGRect) {
		toolbarHUD?.bounds = CGRect(x: 0, y: 0, width: ceil(width), height: ceil(height))

		viewProgress?.center = center
		viewLiveIcon?.center = center
		viewStaticImage?.center = center
		viewAnimation?.center = center

		labelStatus?.frame = rect
	}

	private func rectText(_ text: String) -> CGRect {
		let size = CGSize(width: 250, height: 250)
		let attributes = [NSAttributedString.Key.font: fontStatus]
		return text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
	}
}

// MARK: - Setup Position
extension ProgressHUD {

	@objc private func setupPosition(_ notification: Notification? = nil) {
		var heightKeyboard: CGFloat = 0
		var animationDuration: TimeInterval = 0

		if let notification = notification {
			let frameKeyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? CGRect.zero
			animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0

			if (notification.name == keyboardWillShow) || (notification.name == keyboardDidShow) {
				heightKeyboard = frameKeyboard.size.height
			} else if (notification.name == keyboardWillHide) || (notification.name == keyboardDidHide) {
				heightKeyboard = 0
			} else {
				heightKeyboard = keyboardHeight()
			}
		} else {
			heightKeyboard = keyboardHeight()
		}

		DispatchQueue.main.async { [self] in
			let center = CGPoint(x: main.bounds.size.width / 2, y: (main.bounds.size.height - heightKeyboard) / 2)

			UIView.animate(withDuration: animationDuration, delay: 0, options: .allowUserInteraction) { [self] in
				viewBackground?.frame = main.bounds
				toolbarHUD?.center = center
			}
		}
	}

	private func keyboardHeight() -> CGFloat {
		let windows = UIApplication.shared.windows
		for window in windows {
			for view in window.subviews {
				if String(describing: type(of: view)).hasPrefix("UIInputSetContainerView") {
					for subview in view.subviews {
						if String(describing: type(of: subview)).hasPrefix("UIInputSetHostView") {
							let screenRect = UIScreen.main.bounds
							let keyboardRect = window.convert(subview.frame, to: nil)
							if keyboardRect.intersects(screenRect) {
								return subview.frame.height
							}
						}
					}
				}
			}
		}
		return 0
	}
}

// MARK: - Display, Dismiss, Remove, Destroy
extension ProgressHUD {

	private func displayHUD() {
		if (alpha == 0) {
			alpha = 1
			toolbarHUD?.alpha = 0
			toolbarHUD?.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)

			UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: { [self] in
				toolbarHUD?.transform = CGAffineTransform(scaleX: 1/1.4, y: 1/1.4)
				toolbarHUD?.alpha = 1
			}, completion: nil)
		}
	}

	func dismissHUD() {
		if (alpha == 1) {
			UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: { [self] in
				toolbarHUD?.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
				toolbarHUD?.alpha = 0
			}, completion: { [self] _ in
				destroyHUD()
				alpha = 0
			})
		}
	}

	func removeHUD() {
		if (alpha == 1) {
			toolbarHUD?.alpha = 0
			destroyHUD()
			alpha = 0
		}
	}

	private func destroyHUD() {
		removeDelayTimer()
		removeNotifications()

		removeLiveIcon()
		removeStaticImage()
		removeProgressView()
		removeAnimationView()

		removeStatus()
		removeToolbar()
		removeBackground()
	}
}
