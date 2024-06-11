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

// MARK: - Circle Dot Spin Fade
extension ProgressHUD {

	func animationCircleDotSpinFade(_ view: UIView) {
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
			layer.fillColor = colorAnimation.cgColor
			layer.backgroundColor = nil
			layer.frame = CGRect(x: radiusX * (cos(angle) + 1), y: radiusX * (sin(angle) + 1), width: radius, height: radius)

			animation.beginTime = beginTime - beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}
