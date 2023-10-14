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

// MARK: - Circle Rotate Chase
extension ProgressHUD {

	func animationCircleRotateChase(_ view: UIView) {
		let width = view.frame.size.width
		let height = view.frame.size.height
		let center1 = CGPoint(x: width / 2, y: height / 2)

		let spacing = 3.0
		let radius = (width - 4 * spacing) / 4
		let center2 = CGPoint(x: radius / 2, y: radius / 2)

		let duration = 1.5

		let path1 = UIBezierPath(arcCenter: center1, radius: radius * 2, startAngle: 1.5 * .pi, endAngle: 3.5 * .pi, clockwise: true)
		let path2 = UIBezierPath(arcCenter: center2, radius: radius / 2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<5 {
			let rate = Float(i) * 1 / 5
			let fromScale = 1 - rate
			let toScale = 0.2 + rate

			let animationScale = CABasicAnimation(keyPath: "transform.scale")
			animationScale.duration = duration
			animationScale.repeatCount = .infinity
			animationScale.fromValue = fromScale
			animationScale.toValue = toScale

			let animationPosition = CAKeyframeAnimation(keyPath: "position")
			animationPosition.duration = duration
			animationPosition.repeatCount = .infinity
			animationPosition.path = path1.cgPath

			let animation = CAAnimationGroup()
			animation.animations = [animationScale, animationPosition]
			animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + rate, 0.25, 1)

			animation.duration = duration
			animation.repeatCount = .infinity
			animation.isRemovedOnCompletion = false

			let layer = CAShapeLayer()
			layer.frame = CGRect(x: 0, y: 0, width: radius, height: radius)
			layer.path = path2.cgPath
			layer.fillColor = colorAnimation.cgColor

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}
