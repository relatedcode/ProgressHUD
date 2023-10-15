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

// MARK: - Live Icon Succeed
extension ProgressHUD {

	func liveIconSucceed(_ view: UIView) {
		let length = view.frame.width
		let delay = (alpha == 0) ? 0.25 : 0.0

		let path = UIBezierPath()
		path.move(to: CGPoint(x: length * 0.15, y: length * 0.50))
		path.addLine(to: CGPoint(x: length * 0.5, y: length * 0.80))
		path.addLine(to: CGPoint(x: length * 1.0, y: length * 0.25))

		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = 0.25
		animation.fromValue = 0
		animation.toValue = 1
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.beginTime = CACurrentMediaTime() + delay

		let layer = CAShapeLayer()
		layer.path = path.cgPath
		layer.fillColor = UIColor.clear.cgColor
		layer.strokeColor = colorAnimation.cgColor
		layer.lineWidth = 9
		layer.lineCap = .round
		layer.lineJoin = .round
		layer.strokeEnd = 0

		layer.add(animation, forKey: "animation")
		view.layer.addSublayer(layer)
	}
}

// MARK: - Live Icon Failed
extension ProgressHUD {

	func liveIconFailed(_ view: UIView) {
		let length = view.frame.width
		let delay = (alpha == 0) ? 0.25 : 0.0

		let path1 = UIBezierPath()
		let path2 = UIBezierPath()

		path1.move(to: CGPoint(x: length * 0.15, y: length * 0.15))
		path2.move(to: CGPoint(x: length * 0.15, y: length * 0.85))

		path1.addLine(to: CGPoint(x: length * 0.85, y: length * 0.85))
		path2.addLine(to: CGPoint(x: length * 0.85, y: length * 0.15))

		let paths = [path1, path2]

		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = 0.15
		animation.fromValue = 0
		animation.toValue = 1
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false

		for i in 0..<2 {
			let layer = CAShapeLayer()
			layer.path = paths[i].cgPath
			layer.fillColor = UIColor.clear.cgColor
			layer.strokeColor = colorAnimation.cgColor
			layer.lineWidth = 9
			layer.lineCap = .round
			layer.lineJoin = .round
			layer.strokeEnd = 0

			animation.beginTime = CACurrentMediaTime() + 0.25 * Double(i) + delay

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}

// MARK: - Live Icon Added
extension ProgressHUD {

	func liveIconAdded(_ view: UIView) {
		let length = view.frame.width
		let delay = (alpha == 0) ? 0.25 : 0.0

		let path1 = UIBezierPath()
		let path2 = UIBezierPath()

		path1.move(to: CGPoint(x: length * 0.1, y: length * 0.5))
		path2.move(to: CGPoint(x: length * 0.5, y: length * 0.1))

		path1.addLine(to: CGPoint(x: length * 0.9, y: length * 0.5))
		path2.addLine(to: CGPoint(x: length * 0.5, y: length * 0.9))

		let paths = [path1, path2]

		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = 0.15
		animation.fromValue = 0
		animation.toValue = 1
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false

		for i in 0..<2 {
			let layer = CAShapeLayer()
			layer.path = paths[i].cgPath
			layer.fillColor = UIColor.clear.cgColor
			layer.strokeColor = colorAnimation.cgColor
			layer.lineWidth = 9
			layer.lineCap = .round
			layer.lineJoin = .round
			layer.strokeEnd = 0

			animation.beginTime = CACurrentMediaTime() + 0.25 * Double(i) + delay

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}
}
