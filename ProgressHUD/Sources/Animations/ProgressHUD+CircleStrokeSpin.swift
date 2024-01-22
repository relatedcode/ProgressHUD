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

// MARK: - Circle Stroke Spin
extension ProgressHUD {

	func animationCircleStrokeSpin(_ view: UIView) {
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
		layer.strokeColor = colorAnimation.cgColor
		layer.lineWidth = 3

		layer.add(animation, forKey: "animation")
		view.layer.addSublayer(layer)
	}
}
