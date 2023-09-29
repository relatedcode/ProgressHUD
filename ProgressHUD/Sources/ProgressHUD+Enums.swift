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

// MARK: - AnimationType
public enum AnimationType: CaseIterable {
	case none
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

// MARK: - AnimatedIcon
public enum AnimatedIcon {
	case succeed
	case failed
	case added
}

// MARK: - AlertIcon
public enum AlertIcon: CaseIterable {
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
