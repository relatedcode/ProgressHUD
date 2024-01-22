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

// MARK: - Bar Sweep Toggle
extension ProgressHUD {

	func animationBarSweepToggle(_ view: UIView) {
		let height = view.frame.size.height
		let width = view.frame.size.width

		let border = 5.0
		let duration = 0.9
		let heightBar = height / 6
		let widthBar = width - heightBar / 2

		let pathBar = UIBezierPath()
		pathBar.move(to: CGPoint(x: heightBar / 2, y: height / 2))
		pathBar.addLine(to: CGPoint(x: widthBar / 2, y: height / 2))

		let layerBar = CAShapeLayer()
		layerBar.path = pathBar.cgPath
		layerBar.strokeColor = colorAnimation.cgColor
		layerBar.lineWidth = heightBar
		layerBar.lineCap = .round
		view.layer.addSublayer(layerBar)

		let animationGroup = CAAnimationGroup()
		animationGroup.duration = duration
		animationGroup.autoreverses = true
		animationGroup.repeatCount = .infinity

		let animationStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
		animationStrokeEnd.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationStrokeEnd.fromValue = 0.0
		animationStrokeEnd.toValue = 1.0
		animationStrokeEnd.duration = duration / 2

		let animationStrokeStart = CABasicAnimation(keyPath: "strokeStart")
		animationStrokeStart.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationStrokeStart.fromValue = 0.0
		animationStrokeStart.toValue = 1.0
		animationStrokeStart.duration = duration / 2
		animationStrokeStart.beginTime = duration / 2

		animationGroup.animations = [animationStrokeEnd, animationStrokeStart]
		layerBar.add(animationGroup, forKey: "group")

		let animationPosition = CABasicAnimation(keyPath: "transform.translation.x")
		animationPosition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationPosition.fromValue = 0
		animationPosition.toValue = widthBar / 2
		animationPosition.duration = duration
		animationPosition.autoreverses = true
		animationPosition.repeatCount = .infinity
		layerBar.add(animationPosition, forKey: "position")

		let frame = CGRect(x: -border, y: (height - heightBar) / 2 - border, width: width + 2 * border, height: heightBar + 2 * border)
		let pathBorder = UIBezierPath(roundedRect: frame, cornerRadius: height)

		let layerBorder = CAShapeLayer()
		layerBorder.path = pathBorder.cgPath
		layerBorder.strokeColor = colorAnimation.cgColor
		layerBorder.fillColor = UIColor.clear.cgColor
		layerBorder.lineWidth = border
		view.layer.addSublayer(layerBorder)
	}
}
