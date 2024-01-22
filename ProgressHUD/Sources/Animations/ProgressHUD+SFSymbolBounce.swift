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

// MARK: - SF Symbol Bounce
extension ProgressHUD {

	func animationSFSymbolBounce(_ view: UIView) {
		let width = view.frame.width
		let height = view.frame.height

		let image = UIImage(systemName: animationSymbol) ?? UIImage(systemName: "questionmark")
		let config = UIImage.SymbolConfiguration(weight: .bold)

		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
		imageView.image = image?.applyingSymbolConfiguration(config)
		imageView.tintColor = colorAnimation
		imageView.contentMode = .scaleAspectFit

		if #available(iOS 17.0, *) {
			imageView.addSymbolEffect(.bounce, options: .repeating)
		}

		view.addSubview(imageView)
	}
}
