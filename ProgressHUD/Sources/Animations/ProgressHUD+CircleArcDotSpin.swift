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

// MARK: - Circle Arc Dot Spin
extension ProgressHUD {

	func animationCircleArcDotSpin(_ view: UIView) {
		let space = view.frame.width / 8
		let x = view.bounds.minX + space / 2
		let y = view.bounds.minY + space / 2
		let width = view.frame.width - space
		let height = view.frame.height - space
		let containerView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
		view.addSubview(containerView)

		let center = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
		let radius = containerView.frame.width / 2
		let count = 8
		let duration = 4.0
		let size = radius / 3

		for i in 0..<count {
			let angle = (CGFloat(i) / CGFloat(count)) * (2 * .pi)
			let x = center.x + radius * cos(angle)
			let y = center.y + radius * sin(angle)

			let circle = UIView(frame: CGRect(x: x - size / 2, y: y - size / 2, width: size, height: size))
			circle.backgroundColor = colorAnimation
			circle.layer.cornerRadius = size / 2
			containerView.addSubview(circle)

			let animation = CAKeyframeAnimation(keyPath: "position")
			animation.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: angle, endAngle: angle + 2 * .pi, clockwise: true).cgPath
			animation.duration = duration
			animation.repeatCount = .infinity
			animation.calculationMode = .paced
			circle.layer.add(animation, forKey: "circleAnimation")
		}

		animateArcRotation(containerView)
	}

	private func animateArcRotation(_ view: UIView) {
		let width = view.frame.size.width
		let height = view.frame.size.height
		let center = CGPoint(x: width / 2, y: height / 2)

		let animationRotation = CABasicAnimation(keyPath: "transform.rotation")
		animationRotation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationRotation.byValue = 4 * Float.pi
		animationRotation.duration = 1.6

		let animationStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
		animationStrokeEnd.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationStrokeEnd.fromValue = 0.5
		animationStrokeEnd.toValue = 1
		animationStrokeEnd.duration = 0.8
		animationStrokeEnd.autoreverses = true
		animationStrokeEnd.isRemovedOnCompletion = false

		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [animationRotation, animationStrokeEnd]
		animationGroup.duration = 1.6
		animationGroup.repeatCount = .infinity
		animationGroup.fillMode = .forwards

		let path = UIBezierPath(arcCenter: center, radius: width / 2, startAngle: -.pi / 2, endAngle: 0, clockwise: true)

		let layer = CAShapeLayer()
		layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
		layer.path = path.cgPath
		layer.fillColor = nil
		layer.strokeColor = colorAnimation.cgColor
		layer.lineWidth = view.frame.width / 6
		layer.lineCap = .round

		layer.add(animationGroup, forKey: "animation")
		view.layer.addSublayer(layer)
	}
}
