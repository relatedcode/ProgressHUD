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

// MARK: - Dual Dot Sidestep
extension ProgressHUD {

	func animationDualDotSidestep(_ view: UIView) {
		let width = view.frame.size.width
		let height = view.frame.size.height
		let radius = width / 4
		let startY = height / 2
		let startX = radius
		let lineWidth = 3.0

		let hollowCircle = createCircleLayer(CGPoint(x: startX, y: startY), radius - lineWidth / 2, false, view, lineWidth)

		let filledCircle = createCircleLayer(CGPoint(x: width - startX, y: startY), radius, true, view, lineWidth)

		let animationGroup1 = moveAnimationGroup(width - radius * 2)
		hollowCircle.add(animationGroup1, forKey: "animation")

		let animationGroup2 = moveAnimationGroup(-(width - radius * 2))
		filledCircle.add(animationGroup2, forKey: "animation")

		let zPositionAnimation1 = createZPositionAnimation(0, 1)
		hollowCircle.add(zPositionAnimation1, forKey: "zPositionAnimation")

		let zPositionAnimation2 = createZPositionAnimation(1, 0)
		filledCircle.add(zPositionAnimation2, forKey: "zPositionAnimation")
	}

	private func createCircleLayer(_ center: CGPoint, _ radius: CGFloat, _ filled: Bool, _ view: UIView, _ lineWidth: Double) -> CAShapeLayer {
		let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)

		let layer = CAShapeLayer()
		layer.path = path.cgPath
		layer.strokeColor = filled ? UIColor.clear.cgColor : colorAnimation.cgColor
		layer.fillColor = filled ? colorAnimation.cgColor : UIColor.clear.cgColor
		layer.lineWidth = filled ? 0.0 : lineWidth
		layer.zPosition = filled ? 1.0 : 0.0
		view.layer.addSublayer(layer)

		return layer
	}

	private func createZPositionAnimation(_ fromValue: CGFloat, _ toValue: CGFloat) -> CAKeyframeAnimation {
		let animation = CAKeyframeAnimation(keyPath: "zPosition")
		animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animation.values = [fromValue, toValue]
		animation.duration = 2.0
		animation.repeatCount = .infinity

		return animation
	}

	private func moveAnimationGroup(_ toValue: CGFloat) -> CAAnimationGroup {
		let animation = CABasicAnimation(keyPath: "position.x")
		animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animation.fromValue = 0
		animation.toValue = toValue
		animation.duration = 1.0
		animation.autoreverses = true

		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [animation]
		animationGroup.duration = 2.0
		animationGroup.repeatCount = .infinity

		return animationGroup
	}
}
