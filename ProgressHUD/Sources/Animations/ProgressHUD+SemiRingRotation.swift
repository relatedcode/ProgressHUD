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

// MARK: - Semi-Ring Rotation
extension ProgressHUD {

	func animationSemiRingRotation(_ view: UIView) {
		let width = view.frame.size.width
		let sizeLarge = width
		let sizeSmall = width / 2
		let duration = 1.6

		drawCircleOf(.twoHalfRingsVertical, duration, view.layer, sizeSmall, true)
		drawCircleOf(.twoHalfRingsHorizontal, duration, view.layer, sizeLarge, false)
	}

	private func drawCircleOf(_ shape: ShapeType, _ duration: CFTimeInterval, _ layer: CALayer, _ size: CGFloat, _ reverse: Bool) {
		let animation = createAnimation(duration, reverse)
		let circle = shape.layerWith(CGSize(width: size, height: size))
		let x = (layer.bounds.size.width - size) / 2
		let y = (layer.bounds.size.height - size) / 2
		circle.frame = CGRect(x: x, y: y, width: size, height: size)
		circle.add(animation, forKey: "animation")
		layer.addSublayer(circle)
	}

	private func createAnimation(_ duration: CFTimeInterval, _ reverse: Bool) -> CAAnimation {
		let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

		let animationScale = CAKeyframeAnimation(keyPath: "transform.scale")
		animationScale.keyTimes = [0, 0.5, 1]
		animationScale.timingFunctions = [timingFunction, timingFunction]
		animationScale.values = [1, 0.6, 1]
		animationScale.duration = duration

		let animationRotate = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		animationRotate.keyTimes = animationScale.keyTimes
		animationRotate.timingFunctions = [timingFunction, timingFunction]
		animationRotate.values = reverse ? [0, -Double.pi, -2 * Double.pi] : [0, Double.pi, 2 * Double.pi]
		animationRotate.duration = duration

		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [animationScale, animationRotate]
		animationGroup.duration = duration
		animationGroup.repeatCount = .infinity
		return animationGroup
	}

	enum ShapeType {
		case twoHalfRingsVertical
		case twoHalfRingsHorizontal

		func layerWith(_ size: CGSize) -> CALayer {
			let width = size.width
			let height = size.height

			let radius = width / 2
			let pi4 = CGFloat.pi / 4
			let center = CGPoint(x: width / 2, y: height / 2)

			let layer = CAShapeLayer()
			layer.lineWidth = 6.0
			layer.fillColor = nil
			layer.strokeColor = colorAnimation.cgColor
			layer.backgroundColor = nil
			layer.lineCap = .round
			layer.frame = CGRect(x: 0, y: 0, width: width, height: height)

			let path = UIBezierPath()

			switch self {
			case .twoHalfRingsVertical:
				path.addArc(withCenter: center, radius: radius, startAngle: -3 * pi4, endAngle: -pi4, clockwise: true)
				path.move(to: CGPoint(x: width / 2 - width / 2 * cos(pi4), y: height / 2 + height / 2 * sin(pi4)))
				path.addArc(withCenter: center, radius: radius, startAngle: -5 * pi4, endAngle: -7 * pi4, clockwise: false)

			case .twoHalfRingsHorizontal:
				path.addArc(withCenter: center, radius: radius, startAngle: 3 * pi4, endAngle: 5 * pi4, clockwise: true)
				path.move(to: CGPoint(x: width / 2 + width / 2 * cos(pi4), y: height / 2 - height / 2 * sin(pi4)))
				path.addArc(withCenter: center, radius: radius, startAngle: -pi4, endAngle: pi4, clockwise: true)
			}

			layer.path = path.cgPath

			return layer
		}
	}
}
