# Change Log

## [15.0.0](https://github.com/relatedcode/ProgressHUD/releases/tag/15.0.0)

Released on 2025-11-28.

#### Changed

- Complete rewrite from UIKit to SwiftUI.
- Minimum iOS requirement updated from iOS 13.0+ to iOS 17.0+.
- Source path changed from `ProgressHUD/Sources` to `SwiftUI/Sources`.
- All color, font, and image properties now use SwiftUI types (`Color`, `Font`, `Image`) instead of UIKit types.
- Updated API to use SwiftUI's `@Observable` and modern Swift concurrency.

#### Note

- This version (15.0.0+) is built with SwiftUI. If you need the UIKit version, please use version 14.1.4.

## [14.1.4](https://github.com/relatedcode/ProgressHUD/releases/tag/14.1.4)

Released on 2025-07-04.

#### Removed

- Dropped CocoaPods support.

## [14.1.3](https://github.com/relatedcode/ProgressHUD/releases/tag/14.1.3)

Released on 2024-05-09.

#### Changed

- Added the `defaultLocalization` value to the `Package.swift` file.

## [14.1.2](https://github.com/relatedcode/ProgressHUD/releases/tag/14.1.2)

Released on 2024-05-03.

#### Added

- Added the `PrivacyInfo.xcprivacy` file.

## [14.1.1](https://github.com/relatedcode/ProgressHUD/releases/tag/14.1.1)

Released on 2024-01-22.

#### Revision

- Year bump.

## [14.1.0](https://github.com/relatedcode/ProgressHUD/releases/tag/14.1.0)

Released on 2023-10-15.

#### Changed

- Renamed the `AnimatedIcon` enum to `LiveIcon`.
- The general `show` method has been split into multiple specialized methods: `animate`, `progress`, `liveIcon`, `image`, `symbol`.
- Updated the Static Image SF Symbol weight configuration to utilize a bold setting.
- Conducted minor code improvements for better maintainability and performance.

## [14.0.0](https://github.com/relatedcode/ProgressHUD/releases/tag/14.0.0)

Released on 2023-10-14.

#### Added

- Introduced the 'SF Symbol Bounce' animation feature, allowing for the display of over 5000 animated SF Symbols to enhance visual engagement.

#### Changed

- Enhanced the existing animations through various code optimizations.

## [13.8.6](https://github.com/relatedcode/ProgressHUD/releases/tag/13.8.6)

Released on 2023-10-13.

#### Fixed

- Corrected an issue where displaying a banner would fail if a HUD had not been shown before the banner.

## [13.8.5](https://github.com/relatedcode/ProgressHUD/releases/tag/13.8.5)

Released on 2023-10-13.

#### Added

- Introduced 9 new animations to offer a more engaging and visually captivating user experience.

#### Changed

- Refactored existing animation names, including adjustments to the `AnimationType` enum.
- Split the animations-related source files for better maintainability and organization.
- Updated a few of the existing animations in terms of shape, size, and duration.

## [13.8.4](https://github.com/relatedcode/ProgressHUD/releases/tag/13.8.4)

Released on 2023-10-05.

#### Fixed

- Corrected the window initialization issue where the `ProgressHUD` class was initialized before the 'main' window was created.
- Resolved the keyboard height discrepancy that occurred when the keyboard was already visible before displaying the HUD.

## [13.8.3](https://github.com/relatedcode/ProgressHUD/releases/tag/13.8.3)

Released on 2023-09-30.

#### Removed

- Removed the `AlertIcon` feature. Please use the `symbol:` parameter for similar functionality.

#### Changed

- The `questionmark` symbol will be displayed when the specified symbol name does not exist.

## [13.8.2](https://github.com/relatedcode/ProgressHUD/releases/tag/13.8.2)

Released on 2023-09-29.

#### Changed

- Refactored internal code architecture.

## [13.8.1](https://github.com/relatedcode/ProgressHUD/releases/tag/13.8.1)

Released on 2023-09-28.

#### Added

- Implemented custom delay option for Banners.
- Fixed the Banner orientation resizing issue.
- Added multi-window support: custom window can be defined now.

#### Fixed

- Corrected the device orientation HUD positioning issue.

## [13.8.0](https://github.com/relatedcode/ProgressHUD/releases/tag/13.8.0)

Released on 2023-09-27.

#### Added

- Introduced an incredibly straightforward notification Banner feature.

## [13.7.3](https://github.com/relatedcode/ProgressHUD/releases/tag/13.7.3)

Released on 2023-09-27.

#### Fixed

- Fixed a bug where a thin line occasionally appeared on the right side of the HUD.

## [13.7.2](https://github.com/relatedcode/ProgressHUD/releases/tag/13.7.2)

Released on 2023-07-09.

#### Added

- Display any SF Symbols by specifying their names, e.g., `ProgressHUD.show(symbol: "car.fill")`.
- Enhanced `showFailed` and `showError` methods to accept optional `Error?` parameters. When provided, the `localizedDescription` will be shown.

#### Fixed

- Fixed `setupDelayTimer` method by incorporating `[weak self]` in the timer's closure to prevent potential retain cycles and mitigate memory leaks.

## [13.7.1](https://github.com/relatedcode/ProgressHUD/releases/tag/13.7.1)

Released on 2023-06-30.

#### Added

- Added `mediaSize` and `marginSize` options for customizable HUD dimensions.

## [13.7.0](https://github.com/relatedcode/ProgressHUD/releases/tag/13.7.0)

Released on 2023-06-29.

#### Added

- Introduced `AnimationType.none` for text display without animation.

## [13.6.2](https://github.com/relatedcode/ProgressHUD/releases/tag/13.6.2)

Released on 2022-12-17.

#### Added

- Added optional `delay:` parameter for setting timeout.
- Introduced `.remove()` function for immediate HUD dismissal.

## [13.6.1](https://github.com/relatedcode/ProgressHUD/releases/tag/13.6.1)

Released on 2021-11-14.

#### Changed

- Switched to semantic versioning for more consistent and understandable version management.

## [13.6](https://github.com/relatedcode/ProgressHUD/releases/tag/13.6)

Released on 2021-04-05.

#### Fixed

- Fixed iPad split-screen related bug.

## [13.5](https://github.com/relatedcode/ProgressHUD/releases/tag/13.5)

Released on 2021-03-23.

#### Fixed

- Resolved issue with `showProgress`.
