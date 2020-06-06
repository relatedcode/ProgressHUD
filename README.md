## WHAT'S NEW IN 13.0

- New features + complete Swift refactoring.

## OVERVIEW

ProgressHUD is a lightweight and easy-to-use HUD for iOS.

## INSTALLATION

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `ProgressHUD` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'ProgressHUD'
```

### Manually

If you prefer not to use any of the dependency managers, you can integrate `ProgressHUD` into your project manually. Just copy the `ProgressHUD.swift` file in your Xcode project.

## QUICK START

```swift
ProgressHUD.show("Some text...")
```

```swift
ProgressHUD.showSucceed()
```

```swift
ProgressHUD.showFailed()
```

```swift
ProgressHUD.showProgress(0.23)
```

```swift
ProgressHUD.show(icon: .heart)
```

```swift
ProgressHUD.dismiss()
```

## REQUIREMENTS

- iOS 13.0+

## CUSTOMIZATION

You can customize the color, font, image, animation type, and other some options using the following methods:

```swift
ProgressHUD.animationType = .circleStrokeSpin
```

```swift
ProgressHUD.colorHUD = .systemGray
```

```swift
ProgressHUD.colorBackground = .lightGray
```

```swift
ProgressHUD.colorAnimation = .systemBlue
```

```swift
ProgressHUD.colorProgress = .systemBlue
```

```swift
ProgressHUD.colorStatus = .label
```

```swift
ProgressHUD.fontStatus = UIFont.boldSystemFont(ofSize: 24)
```

```swift
ProgressHUD.imageSuccess = UIImage(named: "success.png")
```

```swift
ProgressHUD.imageError = UIImage(named: "error.png")
```

The list of predefined animation and icon types:

```swift
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
```

```swift
public enum AnimatedIcon {
	case succeed
	case failed
	case added
}
```

```swift
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
```

## CONTACT

Do you have any questions or ideas? My email is info@relatedcode.com or you can find some more info at [relatedcode.com](https://relatedcode.com)

## LICENSE

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
