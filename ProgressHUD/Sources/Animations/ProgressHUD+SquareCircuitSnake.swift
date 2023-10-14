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

// MARK: - Square Circuit Snake
extension ProgressHUD {

	func animationSquareCircuitSnake(_ view: UIView) {
		let space = view.frame.width / 6
		let x = view.bounds.minX + space / 2
		let y = view.bounds.minY + space / 2
		let width = view.frame.width - space
		let height = view.frame.height - space
		let containerView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
		view.addSubview(containerView)

		squareLoadingAnimation(containerView)
	}

	private func squareLoadingAnimation(_ view: UIView) {
		let width = view.frame.size.width
		let height = view.frame.size.height

		let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

		let animationEnd = CABasicAnimation(keyPath: "strokeEnd")
		animationEnd.timingFunction = timingFunction
		animationEnd.fromValue = 0.12
		animationEnd.toValue = 1.0
		animationEnd.duration = 1.0
		animationEnd.beginTime = 0.0

		let animationStart = CABasicAnimation(keyPath: "strokeStart")
		animationStart.timingFunction = timingFunction
		animationStart.fromValue = 0.0
		animationStart.toValue = 0.88
		animationStart.duration = 1.0
		animationStart.beginTime = 0.2

		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [animationStart, animationEnd]
		animationGroup.duration = 1.2
		animationGroup.repeatCount = .infinity

		let radius = 3.0
		let pi = CGFloat.pi
		let pi2 = CGFloat.pi / 2

		let path = UIBezierPath()
		path.move(to: CGPoint(x: width / 4.8, y: 0))
		path.addArc(withCenter: CGPoint(x: width - radius, y: radius), radius: radius, startAngle: -pi2, endAngle: 0, clockwise: true)
		path.addArc(withCenter: CGPoint(x: width - radius, y: height - radius), radius: radius, startAngle: 0, endAngle: pi2, clockwise: true)
		path.addArc(withCenter: CGPoint(x: radius, y: height - radius), radius: radius, startAngle: pi2, endAngle: pi, clockwise: true)
		path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: pi, endAngle: -pi2, clockwise: true)
		path.addLine(to: CGPoint(x: width / 1.35, y: 0))

		let rect = CGRect(x: 0, y: 0, width: width, height: height)

		let layerMove = createShapeLayer(rect, path, colorAnimation)
		layerMove.add(animationGroup, forKey: "animation")
		view.layer.addSublayer(layerMove)

		let layerBase = createShapeLayer(rect, path, colorAnimation.withAlphaComponent(0.3))
		view.layer.addSublayer(layerBase)
	}

	private func createShapeLayer(_ rect: CGRect, _ path: UIBezierPath, _ color: UIColor) -> CAShapeLayer {
		let layer = CAShapeLayer()
		layer.frame = rect
		layer.path = path.cgPath
		layer.fillColor = nil
		layer.strokeColor = color.cgColor
		layer.lineWidth = rect.width / 6
		layer.lineCap = .round
		return layer
	}
}
