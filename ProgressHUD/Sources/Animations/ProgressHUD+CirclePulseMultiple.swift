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

// MARK: - Circle Pulse Multiple
extension ProgressHUD {

	func animationCirclePulseMultiple(_ view: UIView) {
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
			layer.fillColor = colorAnimation.cgColor
			layer.opacity = 0

			animation.beginTime = beginTime + beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}
