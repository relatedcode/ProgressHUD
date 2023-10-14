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

// MARK: - Activity Indicator
extension ProgressHUD {

	func animationActivityIndicator(_ view: UIView) {
		let spinner = UIActivityIndicatorView(style: .large)
		let scale = view.frame.size.width / spinner.frame.size.width
		spinner.transform = CGAffineTransform(scaleX: scale, y: scale)
		spinner.frame = view.bounds
		spinner.color = colorAnimation
		spinner.hidesWhenStopped = true
		spinner.startAnimating()
		view.addSubview(spinner)
	}
}
