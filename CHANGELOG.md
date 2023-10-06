# ProgressHUD Changelog

## 13.8.4 - 2023-10-05
### Fixed
- Corrected the window initialization issue where the `ProgressHUD` class was initialized before the 'main' window was created.
- Resolved the keyboard height discrepancy that occurred when the keyboard was already visible before displaying the HUD.

## 13.8.3 - 2023-09-30
### Removed
- Removed the `AlertIcon` feature. Please use the `symbol:` parameter for similar functionality.

### Changed
- The `questionmark` symbol will be displayed when the specified symbol name does not exist.

## 13.8.2 - 2023-09-29
### Changed
- Refactored internal code architecture.

## 13.8.1 - 2023-09-28
### Added
- Implemented custom delay option for Banners.
- Fixed the Banner orientation resizing issue.
- Added multi-window support: custom window can be defined now.

### Fixed
- Corrected the device orientation HUD positioning issue.

## 13.8.0 - 2023-09-27
### Added
- Introduced an incredibly straightforward notification Banner feature.

## 13.7.3 - 2023-09-27
### Fixed
- Fixed a bug where a thin line occasionally appeared on the right side of the HUD.

## 13.7.2 - 2023-07-09
### Added
- Display any SF Symbols by specifying their names, e.g., `ProgressHUD.show(symbol: "car.fill")`.
- Enhanced `showFailed` and `showError` methods to accept optional `Error?` parameters. When provided, the `localizedDescription` will be shown.
  
### Fixed
- Fixed `setupDelayTimer` method by incorporating `[weak self]` in the timer's closure to prevent potential retain cycles and mitigate memory leaks.

## 13.7.1 - 2023-06-30
### Added
- Added `mediaSize` and `marginSize` options for customizable HUD dimensions.

## 13.7.0 - 2023-06-29
### Added
- Introduced `AnimationType.none` for text display without animation.

## 13.6.2 - 2022-12-17
### Added
- Added optional `delay:` parameter for setting timeout.
- Introduced `.remove()` function for immediate HUD dismissal.

## 13.6.1 - 2021-11-14
### Changed
- Switched to semantic versioning for more consistent and understandable version management.

## 13.6 - 2021-04-05
### Fixed
- Fixed iPad split-screen related bug.

## 13.5 - 2021-03-23
### Fixed
- Resolved issue with `showProgress`.
