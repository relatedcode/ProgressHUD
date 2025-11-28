## Let's Build Together! ✨

I'd be happy to work with you! 🚀 Whether you need help integrating ProgressHUD, have questions, or want to collaborate on a project, feel free to [reach out](https://relatedcode.com/#contact-form).

## WHAT'S NEW

For detailed changes, please refer to the [Change log](CHANGELOG.md).

## OVERVIEW

**ProgressHUD** is a convenient and intuitive HUD tool designed specifically for iOS. It enables the seamless presentation of concise alerts or notifications to your app users in a simple and non-disruptive way.

**Note:** This version (15.0.0+) is built with SwiftUI. If you need the UIKit version, please use version 14.1.4.

## INSTALLATION

### Swift Package Manager

[Swift Package Manager](https://docs.swift.org/swiftpm/documentation/packagemanagerdocs/) is a tool for managing Swift code distribution.

To add **ProgressHUD** as a dependency to your project, follow these steps:

1. Open your Swift project in Xcode.
2. Navigate to `File` -> `Add Package Dependencies...`.
3. Paste `https://github.com/relatedcode/ProgressHUD.git` into the search bar.
4. Choose the version you want to use and click `Add Package`.

### Manually

If you prefer not to use the dependency manager above, you can integrate **ProgressHUD** into your project manually. Simply copy all the `*.swift` files from the `SwiftUI/Sources` folder into your Xcode project.

## QUICK START

### SwiftUI Setup

Add the `.progressHUD()` modifier to your root view:

```swift
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .progressHUD()
        }
    }
}
```

### Usage Examples

```swift
ProgressHUD.banner("Banner title", "Banner message to display.")
```

```swift
ProgressHUD.banner("Banner title", "Message to display.", delay: 2.0)
```

```swift
ProgressHUD.bannerHide()
```

```swift
ProgressHUD.animate("Some text...")
```

```swift
ProgressHUD.animate("Some text...", interaction: false)
```

```swift
ProgressHUD.animate("Please wait...", .ballVerticalBounce)
```

```swift
ProgressHUD.succeed()
```

```swift
ProgressHUD.succeed("Some text...", delay: 1.5)
```

```swift
ProgressHUD.failed()
```

```swift
ProgressHUD.failed("Some text...")
```

```swift
ProgressHUD.progress(0.15)
```

```swift
ProgressHUD.progress("Loading...", 0.42)
```

```swift
ProgressHUD.symbol(name: "box.truck")
```

```swift
ProgressHUD.symbol("Some text...", name: "sun.max")
```

```swift
ProgressHUD.success("Success message")
```

```swift
ProgressHUD.error("Error message")
```

```swift
ProgressHUD.added("Item added")
```

```swift
ProgressHUD.animate("Loading...", symbol: "star.fill")
```

```swift
ProgressHUD.dismiss()
```

```swift
ProgressHUD.remove()
```

## REQUIREMENTS

- iOS 17.0+
- Xcode 15.0+

## CUSTOMIZATION

You can customize attributes like color, font, image, animation type, size, and more by using these methods:

```swift
ProgressHUD.animationType = .circleStrokeSpin
```

```swift
ProgressHUD.colorHUD = .gray.opacity(0.1)
```

```swift
ProgressHUD.colorBackground = .gray.opacity(0.3)
```

```swift
ProgressHUD.colorAnimation = .blue
```

```swift
ProgressHUD.colorProgress = .blue
```

```swift
ProgressHUD.colorStatus = .primary
```

```swift
ProgressHUD.mediaSize = 100
ProgressHUD.marginSize = 50
```

```swift
ProgressHUD.fontStatus = .system(size: 24, weight: .bold)
```

```swift
ProgressHUD.imageSuccess = Image("success")
ProgressHUD.imageError = Image("error")
```

Banner customization:

```swift
ProgressHUD.colorBanner = .blue.opacity(0.1)
ProgressHUD.colorBannerTitle = .primary
ProgressHUD.colorBannerMessage = .secondary
ProgressHUD.fontBannerTitle = .system(size: 16, weight: .semibold)
ProgressHUD.fontBannerMessage = .system(size: 14)
```

A comprehensive list of the predefined enums:

```swift
public enum AnimationType: CaseIterable {
	case none
	case activityIndicator
	case ballVerticalBounce
	case barSweepToggle
	case circleArcDotSpin
	case circleBarSpinFade
	case circleDotSpinFade
	case circlePulseMultiple
	case circlePulseSingle
	case circleRippleMultiple
	case circleRippleSingle
	case circleRotateChase
	case circleStrokeSpin
	case dualDotSidestep
	case horizontalBarScaling
	case horizontalDotScaling
	case pacmanProgress
	case quintupleDotDance
	case semiRingRotation
	case sfSymbolBounce
	case squareCircuitSnake
	case triangleDotShift
}
```

```swift
public enum LiveIcon {
	case succeed
	case failed
	case added
}
```

## LICENSE

MIT License

Copyright (c) 2025 Related Code

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
