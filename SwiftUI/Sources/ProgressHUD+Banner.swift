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

// MARK: - ProgressBannerView
public struct ProgressBannerView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	// MARK: - Initialization
	public init() {}

	// MARK: - Body
	public var body: some View {
		if hud.bannerVisible {
			VStack {
				bannerContent
					.padding(.horizontal, 16)
					.padding(.top, 8)
				Spacer()
			}
			.transition(.move(edge: .top).combined(with: .opacity))
		}
	}

	// MARK: - Private Views
	private var bannerContent: some View {
		VStack(alignment: .leading, spacing: 4) {
			if let title = hud.bannerTitle, !title.isEmpty {
				Text(title)
					.font(hud.fontBannerTitle)
					.foregroundStyle(hud.colorBannerTitle)
					.lineLimit(1)
			}
			if let message = hud.bannerMessage, !message.isEmpty {
				Text(message)
					.font(hud.fontBannerMessage)
					.foregroundStyle(hud.colorBannerMessage)
					.lineLimit(2)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.horizontal, 16)
		.padding(.vertical, 12)
		.background {
			RoundedRectangle(cornerRadius: 10)
				.fill(.ultraThinMaterial)
				.background {
					RoundedRectangle(cornerRadius: 10)
						.fill(hud.colorBanner)
				}
		}
		.onTapGesture {
			ProgressHUD.bannerHide()
		}
	}
}

// MARK: - ProgressBannerModifier
public struct ProgressBannerModifier: ViewModifier {

	// MARK: - Body
	public func body(content: Content) -> some View {
		content.overlay(alignment: .top) {
			ProgressBannerView()
		}
	}
}

// MARK: - View Extension
public extension View {

	func progressBanner() -> some View {
		modifier(ProgressBannerModifier())
	}
}
