//
// Copyright (c) 2023 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

// MARK: - Banner customization
public extension ProgressHUD {

	class var colorBanner: UIColor {
		get { shared.colorBanner }
		set { shared.colorBanner = newValue }
	}

	class var colorBannerTitle: UIColor {
		get { shared.colorBannerTitle }
		set { shared.colorBannerTitle = newValue }
	}

	class var colorBannerMessage: UIColor {
		get { shared.colorBannerMessage }
		set { shared.colorBannerMessage = newValue }
	}

	class var fontBannerTitle: UIFont {
		get { shared.fontBannerTitle }
		set { shared.fontBannerTitle = newValue }
	}

	class var fontBannerMessage: UIFont {
		get { shared.fontBannerMessage }
		set { shared.fontBannerMessage = newValue }
	}
}

// MARK: - HUD customization
public extension ProgressHUD {

	class var window: UIWindow {
		get { shared.main }
		set { shared.main = newValue }
	}

	class var mediaSize: CGFloat {
		get { shared.mediaSize }
		set { shared.mediaSize = newValue }
	}

	class var marginSize: CGFloat {
		get { shared.marginSize }
		set { shared.marginSize = newValue }
	}

	class var animationType: AnimationType {
		get { shared.animationType }
		set { shared.animationType = newValue }
	}

	class var colorBackground: UIColor {
		get { shared.colorBackground }
		set { shared.colorBackground = newValue }
	}

	class var colorHUD: UIColor {
		get { shared.colorHUD }
		set { shared.colorHUD = newValue }
	}

	class var colorStatus: UIColor {
		get { shared.colorStatus }
		set { shared.colorStatus = newValue }
	}

	class var colorProgress: UIColor {
		get { shared.colorProgress }
		set { shared.colorProgress = newValue }
	}

	class var colorAnimation: UIColor {
		get { shared.colorAnimation }
		set { shared.colorAnimation = newValue }
	}

	class var fontStatus: UIFont {
		get { shared.fontStatus }
		set { shared.fontStatus = newValue }
	}

	class var imageSuccess: UIImage {
		get { shared.imageSuccess }
		set { shared.imageSuccess = newValue }
	}

	class var imageError: UIImage {
		get { shared.imageError }
		set { shared.imageError = newValue }
	}
}

// MARK: - HUD General
public extension ProgressHUD {

	class func dismiss() {
		DispatchQueue.main.async {
			shared.dismissHUD()
		}
	}

	class func remove() {
		DispatchQueue.main.async {
			shared.removeHUD()
		}
	}

	class func show(_ text: String? = nil, interaction: Bool = true) {
		DispatchQueue.main.async {
			shared.setup(text: text, interaction: interaction)
		}
	}
}

// MARK: - Animated Icon
public extension ProgressHUD {

	class func show(_ text: String? = nil, icon: AnimatedIcon, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.setup(text: text, animatedIcon: icon, interaction: interaction, delay: delay)
		}
	}

	class func showSucceed(_ text: String? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.setup(text: text, animatedIcon: .succeed, interaction: interaction, delay: delay)
		}
	}

	class func showFailed(_ text: String? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.setup(text: text, animatedIcon: .failed, interaction: interaction, delay: delay)
		}
	}

	class func showFailed(_ error: Error?, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.setup(text: error?.localizedDescription, animatedIcon: .failed, interaction: interaction, delay: delay)
		}
	}

	class func showAdded(_ text: String? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.setup(text: text, animatedIcon: .added, interaction: interaction, delay: delay)
		}
	}
}

// MARK: - Static Image
public extension ProgressHUD {

	class func show(_ text: String? = nil, symbol: String, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			let image = UIImage(systemName: symbol) ?? UIImage(systemName: "questionmark")
			let colored = image?.withTintColor(shared.colorAnimation, renderingMode: .alwaysOriginal)
			shared.setup(text: text, staticImage: colored, interaction: interaction, delay: delay)
		}
	}

	class func showSuccess(_ text: String? = nil, image: UIImage? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.setup(text: text, staticImage: image ?? shared.imageSuccess, interaction: interaction, delay: delay)
		}
	}

	class func showError(_ text: String? = nil, image: UIImage? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.setup(text: text, staticImage: image ?? shared.imageError, interaction: interaction, delay: delay)
		}
	}

	class func showError(_ error: Error?, image: UIImage? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.setup(text: error?.localizedDescription, staticImage: image ?? shared.imageError, interaction: interaction, delay: delay)
		}
	}
}

// MARK: - Progress
public extension ProgressHUD {

	class func showProgress(_ progress: CGFloat, interaction: Bool = false) {
		DispatchQueue.main.async {
			shared.setup(text: nil, progress: progress, interaction: interaction)
		}
	}

	class func showProgress(_ text: String?, _ progress: CGFloat, interaction: Bool = false) {
		DispatchQueue.main.async {
			shared.setup(text: text, progress: progress, interaction: interaction)
		}
	}
}

// MARK: - Banner
public extension ProgressHUD {

	class func showBanner(_ title: String?, _ message: String?, delay: TimeInterval = 3.0) {
		DispatchQueue.main.async {
			shared.showBanner(title: title, message: message, delay: delay)
		}
	}

	class func hideBanner() {
		DispatchQueue.main.async {
			shared.hideBanner()
		}
	}
}
