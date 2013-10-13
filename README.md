## ProgressHUD

ProgressHUD is a lightweight and easy-to-use HUD for iOS 7 (written in Objective-C).

![ProgressHUD](http://relatedcode.com/progresshud/1.png)
.
![ProgressHUD](http://relatedcode.com/progresshud/2.png)
.
![ProgressHUD](http://relatedcode.com/progresshud/3.png)

## Installation

Drag the `ProgressHUD/ProgressHUD` folder into your project.

## Requirements

- Xcode 5
- iOS 7
- ARC

## Displaying the HUD

```objective-c
+ (void)show:(NSString *)status;
+ (void)showSuccess:(NSString *)status;
+ (void)showError:(NSString *)status;
```

`showSuccess` and `showError` will automatically dismiss the HUD.

## Dismissing the HUD

```objective-c
+ (void)dismiss;
```

## Usage

1., Add the following import to the top of the file:

```objective-c
#import "ProgressHUD.h"
```

2., Use the following to display the HUD:

```objective-c
[ProgressHUD show:@"Please wait..."];
```

3., Simply dismiss after complete your task:

```objective-c
[ProgressHUD dismiss];
```

## Color shemes

Use `sheme_white` or `sheme_black` depending on your needs. However feel free to customize the color settings in `ProgressHUD.h` file.

## Credits

ProgressHUD was inspired by [SVProgressHUD](https://github.com/samvermette/SVProgressHUD) project.

The success and error icons are from [Glyphish](http://glyphish.com).

You can find us on Twitter [@coderelated](https://twitter.com/coderelated) or at [relatedcode.com](http://relatedcode.com)
