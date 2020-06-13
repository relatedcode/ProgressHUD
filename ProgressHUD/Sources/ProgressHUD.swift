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
	case lineScaling
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

	class var colorBackground: UIColor {
		get { shared.colorBackground }
		set { shared.colorBackground = newValue }
	}

	class var colorHUD: UIColor {
		get { shared.colorHUD }
		set { shared.colorHUD = newValue }
	}

	class var colorStatus: UIColor {
		get { shared.colorStatus }
		set { shared.colorStatus = newValue }
	}

	class var colorAnimation: UIColor {
		get { shared.colorAnimation }
		set { shared.colorAnimation = newValue }
	}

	class var colorProgress: UIColor {
		get { shared.colorProgress }
		set { shared.colorProgress = newValue }
	}

	class var fontStatus: UIFont {
		get { shared.fontStatus }
		set { shared.fontStatus = newValue }
	}

	class var imageSuccess: UIImage {
		get { shared.imageSuccess }
		set { shared.imageSuccess = newValue }
	}

	class var imageError: UIImage {
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
			shared.setup(status: status, hide: false, interaction: interaction)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func show(_ status: String? = nil, icon: AlertIcon, interaction: Bool = true) {

		let image = icon.image?.withTintColor(shared.colorAnimation, renderingMode: .alwaysOriginal)

		DispatchQueue.main.async {
			shared.setup(status: status, staticImage: image, hide: true, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func show(_ status: String? = nil, icon animatedIcon: AnimatedIcon, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.setup(status: status, animatedIcon: animatedIcon, hide: true, interaction: interaction)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showSuccess(_ status: String? = nil, image: UIImage? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.setup(status: status, staticImage: image ?? shared.imageSuccess, hide: true, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showError(_ status: String? = nil, image: UIImage? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.setup(status: status, staticImage: image ?? shared.imageError, hide: true, interaction: interaction)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showSucceed(_ status: String? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.setup(status: status, animatedIcon: .succeed, hide: true, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showFailed(_ status: String? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.setup(status: status, animatedIcon: .failed, hide: true, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showAdded(_ status: String? = nil, interaction: Bool = true) {

		DispatchQueue.main.async {
			shared.setup(status: status, animatedIcon: .added, hide: true, interaction: interaction)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showProgress(_ progress: CGFloat, interaction: Bool = false) {

		DispatchQueue.main.async {
			shared.setup(progress: progress, hide: false, interaction: interaction)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func showProgress(_ status: String?, _ progress: CGFloat, interaction: Bool = false) {

		DispatchQueue.main.async {
			shared.setup(status: status, progress: progress, hide: false, interaction: interaction)
		}
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
public class ProgressHUD: UIView {

	private var viewBackground: UIView?
	private var toolbarHUD: UIToolbar?
	private var labelStatus: UILabel?

	private var viewProgress: ProgressView?
	private var viewAnimation: UIView?
	private var viewAnimatedIcon: UIView?
	private var staticImageView: UIImageView?

	private var timer: Timer?

	private var animationType	= AnimationType.systemActivityIndicator

	private var colorBackground	= UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
	private var colorHUD		= UIColor.systemGray
	private var colorStatus		= UIColor.label
	private var colorAnimation	= UIColor.lightGray
	private var colorProgress	= UIColor.lightGray

	private var fontStatus		= UIFont.boldSystemFont(ofSize: 24)
	private var imageSuccess	= UIImage.checkmark.withTintColor(UIColor.systemGreen, renderingMode: .alwaysOriginal)
	private var imageError		= UIImage.remove.withTintColor(UIColor.systemRed, renderingMode: .alwaysOriginal)

	private let keyboardWillShow	= UIResponder.keyboardWillShowNotification
	private let keyboardWillHide	= UIResponder.keyboardWillHideNotification
	private let keyboardDidShow		= UIResponder.keyboardDidShowNotification
	private let keyboardDidHide		= UIResponder.keyboardDidHideNotification

	private let orientationDidChange = UIDevice.orientationDidChangeNotification

	//---------------------------------------------------------------------------------------------------------------------------------------------
	static let shared: ProgressHUD = {
		let instance = ProgressHUD()
		return instance
	} ()

	//---------------------------------------------------------------------------------------------------------------------------------------------
	convenience private init() {

		self.init(frame: UIScreen.main.bounds)
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

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setup(status: String? = nil, progress: CGFloat? = nil, animatedIcon: AnimatedIcon? = nil, staticImage: UIImage? = nil, hide: Bool, interaction: Bool) {

		setupNotifications()
		setupBackground(interaction)
		setupToolbar()
		setupLabel(status)

		if (progress == nil) && (animatedIcon == nil) && (staticImage == nil) { setupAnimation()				}
		if (progress != nil) && (animatedIcon == nil) && (staticImage == nil) { setupProgress(progress)			}
		if (progress == nil) && (animatedIcon != nil) && (staticImage == nil) { setupAnimatedIcon(animatedIcon)	}
		if (progress == nil) && (animatedIcon == nil) && (staticImage != nil) { setupStaticImage(staticImage)	}

		setupSize()
		setupPosition()

		hudShow()

		if (hide) {
			let text = labelStatus?.text ?? ""
			let delay = Double(text.count) * 0.03 + 1.25
			timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
				self.hudHide()
			}
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupNotifications() {

		if (viewBackground == nil) {
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardWillShow, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardWillHide, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardDidShow, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardDidHide, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: orientationDidChange, object: nil)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupBackground(_ interaction: Bool) {

		if (viewBackground == nil) {
			let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
			viewBackground = UIView(frame: self.bounds)
			mainWindow.addSubview(viewBackground!)
		}

		viewBackground?.backgroundColor = interaction ? .clear : colorBackground
		viewBackground?.isUserInteractionEnabled = (interaction == false)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupToolbar() {

		if (toolbarHUD == nil) {
			toolbarHUD = UIToolbar(frame: CGRect.zero)
			toolbarHUD?.isTranslucent = true
			toolbarHUD?.clipsToBounds = true
			toolbarHUD?.layer.cornerRadius = 10
			toolbarHUD?.layer.masksToBounds = true
			viewBackground?.addSubview(toolbarHUD!)
		}

		toolbarHUD?.backgroundColor = colorHUD
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupLabel(_ status: String?) {

		if (labelStatus == nil) {
			labelStatus = UILabel()
			labelStatus?.textAlignment = .center
			labelStatus?.baselineAdjustment = .alignCenters
			labelStatus?.numberOfLines = 0
			toolbarHUD?.addSubview(labelStatus!)
		}

		labelStatus?.text = (status != "") ? status : nil
		labelStatus?.font = fontStatus
		labelStatus?.textColor = colorStatus
		labelStatus?.isHidden = (status == nil) ? true : false
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupProgress(_ progress: CGFloat?) {

		viewAnimation?.removeFromSuperview()
		viewAnimatedIcon?.removeFromSuperview()
		staticImageView?.removeFromSuperview()

		if (viewProgress == nil) {
			viewProgress = ProgressView(colorProgress)
			viewProgress?.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
		}

		if (viewProgress?.superview == nil) {
			toolbarHUD?.addSubview(viewProgress!)
		}

		viewProgress?.setProgress(progress!)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupAnimation() {

		viewProgress?.removeFromSuperview()
		viewAnimatedIcon?.removeFromSuperview()
		staticImageView?.removeFromSuperview()

		if (viewAnimation == nil) {
			viewAnimation = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
		}

		if (viewAnimation?.superview == nil) {
			toolbarHUD?.addSubview(viewAnimation!)
		}

		viewAnimation?.subviews.forEach {
			$0.removeFromSuperview()
		}

		viewAnimation?.layer.sublayers?.forEach {
			$0.removeFromSuperlayer()
		}

		if (animationType == .systemActivityIndicator)		{ animationSystemActivityIndicator(viewAnimation!)		}
		if (animationType == .horizontalCirclesPulse)		{ animationHorizontalCirclesPulse(viewAnimation!)		}
		if (animationType == .lineScaling)					{ animationLineScaling(viewAnimation!)					}
		if (animationType == .singleCirclePulse)			{ animationSingleCirclePulse(viewAnimation!)			}
		if (animationType == .multipleCirclePulse)			{ animationMultipleCirclePulse(viewAnimation!)			}
		if (animationType == .singleCircleScaleRipple)		{ animationSingleCircleScaleRipple(viewAnimation!)		}
		if (animationType == .multipleCircleScaleRipple)	{ animationMultipleCircleScaleRipple(viewAnimation!)	}
		if (animationType == .circleSpinFade)				{ animationCircleSpinFade(viewAnimation!)				}
		if (animationType == .lineSpinFade)					{ animationLineSpinFade(viewAnimation!)					}
		if (animationType == .circleRotateChase)			{ animationCircleRotateChase(viewAnimation!)			}
		if (animationType == .circleStrokeSpin)				{ animationCircleStrokeSpin(viewAnimation!)				}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupAnimatedIcon(_ animatedIcon: AnimatedIcon?) {

		viewProgress?.removeFromSuperview()
		viewAnimation?.removeFromSuperview()
		staticImageView?.removeFromSuperview()

		if (viewAnimatedIcon == nil) {
			viewAnimatedIcon = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
		}

		if (viewAnimatedIcon?.superview == nil) {
			toolbarHUD?.addSubview(viewAnimatedIcon!)
		}

		viewAnimatedIcon?.layer.sublayers?.forEach {
			$0.removeFromSuperlayer()
		}

		if (animatedIcon == .succeed)	{ animatedIconSucceed(viewAnimatedIcon!)	}
		if (animatedIcon == .failed)	{ animatedIconFailed(viewAnimatedIcon!)		}
		if (animatedIcon == .added)		{ animatedIconAdded(viewAnimatedIcon!)		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupStaticImage(_ staticImage: UIImage?) {

		viewProgress?.removeFromSuperview()
		viewAnimation?.removeFromSuperview()
		viewAnimatedIcon?.removeFromSuperview()

		if (staticImageView == nil) {
			staticImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
		}

		if (staticImageView?.superview == nil) {
			toolbarHUD?.addSubview(staticImageView!)
		}

		staticImageView?.image = staticImage
		staticImageView?.contentMode = .scaleAspectFit
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func setupSize() {

		var width: CGFloat = 120
		var height: CGFloat = 120

		if let text = labelStatus?.text {
			let sizeMax = CGSize(width: 250, height: 250)
			let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: labelStatus?.font as Any]
			var rectLabel = text.boundingRect(with: sizeMax, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

			width = ceil(rectLabel.size.width) + 60
			height = ceil(rectLabel.size.height) + 120

			if (width < 120) { width = 120 }

			rectLabel.origin.x = (width - rectLabel.size.width) / 2
			rectLabel.origin.y = (height - rectLabel.size.height) / 2 + 45

			labelStatus?.frame = rectLabel
		}

		toolbarHUD?.bounds = CGRect(x: 0, y: 0, width: width, height: height)

		let centerX = width/2
		var centerY = height/2

		if (labelStatus?.text != nil) { centerY = 55 }

		viewProgress?.center = CGPoint(x: centerX, y: centerY)
		viewAnimation?.center = CGPoint(x: centerX, y: centerY)
		viewAnimatedIcon?.center = CGPoint(x: centerX, y: centerY)
		staticImageView?.center = CGPoint(x: centerX, y: centerY)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc private func setupPosition(_ notification: Notification? = nil) {

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
			self.toolbarHUD?.center = center
			self.viewBackground?.frame = screen
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
			toolbarHUD?.alpha = 0
			toolbarHUD?.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)

			UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
				self.toolbarHUD?.transform = CGAffineTransform(scaleX: 1/1.4, y: 1/1.4)
				self.toolbarHUD?.alpha = 1
			}, completion: nil)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func hudHide() {

		if (self.alpha == 1) {
			UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
				self.toolbarHUD?.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
				self.toolbarHUD?.alpha = 0
			}, completion: { isFinished in
				self.hudDestroy()
				self.alpha = 0
			})
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func hudDestroy() {

		NotificationCenter.default.removeObserver(self)

		staticImageView?.removeFromSuperview();		staticImageView = nil
		viewAnimatedIcon?.removeFromSuperview();	viewAnimatedIcon = nil
		viewAnimation?.removeFromSuperview();		viewAnimation = nil
		viewProgress?.removeFromSuperview();		viewProgress = nil

		labelStatus?.removeFromSuperview();			labelStatus = nil
		toolbarHUD?.removeFromSuperview();			toolbarHUD = nil
		viewBackground?.removeFromSuperview();		viewBackground = nil

		timer?.invalidate()
		timer = nil
	}

	// MARK: - Animation
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationSystemActivityIndicator(_ view: UIView) {

		let spinner = UIActivityIndicatorView(style: .large)
		spinner.frame = view.bounds
		spinner.color = colorAnimation
		spinner.hidesWhenStopped = true
		spinner.startAnimating()
		spinner.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
		view.addSubview(spinner)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationHorizontalCirclesPulse(_ view: UIView) {

		let width = view.frame.size.width
		let height = view.frame.size.height

		let spacing: CGFloat = 3
		let radius: CGFloat = (width - spacing * 2) / 3
		let ypos: CGFloat = (height - radius) / 2

		let beginTime = CACurrentMediaTime()
		let beginTimes = [0.36, 0.24, 0.12]
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
			let layer = CAShapeLayer()
			layer.frame = CGRect(x: (radius + spacing) * CGFloat(i), y: ypos, width: radius, height: radius)
			layer.path = path.cgPath
			layer.fillColor = colorAnimation.cgColor

			animation.beginTime = beginTime - beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationLineScaling(_ view: UIView) {

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
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: height), cornerRadius: width/2)

		for i in 0..<5 {
			let layer = CAShapeLayer()
			layer.frame = CGRect(x: lineWidth * 2 * CGFloat(i), y: 0, width: lineWidth, height: height)
			layer.path = path.cgPath
			layer.backgroundColor = nil
			layer.fillColor = colorAnimation.cgColor

			animation.beginTime = beginTime - beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationSingleCirclePulse(_ view: UIView) {

		let width = view.frame.size.width
		let height = view.frame.size.height

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

		let layer = CAShapeLayer()
		layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
		layer.path = path.cgPath
		layer.fillColor = colorAnimation.cgColor

		layer.add(animation, forKey: "animation")
		view.layer.addSublayer(layer)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationMultipleCirclePulse(_ view: UIView) {

		let width = view.frame.size.width
		let height = view.frame.size.height

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

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationSingleCircleScaleRipple(_ view: UIView) {

		let width = view.frame.size.width
		let height = view.frame.size.height

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

		let layer = CAShapeLayer()
		layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
		layer.path = path.cgPath
		layer.backgroundColor = nil
		layer.fillColor = nil
		layer.strokeColor = colorAnimation.cgColor
		layer.lineWidth = 3

		layer.add(animation, forKey: "animation")
		view.layer.addSublayer(layer)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationMultipleCircleScaleRipple(_ view: UIView) {

		let width = view.frame.size.width
		let height = view.frame.size.height

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
			let layer = CAShapeLayer()
			layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
			layer.path = path.cgPath
			layer.backgroundColor = nil
			layer.strokeColor = colorAnimation.cgColor
			layer.lineWidth = 3
			layer.fillColor = nil

			animation.beginTime = beginTime + beginTimes[i]

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationCircleSpinFade(_ view: UIView) {

		let width = view.frame.size.width

		let spacing: CGFloat = 3
		let radius = (width - 4 * spacing) / 3.5
		let radiusX = (width - radius) / 2

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
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

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

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationLineSpinFade(_ view: UIView) {

		let width = view.frame.size.width
		let height = view.frame.size.height

		let spacing: CGFloat = 3
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
		animation.repeatCount = HUGE
		animation.isRemovedOnCompletion = false

		let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: lineHeight), cornerRadius: lineWidth/2)

		for i in 0..<8 {
			let angle = .pi / 4 * CGFloat(i)

			let line = CAShapeLayer()
			line.frame = CGRect(x: (containerSize-lineWidth)/2, y: (containerSize-lineHeight)/2, width: lineWidth, height: lineHeight)
			line.path = path.cgPath
			line.backgroundColor = nil
			line.fillColor = colorAnimation.cgColor

			let container = CALayer()
			container.frame = CGRect(x: radius * (cos(angle) + 1), y: radius * (sin(angle) + 1), width: containerSize, height: containerSize)
			container.addSublayer(line)
			container.sublayerTransform = CATransform3DMakeRotation(.pi / 2 + angle, 0, 0, 1)

			animation.beginTime = beginTime - beginTimes[i]

			container.add(animation, forKey: "animation")
			view.layer.addSublayer(container)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationCircleRotateChase(_ view: UIView) {

		let width = view.frame.size.width
		let height = view.frame.size.height

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

			let layer = CAShapeLayer()
			layer.frame = CGRect(x: 0, y: 0, width: radius, height: radius)
			layer.path = path.cgPath
			layer.fillColor = colorAnimation.cgColor

			layer.add(animation, forKey: "animation")
			view.layer.addSublayer(layer)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animationCircleStrokeSpin(_ view: UIView) {

		let width = view.frame.size.width
		let height = view.frame.size.height

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

		let layer = CAShapeLayer()
		layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
		layer.path = path.cgPath
		layer.fillColor = nil
		layer.strokeColor = colorAnimation.cgColor
		layer.lineWidth = 3

		layer.add(animation, forKey: "animation")
		view.layer.addSublayer(layer)
	}

	// MARK: - Animated Icon
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animatedIconSucceed(_ view: UIView) {

		let length = view.frame.width
		let delay = (self.alpha == 0) ? 0.25 : 0.0

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

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animatedIconFailed(_ view: UIView) {

		let length = view.frame.width
		let delay = (self.alpha == 0) ? 0.25 : 0.0

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

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private func animatedIconAdded(_ view: UIView) {

		let length = view.frame.width
		let delay = (self.alpha == 0) ? 0.25 : 0.0

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

// MARK: - ProgressView
//-------------------------------------------------------------------------------------------------------------------------------------------------
private class ProgressView: UIView {

	var color: UIColor = .systemBackground {
		didSet { setupLayers() }
	}
	private var progress: CGFloat = 0

	private var layerCircle = CAShapeLayer()
	private var layerProgress = CAShapeLayer()
	private var labelPercentage: UILabel = UILabel()

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

		subviews.forEach { $0.removeFromSuperview() }
		layer.sublayers?.forEach { $0.removeFromSuperlayer() }

		let width = frame.size.width
		let height = frame.size.height

		let center = CGPoint(x: width/2, y: height/2)
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
