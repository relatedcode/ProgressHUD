<a href="https://github.com/relatedcode/Messenger"><img src="https://related.chat/github/header31.png" width="880"></a>

---

<img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/001.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/002.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/003.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/004.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/005.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/006.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/007.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/008.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/009.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/010.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/011.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/011.png" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/012.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/012.png" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/013.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/013.png" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/014.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/014.png" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/015.gif" width="80"> <img src="https://github.com/relatedcode/ProgressHUD/raw/master/Images/015.png" width="80">

## WHAT'S NEW IN 13.5 and 13.6

- Bugfix related to iPad split screen
- Bugfix related to showProgress

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
ProgressHUD.showProgress(0.42)
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
ProgressHUD.fontStatus = .boldSystemFont(ofSize: 24)
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

## LICENSE

MIT License

Copyright (c) 2021 Related Code

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
