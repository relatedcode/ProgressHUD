//
// Copyright (c) 2020 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
public enum AnimationType {

	case systemActivityIndicator
	case horizontalCirclesPulse
	case lineScalling
	case singleCirclePulse
	case multipleCirclePulse
	case singleCircleScaleRipple
	case multipleCircleScaleRipple
	case circleSpinFade
	case lineSpinFade
	case circleRotateChase
	case circleStrokeSpin
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
public enum AnimatedIcon {

	case succeed
	case failed
	case added
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
public enum AlertIcon {

	case heart
	case doc
	case bookmark
	case moon
	case star
	case exclamation
	case flag
	case message
	case question
	case bolt
	case shuffle
	case eject
	case card
	case rotate
	case like
	case dislike
	case privacy
	case cart
	case search
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
extension AlertIcon {

	var image: UIImage? {
		switch self {
			case .heart:		return UIImage(systemName: "heart.fill")
			case .doc:			return UIImage(systemName: "doc.fill")
			case .bookmark:		return UIImage(systemName: "bookmark.fill")
			case .moon:			return UIImage(systemName: "moon.fill")
			case .star:			return UIImage(systemName: "star.fill")
			case .exclamation:	return UIImage(systemName: "exclamationmark.triangle.fill")
			case .flag:			return UIImage(systemName: "flag.fill")
			case .message:		return UIImage(systemName: "envelope.fill")
			case .question:		return UIImage(systemName: "questionmark.diamond.fill")
			case .bolt:			return UIImage(systemName: "bolt.fill")
			case .shuffle:		return UIImage(systemName: "shuffle")
			case .eject:		return UIImage(systemName: "eject.fill")
			case .card:			return UIImage(systemName: "creditcard.fill")
			case .rotate:		return UIImage(systemName: "rotate.right.fill")
			case .like:			return UIImage(systemName: "hand.thumbsup.fill")
			case .dislike:		return UIImage(systemName: "hand.thumbsdown.fill")
			case .privacy:		return UIImage(systemName: "hand.raised.fill")
			case .cart:			return UIImage(systemName: "cart.fill")
			case .search:		return UIImage(systemName: "magnifyingglass")
		}
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
public extension ProgressHUD {

	class var animationType: AnimationType {
		get { shared.animationType }
		set { shared.animationType = newValue }
	}

	class var colorHUD: UIColor {
		get { shared.colorHUD }
		set { shared.colorHUD = newValue }
	}

	class var colorBackground: UIColor {
		get { shared.colorBackground }
		set { shared.colorBackground = newValue }
	}

	class var colorAnimation: UIColor {
		get { shared.colorAnimation }
		set { shared.colorAnimation = newValue }
	}

	class var colorProgress: UIColor {
		get { shared.colorProgress }
		set { shared.colorProgress = newValue }
	}

	class var colorStatus: UIColor {
		get { shared.colorStatus }
		set { shared.colorStatus = newValue }
	}

	class var fontStatus: UIFont {
		get { shared.fontStatus }
		set { shared.fontStatus = newValue }
	}

	class var imageSuccess: UIImage? {
		get { shared.imageSuccess }
		set { shared.imageSuccess = newValue }
	}

	class var imageError: UIImage? {
		get { shared.imageError }
		set { shared.imageError = newValue }
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
public extension ProgressHUD {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func dismiss() {

		DispatchQueue.main.async {
			shared.hudHide()
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func show(_ status: String? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.hudCreate(status: status, image: nil, hide: false, interaction: interaction)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func show(_ status: String? = nil, icon: AlertIcon, interaction: Bool = true) {

		let image = icon.image?.withTintColor(shared.colorAnimation, renderingMode: .alwaysOriginal)

		DispatchQueue.main.async {
			shared.hudCreate(status: status, image: image, hide: true, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func show(_ status: String? = nil, icon animatedIcon: AnimatedIcon, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.hudCreate(status: status, image: nil, animatedIcon: animatedIcon, hide: true, interaction: interaction)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showSuccess(_ status: String? = nil, image: UIImage? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.hudCreate(status: status, image: image ?? shared.imageSuccess, hide: true, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showError(_ status: String? = nil, image: UIImage? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.hudCreate(status: status, image: image ?? shared.imageError, hide: true, interaction: interaction)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showSucceed(_ status: String? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.hudCreate(status: status, image: nil, animatedIcon: .succeed, hide: true, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showFailed(_ status: String? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.hudCreate(status: status, image: nil, animatedIcon: .failed, hide: true, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showAdded(_ status: String? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.hudCreate(status: status, image: nil, animatedIcon: .added, hide: true, interaction: interaction)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showProgress(_ progress: CGFloat, interaction: Bool = false) {

		DispatchQueue.main.async {
			shared.hudCreate(progress: progress, hide: false, interaction: interaction)
		}
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
public class ProgressHUD: UIView {

	private var mainWindow: UIWindow!
	private var viewBackground: UIView!
	private var toolbarHUD: UIToolbar!

	private var viewAnimated: ProgressHUDAnimationView?
	private var viewProgress: ProgressHUDProgressView?
	private var imageView: UIImageView?

	private var labelStatus: UILabel!
	private var timer: Timer?

	private var animationType: AnimationType = .systemActivityIndicator {
		didSet { viewAnimated?.animationType = self.animationType }
	}

	private var colorHUD: UIColor!
	private var colorBackground: UIColor!
	private var colorAnimation: UIColor!
	private var colorProgress: UIColor!
	private var colorStatus: UIColor!

	private var fontStatus: UIFont!
	private var imageSuccess: UIImage!
	private var imageError: UIImage!

	private static var shared = ProgressHUD()

	private let keyboardWillShow	= UIResponder.keyboardWillShowNotification
	private let keyboardWillHide	= UIResponder.keyboardWillHideNotification
	private let keyboardDidShow		= UIResponder.keyboardDidShowNotification
	private let keyboardDidHide		= UIResponder.keyboardDidHideNotification

	private let orientationDidChange = UIDevice.orientationDidChangeNotification

	//---------------------------------------------------------------------------------------------------------------------------------------------
	convenience private init() {

		self.init(frame: UIScreen.main.bounds)

		colorHUD = UIColor.systemGray
		colorBackground = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
		colorAnimation = UIColor.lightGray
		colorProgress = UIColor.lightGray
		colorStatus = UIColor.label

		fontStatus = UIFont.boldSystemFont(ofSize: 24)
		imageSuccess = UIImage.checkmark.withTintColor(UIColor.systemGreen, renderingMode: .alwaysOriginal)
		imageError = UIImage.remove.withTintColor(UIColor.systemRed, renderingMode: .alwaysOriginal)

		mainWindow = UIApplication.shared.windows.first!

		self.alpha = 0
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	required internal init?(coder: NSCoder) {

		super.init(coder: coder)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override private init(frame: CGRect) {

		super.init(frame: frame)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func hudCreate(status: String? = nil, image: UIImage? = nil, animatedIcon: AnimatedIcon? = nil, progress: CGFloat? = nil, hide: Bool, interaction: Bool) {

		if (viewBackground == nil) {
			viewBackground = UIView()
			viewBackground.frame = self.bounds
			mainWindow.addSubview(viewBackground)
		}

		viewBackground.backgroundColor = interaction ? .clear : colorBackground
		viewBackground.isUserInteractionEnabled = (interaction == false)

		if (toolbarHUD == nil) {
			toolbarHUD = UIToolbar(frame: CGRect.zero)
			toolbarHUD.isTranslucent = true
			toolbarHUD.clipsToBounds = true
			toolbarHUD.layer.cornerRadius = 10
			toolbarHUD.layer.masksToBounds = true
			viewBackground.addSubview(toolbarHUD)
			registerNotifications()
		}

		toolbarHUD.backgroundColor = colorHUD

		if (labelStatus == nil) {
			labelStatus = UILabel(frame: CGRect.zero)
			labelStatus.textAlignment = .center
			labelStatus.baselineAdjustment = .alignCenters
			labelStatus.numberOfLines = 0
			toolbarHUD.addSubview(labelStatus)
		}

		labelStatus.text = status
		labelStatus.font = fontStatus
		labelStatus.textColor = colorStatus
		labelStatus.isHidden = (status == nil) ? true : false

		if (progress == nil) && (image != nil) {
			viewAnimated?.removeFromSuperview()
			viewProgress?.removeFromSuperview()

			if (imageView == nil) {
				imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
			}

			imageView?.image = image
			imageView?.contentMode = .scaleAspectFit

			if (imageView?.superview == nil) {
				toolbarHUD.addSubview(imageView!)
			}
		}

		if (progress == nil) && (image == nil) {
			viewProgress?.removeFromSuperview()
			imageView?.removeFromSuperview()

			if (viewAnimated == nil) {
				viewAnimated = ProgressHUDAnimationView(color: colorAnimation)
				viewAnimated?.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
			}

			viewAnimated?.animationType = animationType
			viewAnimated?.animatedIcon = animatedIcon

			if (viewAnimated?.superview == nil) {
				toolbarHUD.addSubview(viewAnimated!)
			}
		}

		if (progress != nil) {
			viewAnimated?.removeFromSuperview()
			imageView?.removeFromSuperview()

			if (viewProgress == nil) {
				viewProgress = ProgressHUDProgressView(colorProgress)
				viewProgress?.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
			}

			viewProgress?.setProgress(progress!)

			if (viewProgress?.superview == nil) {
				toolbarHUD.addSubview(viewProgress!)
			}
		}

		hudSize()
		hudPosition(nil)
		hudShow()

		if (hide) {
			hudHideTimer()
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func registerNotifications() {

		NotificationCenter.default.addObserver(self, selector: #selector(hudPosition(_:)), name: keyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(hudPosition(_:)), name: keyboardWillHide, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(hudPosition(_:)), name: keyboardDidShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(hudPosition(_:)), name: keyboardDidHide, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(hudPosition(_:)), name: orientationDidChange, object: nil)
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func hudSize() {

		var rectLabel = CGRect.zero
		var widthHUD: CGFloat = 120
		var heightHUD: CGFloat = 120

		if (labelStatus.text != nil) && (labelStatus.text != "") {

			let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: labelStatus.font as Any]
			rectLabel = labelStatus.text!.boundingRect(with: CGSize(width: 200, height: 300), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

			widthHUD = ceil(rectLabel.size.width) + 60
			heightHUD = ceil(rectLabel.size.height) + 120

			if (widthHUD < 120) { widthHUD = 120 }
			if (heightHUD < 120) { heightHUD = 120 }

			rectLabel.origin.x = (widthHUD - rectLabel.size.width) / 2
			rectLabel.origin.y = (heightHUD - rectLabel.size.height) / 2 + 45
		}

		toolbarHUD.bounds = CGRect(x: 0, y: 0, width: widthHUD, height: heightHUD)

		let imageX: CGFloat = widthHUD/2
		let imageY: CGFloat = (labelStatus.text == nil) ? heightHUD/2 : 55

		viewAnimated?.center = CGPoint(x: imageX, y: imageY)
		viewProgress?.center = CGPoint(x: imageX, y: imageY)
		imageView?.center = CGPoint(x: imageX, y: imageY)

		labelStatus.frame = rectLabel
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc private func hudPosition(_ notification: Notification?) {

		var heightKeyboard: CGFloat = 0
		var animationDuration: TimeInterval = 0

		if let notification = notification {
			let frameKeyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? CGRect.zero
			animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0

			if (notification.name == keyboardWillShow) || (notification.name == keyboardDidShow) {
				heightKeyboard = frameKeyboard.size.height
			} else if (notification.name == keyboardWillHide) || (notification.name == keyboardDidHide) {
				heightKeyboard = 0
			} else {
				heightKeyboard = keyboardHeight()
			}
		} else {
			heightKeyboard = keyboardHeight()
		}

		let screen = UIScreen.main.bounds
		let center = CGPoint(x: screen.size.width/2, y: (screen.size.height-heightKeyboard)/2)

		UIView.animate(withDuration: animationDuration, delay: 0, options: .allowUserInteraction, animations: {
			self.toolbarHUD.center = center
			self.viewBackground.frame = self.mainWindow.frame
		}, completion: nil)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func keyboardHeight() -> CGFloat {

		if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
			let inputSetContainerView = NSClassFromString("UIInputSetContainerView"),
			let inputSetHostView = NSClassFromString("UIInputSetHostView") {

			for window in UIApplication.shared.windows {
				if window.isKind(of: keyboardWindowClass) {
					for firstSubView in window.subviews {
						if firstSubView.isKind(of: inputSetContainerView) {
							for secondSubView in firstSubView.subviews {
								if secondSubView.isKind(of: inputSetHostView) {
									return secondSubView.frame.size.height
								}
							}
						}
					}
				}
			}
		}
		return 0
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func hudShow() {

		timer?.invalidate()
		timer = nil

		if (self.alpha != 1) {
			self.alpha = 1
			toolbarHUD.alpha = 0
			toolbarHUD.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)

			UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
				self.toolbarHUD.transform = CGAffineTransform(scaleX: 1/1.4, y: 1/1.4)
				self.toolbarHUD.alpha = 1
			}, completion: nil)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func hudHideTimer() {

		let text = labelStatus.text ?? ""
		let delay = Double(text.count) * 0.04 + 1
		timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { timer in
			self.hudHide()
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func hudHide() {

		if (self.alpha == 1) {
			UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
				self.toolbarHUD.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
				self.toolbarHUD.alpha = 0
			}, completion: { isFinished in
				self.hudDestroy()
				self.alpha = 0
			})
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func hudDestroy() {

		NotificationCenter.default.removeObserver(self)

		viewBackground.removeFromSuperview()
		toolbarHUD.removeFromSuperview()
		viewAnimated?.removeFromSuperview()
		viewProgress?.removeFromSuperview()
		imageView?.removeFromSuperview()
		labelStatus.removeFromSuperview()

		viewBackground = nil
		toolbarHUD = nil
		viewAnimated = nil
		viewProgress = nil
		imageView = nil
		labelStatus = nil

		timer?.invalidate()
		timer = nil
	}
}

// MARK: - ProgressHUDProgressView
//-------------------------------------------------------------------------------------------------------------------------------------------------
private class ProgressHUDProgressView: UIView {

	var color: UIColor = .systemBackground {
		didSet { setupLayers() }
	}
	private var progress: CGFloat = 0
	private var labelPercentage: UILabel = UILabel()

	private var layerTrack = CAShapeLayer()
	private var layerProgress = CAShapeLayer()

	//---------------------------------------------------------------------------------------------------------------------------------------------
	convenience init(_ color: UIColor) {

		self.init(frame: .zero)
		self.color = color
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	required init?(coder: NSCoder) {

		super.init(coder: coder)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override init(frame: CGRect) {

		super.init(frame: frame)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func draw(_ rect: CGRect) {

		super.draw(rect)
		setupLayers()
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func setupLayers() {

		layer.sublayers?.forEach { $0.removeFromSuperlayer() }

		let width = frame.size.width
		let height = frame.size.height

		let center = CGPoint(x: width/2, y: height/2)
		let radiusTrack = width / 2
		let radiusProgress = width / 2 - 5

		let pathTrack = UIBezierPath(arcCenter: center, radius: radiusTrack, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
		let pathProgress = UIBezierPath(arcCenter: center, radius: radiusProgress, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

		layerTrack.path = pathTrack.cgPath
		layerTrack.fillColor = UIColor.clear.cgColor
		layerTrack.lineWidth = 3
		layerTrack.strokeColor = color.cgColor

		layerProgress.path = pathProgress.cgPath
		layerProgress.fillColor = UIColor.clear.cgColor
		layerProgress.lineWidth = 7
		layerProgress.strokeColor = color.cgColor
		layerProgress.strokeEnd = 0

		layer.addSublayer(layerTrack)
		layer.addSublayer(layerProgress)

		labelPercentage.frame = self.bounds
		labelPercentage.textColor = color
		labelPercentage.textAlignment = .center
		addSubview(labelPercentage)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func setProgress(_ value: CGFloat, duration: TimeInterval = 0.2) {

		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = duration
		animation.fromValue = progress
		animation.toValue = value
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		layerProgress.add(animation, forKey: "animation")

		progress = value
		labelPercentage.text = "\(Int(value*100))%"
	}
}

// MARK: - ProgressHUDAnimationView
//-------------------------------------------------------------------------------------------------------------------------------------------------
private class ProgressHUDAnimationView: UIView {

	var animationType: AnimationType = .systemActivityIndicator {
		didSet { setupHUDIndicator() }
	}

	var color: UIColor = .systemBackground {
		didSet { setupHUDIndicator() }
	}
	
	var animatedIcon: AnimatedIcon? {
		didSet { setupHUDIndicator() }
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	convenience init(color: UIColor) {

		self.init(frame: .zero)
		self.color = color
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	required init?(coder: NSCoder) {

		super.init(coder: coder)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override init(frame: CGRect) {

		super.init(frame: frame)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func layoutSubviews() {

		super.layoutSubviews()
		setupHUDIndicator()
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func draw(_ rect: CGRect) {

		super.draw(rect)
		setupHUDIndicator()
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func setupHUDIndicator() {

		subviews.forEach { $0.removeFromSuperview() }
		layer.sublayers?.forEach { $0.removeFromSuperlayer() }

		if let animatedIcon = animatedIcon {
			if (animatedIcon == .succeed)						{ animatedIconSucceed()					}
			if (animatedIcon == .failed)						{ animatedIconFailed()					}
			if (animatedIcon == .added)							{ animatedIconAdded()					}
		} else {
			if (animationType == .systemActivityIndicator)		{ animationSystemActivityIndicator()	}
			if (animationType == .horizontalCirclesPulse)		{ animationHorizontalCirclesPulse()		}
			if (animationType == .lineScalling)					{ animationLineScalling()				}
			if (animationType == .singleCirclePulse)			{ animationSingleCirclePulse()			}
			if (animationType == .multipleCirclePulse)			{ animationMultipleCirclePulse()		}
			if (animationType == .singleCircleScaleRipple)		{ animationSingleCircleScaleRipple()	}
			if (animationType == .multipleCircleScaleRipple)	{ animationMultipleCircleScaleRipple()	}
			if (animationType == .circleSpinFade)				{ animationCircleSpinFade()				}
			if (animationType == .lineSpinFade)					{ animationLineSpinFade()				}
			if (animationType == .circleRotateChase)			{ animationCircleRotateChase()			}
			if (animationType == .circleStrokeSpin)				{ animationCircleStrokeSpin()			}
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animatedIconSucceed() {

		let length = frame.width

		let path = UIBezierPath()
		path.move(to: CGPoint(x: length * 0.15, y: length * 0.50))
		path.addLine(to: CGPoint(x: length * 0.5, y: length * 0.80))
		path.addLine(to: CGPoint(x: length * 1.0, y: length * 0.25))

		let layer = CAShapeLayer()
		layer.path = path.cgPath
		layer.fillColor = UIColor.clear.cgColor
		layer.strokeColor = color.cgColor
		layer.lineWidth = 9
		layer.lineCap = .round
		layer.lineJoin = .round
		layer.strokeEnd = 0
		self.layer.addSublayer(layer)

		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = 0.3
		animation.fromValue = 0
		animation.toValue = 1
		animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

		layer.strokeEnd = 1
		layer.add(animation, forKey: "animation")
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animatedIconFailed() {

		let length = frame.width

		let path1 = UIBezierPath()
		let path2 = UIBezierPath()

		path1.move(to: CGPoint(x: length * 0.1, y: length * 0.1))
		path2.move(to: CGPoint(x: length * 0.1, y: length * 0.9))

		path1.addLine(to: CGPoint(x: length * 0.9, y: length * 0.9))
		path2.addLine(to: CGPoint(x: length * 0.9, y: length * 0.1))

		[path1, path2].forEach { path in
			let layer = CAShapeLayer()
			layer.path = path.cgPath
			layer.fillColor = UIColor.clear.cgColor
			layer.strokeColor = color.cgColor
			layer.lineWidth = 9
			layer.lineCap = .round
			layer.lineJoin = .round
			layer.strokeEnd = 0
			self.layer.addSublayer(layer)

			let animation = CABasicAnimation(keyPath: "strokeEnd")
			animation.duration = 0.3
			animation.fromValue = 0
			animation.toValue = 1
			animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

			layer.strokeEnd = 1
			layer.add(animation, forKey: "animation")
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animatedIconAdded() {

		let length = frame.width

		let path1 = UIBezierPath()
		let path2 = UIBezierPath()
		let path3 = UIBezierPath()

		path1.move(to: CGPoint(x: length * 0.0, y: length * 0.5))
		path2.move(to: CGPoint(x: length * 0.5, y: length * 0.0))
		path3.move(to: CGPoint(x: length * 0.5, y: length * 1.0))

		path1.addLine(to: CGPoint(x: length * 1.0, y: length * 0.5))
		path2.addLine(to: CGPoint(x: length * 0.5, y: length * 0.5))
		path3.addLine(to: CGPoint(x: length * 0.5, y: length * 0.5))

		[path1, path2, path3].forEach { path in
			let layer = CAShapeLayer()
			layer.path = path.cgPath
			layer.fillColor = UIColor.clear.cgColor
			layer.strokeColor = color.cgColor
			layer.lineWidth = 9
			layer.lineCap = .round
			layer.lineJoin = .round
			layer.strokeEnd = 0
			self.layer.addSublayer(layer)

			let animation = CABasicAnimation(keyPath: "strokeEnd")
			animation.duration = 0.3
			animation.fromValue = 0
			animation.toValue = 1
			animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

			layer.strokeEnd = 1
			layer.add(animation, forKey: "animation")
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationSystemActivityIndicator() {

		let spinner = UIActivityIndicatorView(style: .large)
		spinner.frame = self.bounds
		spinner.color = color
		spinner.hidesWhenStopped = true
		spinner.startAnimating()
		spinner.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
		self.addSubview(spinner)
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationHorizontalCirclesPulse() {

		let width = frame.size.width
		let height = frame.size.height

		let spacing: CGFloat = 3
		let radius: CGFloat = (width - spacing * 2) / 3
		let ypos: CGFloat = (height - radius) / 2

		let beginTime = CACurrentMediaTime()
		let beginTimes = [0.12, 0.24, 0.36]
		let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

		let animation = CAKeyframeAnimation(keyPath: "transform.scale")
		animation.keyTimes = [0, 0.5, 1]
		animation.timingFunctions = [timingFunction, timingFunction]
		animation.values = [1, 0.3, 1]
		animation.duration = 1
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<3 {
			let circle = CAShapeLayer()
			circle.frame = CGRect(x: (radius + spacing) * CGFloat(i), y: ypos, width: radius, height: radius)
			circle.path = path.cgPath
			circle.fillColor = color.cgColor

			animation.beginTime = beginTime + beginTimes[i]
			circle.add(animation, forKey: "animation")
			layer.addSublayer(circle)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationLineScalling() {

		let width = frame.size.width
		let height = frame.size.height

		let lineWidth = width / 9

		let beginTime = CACurrentMediaTime()
		let beginTimes = [0.1, 0.2, 0.3, 0.4, 0.5]
		let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

		let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
		animation.keyTimes = [0, 0.5, 1]
		animation.timingFunctions = [timingFunction, timingFunction]
		animation.values = [1, 0.4, 1]
		animation.duration = 1
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: height), cornerRadius: width/2)

		for i in 0..<5 {
			let line = CAShapeLayer()
			line.frame = CGRect(x: lineWidth * 2 * CGFloat(i), y: 0, width: lineWidth, height: height)
			line.path = path.cgPath
			line.backgroundColor = nil
			line.fillColor = color.cgColor

			animation.beginTime = beginTime + beginTimes[i]
			line.add(animation, forKey: "animation")
			layer.addSublayer(line)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationSingleCirclePulse() {

		let width = frame.size.width
		let height = frame.size.height

		let duration: CFTimeInterval = 1.0
		
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
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		let circle = CAShapeLayer()
		circle.frame = CGRect(x: 0, y: 0, width: width, height: height)
		circle.path = path.cgPath
		circle.fillColor = color.cgColor

		circle.add(animation, forKey: "animation")
		layer.addSublayer(circle)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationMultipleCirclePulse() {

		let width = frame.size.width
		let height = frame.size.height

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
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<3 {
			let circle = CAShapeLayer()
			circle.frame = CGRect(x: 0, y: 0, width: width, height: height)
			circle.path = path.cgPath
			circle.fillColor = color.cgColor
			circle.opacity = 0

			animation.beginTime = beginTime + beginTimes[i]
			circle.add(animation, forKey: "animation")
			layer.addSublayer(circle)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationSingleCircleScaleRipple() {

		let width = frame.size.width
		let height = frame.size.height

		let duration: CFTimeInterval = 1.0
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
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		let circle = CAShapeLayer()
		circle.frame = CGRect(x: 0, y: 0, width: width, height: height)
		circle.path = path.cgPath
		circle.backgroundColor = nil
		circle.fillColor = nil
		circle.strokeColor = color.cgColor
		circle.lineWidth = 3

		circle.add(animation, forKey: "animation")
		layer.addSublayer(circle)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationMultipleCircleScaleRipple() {

		let width = frame.size.width
		let height = frame.size.height

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
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<3 {
			let circle = CAShapeLayer()
			circle.frame = CGRect(x: 0, y: 0, width: width, height: height)
			circle.path = path.cgPath
			circle.backgroundColor = nil
			circle.strokeColor = color.cgColor
			circle.lineWidth = 3
			circle.fillColor = nil

			animation.beginTime = beginTime + beginTimes[i]
			circle.add(animation, forKey: "animation")
			layer.addSublayer(circle)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationCircleSpinFade() {

		let width = frame.size.width

		let spacing: CGFloat = 3
		let radius = (width - 4 * spacing) / 3.5
		let radiusX = (width - radius) / 2

		let duration = 1.0
		let beginTime = CACurrentMediaTime()
		let beginTimes: [CFTimeInterval] = [0, 0.12, 0.24, 0.36, 0.48, 0.6, 0.72, 0.84]

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
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		for i in 0..<8 {
			let angle = .pi / 4 * CGFloat(i)

			let circle = CAShapeLayer()
			circle.path = path.cgPath
			circle.fillColor = color.cgColor
			circle.backgroundColor = nil
			circle.frame = CGRect(x: radiusX * (cos(angle) + 1), y: radiusX * (sin(angle) + 1), width: radius, height: radius)

			animation.beginTime = beginTime + beginTimes[i]
			circle.add(animation, forKey: "animation")
			layer.addSublayer(circle)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationLineSpinFade() {

		let width = frame.size.width
		let height = frame.size.height

		let spacing: CGFloat = 3
		let lineWidth = (width - 4 * spacing) / 5
		let lineHeight = (height - 2 * spacing) / 3
		let containerSize = max(lineWidth, lineHeight)
		let radius = width / 2 - containerSize / 2

		let duration = 1.2
		let beginTime = CACurrentMediaTime()
		let beginTimes: [CFTimeInterval] = [0.12, 0.24, 0.36, 0.48, 0.6, 0.72, 0.84, 0.96]
		let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

		let animation = CAKeyframeAnimation(keyPath: "opacity")
		animation.keyTimes = [0, 0.5, 1]
		animation.timingFunctions = [timingFunction, timingFunction]
		animation.values = [1, 0.3, 1]
		animation.duration = duration
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: lineHeight), cornerRadius: lineWidth/2)

		for i in 0..<8 {
			let angle = .pi / 4 * CGFloat(i)

			let line = CAShapeLayer()
			line.frame = CGRect(x: (containerSize-lineWidth)/2, y: (containerSize-lineHeight)/2, width: lineWidth, height: lineHeight)
			line.path = path.cgPath
			line.backgroundColor = nil
			line.fillColor = color.cgColor

			let container = CALayer()
			container.frame = CGRect(x: radius * (cos(angle) + 1), y: radius * (sin(angle) + 1), width: containerSize, height: containerSize)
			container.addSublayer(line)
			container.sublayerTransform = CATransform3DMakeRotation(.pi / 2 + angle, 0, 0, 1)

			animation.beginTime = beginTime + beginTimes[i]
			container.add(animation, forKey: "animation")
			layer.addSublayer(container)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationCircleRotateChase() {

		let width = frame.size.width
		let height = frame.size.height

		let spacing: CGFloat = 3
		let radius = (width - 4 * spacing) / 3.5
		let radiusX = (width - radius) / 2

		let duration: CFTimeInterval = 1.5

		let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

		let pathPosition = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: radiusX, startAngle: 1.5 * .pi, endAngle: 3.5 * .pi, clockwise: true)

		for i in 0..<5 {
			let rate = Float(i) * 1 / 5
			let fromScale = 1 - rate
			let toScale = 0.2 + rate
			let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + rate, 0.25, 1)

			let animationScale = CABasicAnimation(keyPath: "transform.scale")
			animationScale.duration = duration
			animationScale.repeatCount = HUGE
			animationScale.fromValue = fromScale
			animationScale.toValue = toScale

			let animationPosition = CAKeyframeAnimation(keyPath: "position")
			animationPosition.duration = duration
			animationPosition.repeatCount = HUGE
			animationPosition.path = pathPosition.cgPath

			let animation = CAAnimationGroup()
			animation.animations = [animationScale, animationPosition]
			animation.timingFunction = timeFunc
			animation.duration = duration
			animation.repeatCount = HUGE
			animation.isRemovedOnCompletion = false

			let circle = CAShapeLayer()
			circle.frame = CGRect(x: 0, y: 0, width: radius, height: radius)
			circle.path = path.cgPath
			circle.fillColor = color.cgColor

			circle.add(animation, forKey: "animation")
			layer.addSublayer(circle)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func animationCircleStrokeSpin() {

		let width = frame.size.width
		let height = frame.size.height

		let beginTime: Double = 0.5
		let durationStart: Double = 1.2
		let durationStop: Double = 0.7

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

		let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

		let circle = CAShapeLayer()
		circle.frame = CGRect(x: 0, y: 0, width: width, height: height)
		circle.path = path.cgPath
		circle.fillColor = nil
		circle.strokeColor = color.cgColor
		circle.lineWidth = 3

		circle.add(animation, forKey: "animation")
		layer.addSublayer(circle)
	}
}
