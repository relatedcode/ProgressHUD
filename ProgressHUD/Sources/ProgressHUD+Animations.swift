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

// MARK: - System Activity Indicator
extension ProgressHUD {

	func animationSystemActivityIndicator(_ view: UIView, _ color: UIColor) {
		let spinner = UIActivityIndicatorView(style: .large)
		let scale = view.frame.size.width / spinner.frame.size.width
		spinner.transform = CGAffineTransform(scaleX: scale, y: scale)
		spinner.frame = view.bounds
		spinner.color = color
		spinner.hidesWhenStopped = true
		spinner.startAnimating()
		view.addSubview(spinner)
	}
}

// MARK: - Horizontal Circles Pulse
extension ProgressHUD {

	func animationHorizontalCirclesPulse(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width
		let height = view.frame.size.height

		let spacing = 3.0
		let radius = (width - spacing * 2) / 3
		let center = CGPoint(x: radius / 2, y: radius / 2)
		let positionY = (height - radius) / 2

		let beginTime = CACurrentMediaTime()
		let beginTimes = [0.36, 0.24, 0.12]
		let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

		let animation = CAKeyframeAnimation(keyPath: "transform.scale")
		animation.keyTimes = [0, 0.5, 1]
		animation.timingFunctions = [timingFunction, timingFunction]
		animation.values = [1, 0.3, 1]
		animation.duration = 1
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: center, radius: radius / 2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<3 {
			let layer = CAShapeLayer()
			layer.frame = CGRect(x: (radius + spacing) * CGFloat(i), y: positionY, width: radius, height: radius)
			layer.path = path.cgPath
			layer.fillColor = color.cgColor

			animation.beginTime = beginTime - beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}

// MARK: - Line Scaling
extension ProgressHUD {

	func animationLineScaling(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width
		let height = view.frame.size.height

		let lineWidth = width / 9

		let beginTime = CACurrentMediaTime()
		let beginTimes = [0.5, 0.4, 0.3, 0.2, 0.1]
		let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

		let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
		animation.keyTimes = [0, 0.5, 1]
		animation.timingFunctions = [timingFunction, timingFunction]
		animation.values = [1, 0.4, 1]
		animation.duration = 1
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: height), cornerRadius: width / 2)

		for i in 0..<5 {
			let layer = CAShapeLayer()
			layer.frame = CGRect(x: lineWidth * 2 * CGFloat(i), y: 0, width: lineWidth, height: height)
			layer.path = path.cgPath
			layer.backgroundColor = nil
			layer.fillColor = color.cgColor

			animation.beginTime = beginTime - beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}

// MARK: - Single Circle Pulse
extension ProgressHUD {

	func animationSingleCirclePulse(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width
		let height = view.frame.size.height
		let center = CGPoint(x: width / 2, y: height / 2)
		let radius = width / 2

		let duration = 1.0

		let animationScale = CABasicAnimation(keyPath: "transform.scale")
		animationScale.duration = duration
		animationScale.fromValue = 0
		animationScale.toValue = 1

		let animationOpacity = CABasicAnimation(keyPath: "opacity")
		animationOpacity.duration = duration
		animationOpacity.fromValue = 1
		animationOpacity.toValue = 0

		let animation = CAAnimationGroup()
		animation.animations = [animationScale, animationOpacity]
		animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animation.duration = duration
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		let layer = CAShapeLayer()
		layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
		layer.path = path.cgPath
		layer.fillColor = color.cgColor

		layer.add(animation, forKey: "animation")
		view.layer.addSublayer(layer)
	}
}

// MARK: - Multiple Circle Pulse
extension ProgressHUD {

	func animationMultipleCirclePulse(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width
		let height = view.frame.size.height
		let center = CGPoint(x: width / 2, y: height / 2)
		let radius = width / 2

		let duration = 1.0
		let beginTime = CACurrentMediaTime()
		let beginTimes = [0, 0.3, 0.6]

		let animationScale = CABasicAnimation(keyPath: "transform.scale")
		animationScale.duration = duration
		animationScale.fromValue = 0
		animationScale.toValue = 1

		let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
		animationOpacity.duration = duration
		animationOpacity.keyTimes = [0, 0.05, 1]
		animationOpacity.values = [0, 1, 0]

		let animation = CAAnimationGroup()
		animation.animations = [animationScale, animationOpacity]
		animation.timingFunction = CAMediaTimingFunction(name: .linear)
		animation.duration = duration
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<3 {
			let layer = CAShapeLayer()
			layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
			layer.path = path.cgPath
			layer.fillColor = color.cgColor
			layer.opacity = 0

			animation.beginTime = beginTime + beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}

// MARK: - Single Circle Scale Ripple
extension ProgressHUD {

	func animationSingleCircleScaleRipple(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width
		let height = view.frame.size.height
		let center = CGPoint(x: width / 2, y: height / 2)
		let radius = width / 2

		let duration = 1.0
		let timingFunction = CAMediaTimingFunction(controlPoints: 0.21, 0.53, 0.56, 0.8)

		let animationScale = CAKeyframeAnimation(keyPath: "transform.scale")
		animationScale.keyTimes = [0, 0.7]
		animationScale.timingFunction = timingFunction
		animationScale.values = [0.1, 1]
		animationScale.duration = duration

		let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
		animationOpacity.keyTimes = [0, 0.7, 1]
		animationOpacity.timingFunctions = [timingFunction, timingFunction]
		animationOpacity.values = [1, 0.7, 0]
		animationOpacity.duration = duration

		let animation = CAAnimationGroup()
		animation.animations = [animationScale, animationOpacity]
		animation.duration = duration
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		let layer = CAShapeLayer()
		layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
		layer.path = path.cgPath
		layer.backgroundColor = nil
		layer.fillColor = nil
		layer.strokeColor = color.cgColor
		layer.lineWidth = 3

		layer.add(animation, forKey: "animation")
		view.layer.addSublayer(layer)
	}
}

// MARK: - Multiple Circle Scale Ripple
extension ProgressHUD {

	func animationMultipleCircleScaleRipple(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width
		let height = view.frame.size.height
		let center = CGPoint(x: width / 2, y: height / 2)
		let radius = width / 2

		let duration = 1.25
		let beginTime = CACurrentMediaTime()
		let beginTimes = [0, 0.2, 0.4]
		let timingFunction = CAMediaTimingFunction(controlPoints: 0.21, 0.53, 0.56, 0.8)

		let animationScale = CAKeyframeAnimation(keyPath: "transform.scale")
		animationScale.keyTimes = [0, 0.7]
		animationScale.timingFunction = timingFunction
		animationScale.values = [0, 1]
		animationScale.duration = duration

		let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
		animationOpacity.keyTimes = [0, 0.7, 1]
		animationOpacity.timingFunctions = [timingFunction, timingFunction]
		animationOpacity.values = [1, 0.7, 0]
		animationOpacity.duration = duration

		let animation = CAAnimationGroup()
		animation.animations = [animationScale, animationOpacity]
		animation.duration = duration
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<3 {
			let layer = CAShapeLayer()
			layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
			layer.path = path.cgPath
			layer.backgroundColor = nil
			layer.strokeColor = color.cgColor
			layer.lineWidth = 3
			layer.fillColor = nil

			animation.beginTime = beginTime + beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}

// MARK: - Circle Spin Fade
extension ProgressHUD {

	func animationCircleSpinFade(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width

		let spacing = 3.0
		let radius = (width - 4 * spacing) / 3.5
		let radiusX = (width - radius) / 2
		let center = CGPoint(x: radius / 2, y: radius / 2)

		let duration = 1.0
		let beginTime = CACurrentMediaTime()
		let beginTimes: [CFTimeInterval] = [0.84, 0.72, 0.6, 0.48, 0.36, 0.24, 0.12, 0]

		let animationScale = CAKeyframeAnimation(keyPath: "transform.scale")
		animationScale.keyTimes = [0, 0.5, 1]
		animationScale.values = [1, 0.4, 1]
		animationScale.duration = duration

		let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
		animationOpacity.keyTimes = [0, 0.5, 1]
		animationOpacity.values = [1, 0.3, 1]
		animationOpacity.duration = duration

		let animation = CAAnimationGroup()
		animation.animations = [animationScale, animationOpacity]
		animation.timingFunction = CAMediaTimingFunction(name: .linear)
		animation.duration = duration
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: center, radius: radius / 2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<8 {
			let angle = .pi / 4 * CGFloat(i)

			let layer = CAShapeLayer()
			layer.path = path.cgPath
			layer.fillColor = color.cgColor
			layer.backgroundColor = nil
			layer.frame = CGRect(x: radiusX * (cos(angle) + 1), y: radiusX * (sin(angle) + 1), width: radius, height: radius)

			animation.beginTime = beginTime - beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}

// MARK: - Line Spin Fade
extension ProgressHUD {

	func animationLineSpinFade(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width
		let height = view.frame.size.height

		let spacing = 3.0
		let lineWidth = (width - 4 * spacing) / 5
		let lineHeight = (height - 2 * spacing) / 3
		let containerSize = max(lineWidth, lineHeight)
		let radius = width / 2 - containerSize / 2

		let duration = 1.2
		let beginTime = CACurrentMediaTime()
		let beginTimes: [CFTimeInterval] = [0.96, 0.84, 0.72, 0.6, 0.48, 0.36, 0.24, 0.12]
		let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

		let animation = CAKeyframeAnimation(keyPath: "opacity")
		animation.keyTimes = [0, 0.5, 1]
		animation.timingFunctions = [timingFunction, timingFunction]
		animation.values = [1, 0.3, 1]
		animation.duration = duration
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: lineHeight), cornerRadius: lineWidth / 2)

		for i in 0..<8 {
			let angle = .pi / 4 * CGFloat(i)

			let line = CAShapeLayer()
			line.frame = CGRect(x: (containerSize - lineWidth) / 2, y: (containerSize - lineHeight) / 2, width: lineWidth, height: lineHeight)
			line.path = path.cgPath
			line.backgroundColor = nil
			line.fillColor = color.cgColor

			let container = CALayer()
			container.frame = CGRect(x: radius * (cos(angle) + 1), y: radius * (sin(angle) + 1), width: containerSize, height: containerSize)
			container.addSublayer(line)
			container.sublayerTransform = CATransform3DMakeRotation(.pi / 2 + angle, 0, 0, 1)

			animation.beginTime = beginTime - beginTimes[i]

			container.add(animation, forKey: "animation")
			view.layer.addSublayer(container)
		}
	}
}

// MARK: - Circle Rotate Chase
extension ProgressHUD {

	func animationCircleRotateChase(_ view: UIView, _ color: UIColor) {
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
			layer.fillColor = color.cgColor

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}

// MARK: - Circle Stroke Spin
extension ProgressHUD {

	func animationCircleStrokeSpin(_ view: UIView, _ color: UIColor) {
		let width = view.frame.size.width
		let height = view.frame.size.height
		let center = CGPoint(x: width / 2, y: height / 2)

		let beginTime		= 0.5
		let durationStart	= 1.2
		let durationStop	= 0.7

		let animationRotation = CABasicAnimation(keyPath: "transform.rotation")
		animationRotation.byValue = 2 * Float.pi
		animationRotation.timingFunction = CAMediaTimingFunction(name: .linear)

		let animationStart = CABasicAnimation(keyPath: "strokeStart")
		animationStart.duration = durationStart
		animationStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
		animationStart.fromValue = 0
		animationStart.toValue = 1
		animationStart.beginTime = beginTime

		let animationStop = CABasicAnimation(keyPath: "strokeEnd")
		animationStop.duration = durationStop
		animationStop.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
		animationStop.fromValue = 0
		animationStop.toValue = 1

		let animation = CAAnimationGroup()
		animation.animations = [animationRotation, animationStop, animationStart]
		animation.duration = durationStart + beginTime
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false
		animation.fillMode = .forwards

		let path = UIBezierPath(arcCenter: center, radius: width / 2, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

		let layer = CAShapeLayer()
		layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
		layer.path = path.cgPath
		layer.fillColor = nil
		layer.strokeColor = color.cgColor
		layer.lineWidth = 3

		layer.add(animation, forKey: "animation")
		view.layer.addSublayer(layer)
	}
}
