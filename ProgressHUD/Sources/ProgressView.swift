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

class ProgressView: UIView {

	var color: UIColor = .systemBackground {
		didSet { setupLayers() }
	}

	private var progress: CGFloat = 0

	private var layerCircle = CAShapeLayer()
	private var layerProgress = CAShapeLayer()
	private var labelPercentage: UILabel = UILabel()

	convenience init(_ color: UIColor) {
		self.init(frame: .zero)
		self.color = color
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	override func draw(_ rect: CGRect) {
		super.draw(rect)
		setupLayers()
	}

	private func setupLayers() {
		subviews.forEach { $0.removeFromSuperview() }
		layer.sublayers?.forEach { $0.removeFromSuperlayer() }

		let width = frame.size.width
		let height = frame.size.height
		let center = CGPoint(x: width / 2, y: height / 2)

		let radiusCircle = width / 2
		let radiusProgress = width / 2 - 5

		let pathCircle = UIBezierPath(arcCenter: center, radius: radiusCircle, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
		let pathProgress = UIBezierPath(arcCenter: center, radius: radiusProgress, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

		layerCircle.path = pathCircle.cgPath
		layerCircle.fillColor = UIColor.clear.cgColor
		layerCircle.lineWidth = 3
		layerCircle.strokeColor = color.cgColor

		layerProgress.path = pathProgress.cgPath
		layerProgress.fillColor = UIColor.clear.cgColor
		layerProgress.lineWidth = 7
		layerProgress.strokeColor = color.cgColor
		layerProgress.strokeEnd = 0

		layer.addSublayer(layerCircle)
		layer.addSublayer(layerProgress)

		labelPercentage.frame = bounds
		labelPercentage.textColor = color
		labelPercentage.textAlignment = .center
		addSubview(labelPercentage)
	}

	func setProgress(_ value: CGFloat) {
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = 0.2
		animation.fromValue = progress
		animation.toValue = value
		animation.fillMode = .both
		animation.isRemovedOnCompletion = false
		layerProgress.add(animation, forKey: "animation")

		progress = value
		labelPercentage.text = "\(Int(value*100))%"
	}
}
