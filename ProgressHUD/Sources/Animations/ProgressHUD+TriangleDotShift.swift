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

// MARK: - Triangle Dot Shift
extension ProgressHUD {

	func animationTriangleDotShift(_ view: UIView, _ color: UIColor) {
		let height = view.frame.size.height
		let width = view.frame.size.width
		let radius = width / 5
		var startY = radius
		var startX = radius

		for i in 0..<3 {
			if i == 1 {
				startX = width - radius
			}  else if i == 2 {
				startX = width / 2
				startY = height - radius
			}

			let center = CGPoint(x: startX, y: startY)
			let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)

			let layer = CAShapeLayer()
			layer.path = path.cgPath
			layer.fillColor = color.cgColor
			view.layer.addSublayer(layer)

			let animationGroup: CAAnimationGroup
			if i == 0 {
				animationGroup = moveRightAnimationGroup(targetValue: width - radius * 2)
			} else if i == 1 {
				animationGroup = moveBottomAnimationGroup(targetValue: width - radius * 2)
			} else {
				animationGroup = moveUpAnimationGroup(targetValue: width - radius * 2)
			}

			layer.add(animationGroup, forKey: "animation")
		}
	}

	private func moveRightAnimationGroup(targetValue: CGFloat) -> CAAnimationGroup {
		let animation = CABasicAnimation(keyPath: "position.x")
		animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animation.fromValue = 0
		animation.toValue = targetValue
		animation.duration = 0.6

		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [animation]
		animationGroup.duration = 0.6
		animationGroup.repeatCount = .infinity

		return animationGroup
	}

	private func moveBottomAnimationGroup(targetValue: CGFloat) -> CAAnimationGroup {
		let animationX = CABasicAnimation(keyPath: "position.y")
		animationX.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationX.fromValue = 0
		animationX.toValue = targetValue
		animationX.duration = 0.6

		let animationY = CABasicAnimation(keyPath: "position.x")
		animationY.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationY.fromValue = 0
		animationY.toValue = -targetValue / 2
		animationY.duration = 0.6

		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [animationX, animationY]
		animationGroup.duration = 0.6
		animationGroup.repeatCount = .infinity

		return animationGroup
	}

	private func moveUpAnimationGroup(targetValue: CGFloat) -> CAAnimationGroup {
		let animationX = CABasicAnimation(keyPath: "position.y")
		animationX.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationX.fromValue = 0
		animationX.toValue = -targetValue
		animationX.duration = 0.6

		let animationY = CABasicAnimation(keyPath: "position.x")
		animationY.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationY.fromValue = 0
		animationY.toValue = -targetValue / 2
		animationY.duration = 0.6

		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [animationX, animationY]
		animationGroup.duration = 0.6
		animationGroup.repeatCount = .infinity

		return animationGroup
	}
}
