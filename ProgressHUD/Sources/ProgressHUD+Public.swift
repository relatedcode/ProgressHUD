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

	class var animationSymbol: String {
		get { shared.animationSymbol }
		set { shared.animationSymbol = newValue }
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

// MARK: - HUD Removal
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
}

// MARK: - Progress
public extension ProgressHUD {

	class func progress(_ value: CGFloat, interaction: Bool = false) {
		DispatchQueue.main.async {
			shared.progress(text: nil, value: value, interaction: interaction)
		}
	}

	class func progress(_ text: String?, _ value: CGFloat, interaction: Bool = false) {
		DispatchQueue.main.async {
			shared.progress(text: text, value: value, interaction: interaction)
		}
	}
}

// MARK: - Live Icon
public extension ProgressHUD {

	class func liveIcon(_ text: String? = nil, icon: LiveIcon, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.liveIcon(text: text, icon: icon, interaction: interaction, delay: delay)
		}
	}

	class func succeed(_ text: String? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.liveIcon(text: text, icon: .succeed, interaction: interaction, delay: delay)
		}
	}

	class func failed(_ text: String? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.liveIcon(text: text, icon: .failed, interaction: interaction, delay: delay)
		}
	}

	class func failed(_ error: Error?, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.liveIcon(text: error?.localizedDescription, icon: .failed, interaction: interaction, delay: delay)
		}
	}

	class func added(_ text: String? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.liveIcon(text: text, icon: .added, interaction: interaction, delay: delay)
		}
	}
}

// MARK: - Static Image
public extension ProgressHUD {

	class func image(_ text: String? = nil, image: UIImage?, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.staticImage(text: text, image: image, interaction: interaction, delay: delay)
		}
	}

	class func symbol(_ text: String? = nil, name: String, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			let image = UIImage(systemName: name) ?? UIImage(systemName: "questionmark")
			let config = UIImage.SymbolConfiguration(weight: .bold)
			let modified = image?.applyingSymbolConfiguration(config)
			let colored = modified?.withTintColor(colorAnimation, renderingMode: .alwaysOriginal)
			shared.staticImage(text: text, image: colored, interaction: interaction, delay: delay)
		}
	}

	class func success(_ text: String? = nil, image: UIImage? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.staticImage(text: text, image: image ?? imageSuccess, interaction: interaction, delay: delay)
		}
	}

	class func error(_ text: String? = nil, image: UIImage? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.staticImage(text: text, image: image ?? imageError, interaction: interaction, delay: delay)
		}
	}

	class func error(_ error: Error?, image: UIImage? = nil, interaction: Bool = true, delay: TimeInterval? = nil) {
		DispatchQueue.main.async {
			shared.staticImage(text: error?.localizedDescription, image: image ?? imageError, interaction: interaction, delay: delay)
		}
	}
}

// MARK: - Animation
public extension ProgressHUD {

	class func animate(_ text: String? = nil, interaction: Bool = true) {
		DispatchQueue.main.async {
			shared.animate(text: text, interaction: interaction)
		}
	}

	class func animate(_ text: String? = nil, _ type: AnimationType, interaction: Bool = true) {
		DispatchQueue.main.async {
			animationType = type
			shared.animate(text: text, interaction: interaction)
		}
	}

	class func animate(_ text: String? = nil, symbol: String, interaction: Bool = true) {
		DispatchQueue.main.async {
			animationType = .sfSymbolBounce
			animationSymbol = symbol
			shared.animate(text: text, interaction: interaction)
		}
	}
}

// MARK: - Banner
public extension ProgressHUD {

	class func banner(_ title: String?, _ message: String?, delay: TimeInterval = 3.0) {
		DispatchQueue.main.async {
			shared.showBanner(title: title, message: message, delay: delay)
		}
	}

	class func bannerHide() {
		DispatchQueue.main.async {
			shared.hideBanner()
		}
	}
}
