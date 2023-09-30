<img src="https://related.chat/hud/001.gif" width="80"> <img src="https://related.chat/hud/002.gif" width="80"> <img src="https://related.chat/hud/003.gif" width="80"> <img src="https://related.chat/hud/004.gif" width="80"> <img src="https://related.chat/hud/005.gif" width="80"> <img src="https://related.chat/hud/006.gif" width="80"> <img src="https://related.chat/hud/007.gif" width="80"> <img src="https://related.chat/hud/008.gif" width="80"> <img src="https://related.chat/hud/009.gif" width="80"> <img src="https://related.chat/hud/010.gif" width="80"> <img src="https://related.chat/hud/011.gif" width="80"> <img src="https://related.chat/hud/011.png" width="80"> <img src="https://related.chat/hud/012.gif" width="80"> <img src="https://related.chat/hud/012.png" width="80"> <img src="https://related.chat/hud/013.gif" width="80"> <img src="https://related.chat/hud/013.png" width="80"> <img src="https://related.chat/hud/014.gif" width="80"> <img src="https://related.chat/hud/014.png" width="80"> <img src="https://related.chat/hud/015.gif" width="80"> <img src="https://related.chat/hud/015.png" width="80">

## WHAT'S NEW

### Version: 13.8.3

- Removed the `AlertIcon` feature. Please use the `symbol:` parameter for similar functionality.
- The `questionmark` symbol will be displayed when the specified symbol name does not exist.

### Version: 13.8.2

- Refactored internal code architecture.

### Version: 13.8.1

- Implemented custom delay option for Banners.
- Fixed the Banner orientation resizing issue.
- Corrected the device orientation HUD positioning issue.
- Added multi-window support: custom window can be defined now.

### Version: 13.8.0

- Introduced an incredibly straightforward notification Banner feature.

### Version: 13.7.3

- Fixed a bug where a thin line occasionally appeared on the right side of the HUD.

### Version: 13.7.2

- Display any SF Symbols by specifying their names, e.g., `ProgressHUD.show(symbol: "car.fill")`.
- Enhanced `showFailed` and `showError` methods to accept optional `Error?` parameters. When provided, the `localizedDescription` will be shown.
- Fixed `setupDelayTimer` method by incorporating `[weak self]` in the timer's closure to prevent potential retain cycles and mitigate memory leaks.

### Version: 13.7.1

- Added `mediaSize` and `marginSize` options for customizable HUD dimensions.

### Version: 13.7.0

- Introduced `AnimationType.none` for text display without animation.

### Version: 13.6.2

- Added optional `delay:` parameter for setting timeout.
- Introduced `.remove()` function for immediate HUD dismissal.

### Version: 13.5 and 13.6

- Fixed iPad split-screen related bug.
- Resolved issue with `showProgress`.

## OVERVIEW

**ProgressHUD** is a convenient and intuitive HUD tool designed specifically for iOS. It enables seamless presentation of concise alerts or notifications to users of your app in a simple and non-disruptive way.

## INSTALLATION

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects.

To incorporate the **ProgressHUD** library into your Xcode project utilizing CocoaPods, please reference it within your `Podfile` as shown below:

```ruby
pod 'ProgressHUD'
```

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager) is a tool for managing the distribution of Swift code.

To add **ProgressHUD** as a dependency to your project, follow these steps:

1. Open your Swift project in Xcode.
2. Navigate to `File` -> `Add Package Dependencies...`.
3. Paste `https://github.com/relatedcode/ProgressHUD.git` into the search bar.
4. Choose the version you want to use and click `Add Package`.

### Manually

If you prefer not to use any of the dependency managers above, you can integrate **ProgressHUD** into your project manually. Just copy all the `*.swift` files from the `ProgressHUD/Sources` folder into your Xcode project.

## QUICK START

```swift
ProgressHUD.showBanner("Banner title", "Banner message to display.")
```

```swift
ProgressHUD.showBanner("Banner title", "Message to display.", delay: 2.0)
```

```swift
ProgressHUD.hideBanner()
```

```swift
ProgressHUD.show("Some text...")
```

```swift
ProgressHUD.show("Some text...", interaction: false)
```

```swift
ProgressHUD.showSucceed()
```

```swift
ProgressHUD.showSucceed("Some text...", delay: 1.5)
```

```swift
ProgressHUD.showFailed()
```

```swift
ProgressHUD.showFailed("Some text...")
```

```swift
ProgressHUD.showProgress(0.15)
```

```swift
ProgressHUD.showProgress("Loading...", 0.42)
```

```swift
ProgressHUD.show(symbol: "box.truck")
```

```swift
ProgressHUD.show("Some text...", symbol: "figure.2.arms.open")
```

```swift
ProgressHUD.dismiss()
```

```swift
ProgressHUD.remove()
```

## REQUIREMENTS

- iOS 13.0+

## CUSTOMIZATION

You can customize attributes like color, font, image, animation type, size, and more by using these methods:

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
ProgressHUD.mediaSize = 100
ProgressHUD.marginSize = 50
```

```swift
ProgressHUD.fontStatus = .boldSystemFont(ofSize: 24)
```

```swift
ProgressHUD.imageSuccess = UIImage(named: "success.png")
ProgressHUD.imageError = UIImage(named: "error.png")
```

A comprehensive list of the predefined animation types:

```swift
public enum AnimationType {
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
```

```swift
public enum AnimatedIcon {
	case succeed
	case failed
	case added
}
```

## LICENSE

MIT License

Copyright (c) 2023 Related Code

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
