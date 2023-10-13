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

// MARK: - Show Banner
extension ProgressHUD {

	func showBanner(title: String?, message: String?, delay: TimeInterval) {
		setupWindow()
		removeBanner()

		textBannerTitle = title ?? ""
		textBannerMessage = message ?? ""

		viewBanner = UIToolbar()
		viewBanner?.isTranslucent = true
		viewBanner?.clipsToBounds = true
		viewBanner?.layer.cornerRadius = 10
		viewBanner?.backgroundColor = colorBanner

		labelBannerTitle = UILabel()
		labelBannerTitle?.text = textBannerTitle
		labelBannerTitle?.font = fontBannerTitle
		labelBannerTitle?.textColor = colorBannerTitle

		labelBannerMessage = UILabel()
		labelBannerMessage?.text = textBannerMessage
		labelBannerMessage?.font = fontBannerMessage
		labelBannerMessage?.textColor = colorBannerMessage

		resizeBanner()

		if let viewBanner, let labelBannerTitle, let labelBannerMessage  {
			main.addSubview(viewBanner)
			viewBanner.addSubview(labelBannerTitle)
			viewBanner.addSubview(labelBannerMessage)

			let y = viewBanner.frame.origin.y
			viewBanner.frame.origin.y = -100
			UIView.animate(withDuration: 0.25) {
				viewBanner.frame.origin.y = y
			}
		}

		timerBanner?.invalidate()
		timerBanner = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
			guard let self = self else { return }
			self.hideBanner()
		}

		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideBanner))
		viewBanner?.addGestureRecognizer(tapGesture)

		createBannerObserver()
	}
}

// MARK: - Hide Banner
extension ProgressHUD {

	@objc func hideBanner() {
		guard let banner = viewBanner else { return }

		removeBannerObserver()
		UIView.animate(withDuration: 0.25, animations: {
			banner.frame.origin.y = -100
		}, completion: { _ in
			self.removeBanner()
		})
	}
}

// MARK: - Remove Banner
extension ProgressHUD {

	private func removeBanner() {
		labelBannerMessage?.removeFromSuperview()
		labelBannerTitle?.removeFromSuperview()
		viewBanner?.removeFromSuperview()

		labelBannerMessage = nil
		labelBannerTitle = nil
		viewBanner = nil
	}
}

// MARK: - Orientation Observer
extension ProgressHUD {

	private func removeBannerObserver() {
		if let observer = observerBanner {
			NotificationCenter.default.removeObserver(observer)
		}
	}

	private func createBannerObserver() {
		observerBanner = NotificationCenter.default.addObserver(forName: orientationDidChange, object: nil, queue: .main) { notification in
			DispatchQueue.main.async {
				self.resizeBanner()
			}
		}
	}
}

// MARK: - Banner Size
extension ProgressHUD {

	private func resizeBanner() {
		let widthBanner = main.frame.width - 32
		let widthLabel = main.frame.width - 64

		let multiline = messageMultiline(widthLabel)
		let heightBanner: CGFloat = multiline ? 80 : 64
		let heightMessage: CGFloat = multiline ? 40 : 20

		viewBanner?.frame = CGRect(x: 16, y: main.safeAreaInsets.top, width: widthBanner, height: heightBanner)
		labelBannerTitle?.frame = CGRect(x: 16, y: 8, width: widthLabel, height: 24)
		labelBannerMessage?.frame = CGRect(x: 16, y: 32, width: widthLabel, height: heightMessage)

		labelBannerMessage?.numberOfLines = multiline ? 2 : 1
	}

	private func messageMultiline(_ widthLabel: CGFloat) -> Bool {
		let size = CGSize(width: widthLabel, height: .greatestFiniteMagnitude)
		let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
		let attributes = [NSAttributedString.Key.font: fontBannerMessage]
		let attributed = NSAttributedString(string: textBannerMessage, attributes: attributes)
		let rect = attributed.boundingRect(with: size, options: options, context: nil)
		return rect.height > fontBannerMessage.lineHeight
	}
}
