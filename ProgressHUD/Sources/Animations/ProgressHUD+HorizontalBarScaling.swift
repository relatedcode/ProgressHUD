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

// MARK: - Horizontal Bar Scaling
extension ProgressHUD {

	func animationHorizontalBarScaling(_ view: UIView) {
		let width = view.frame.size.width
		let height = view.frame.size.height

		let lineWidth = width / 9

		let beginTime = CACurrentMediaTime()
		let beginTimes = [0.5, 0.4, 0.3, 0.2, 0.1]
		let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

		let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
		animation.keyTimes = [0, 0.5, 1]
		animation.timingFunctions = [timingFunction, timingFunction]
		animation.values = [0.9, 0.4, 0.9]
		animation.duration = 1
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: height), cornerRadius: width / 2)

		for i in 0..<5 {
			let layer = CAShapeLayer()
			layer.frame = CGRect(x: lineWidth * 2 * CGFloat(i), y: 0, width: lineWidth, height: height)
			layer.path = path.cgPath
			layer.backgroundColor = nil
			layer.fillColor = colorAnimation.cgColor

			animation.beginTime = beginTime - beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}
