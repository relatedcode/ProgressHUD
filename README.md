## ProgressHUD

ProgressHUD is a lightweight and easy-to-use HUD for iOS 7 (written in Objective-C).

![ProgressHUD](http://relatedcode.com/progresshud/11.png)
.
![ProgressHUD](http://relatedcode.com/progresshud/12.png)
.
![ProgressHUD](http://relatedcode.com/progresshud/13.png)

## Installation

Drag the `ProgressHUD/ProgressHUD` folder into your project.

## Requirements

- Xcode 5
- iOS 7
- ARC

## Displaying the HUD

```objective-c
+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status Interacton:(BOOL)Interaction;

+ (void)showSuccess:(NSString *)status;
+ (void)showSuccess:(NSString *)status Interacton:(BOOL)Interaction;

+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status Interacton:(BOOL)Interaction;
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

Use `sheme_white`, `sheme_black` or `sheme_color` depending on your needs. However feel free to customize the color settings in `ProgressHUD.h` file.

## Credits

ProgressHUD was inspired by [SVProgressHUD](https://github.com/samvermette/SVProgressHUD) project.

The success and error icons are from [Glyphish](http://glyphish.com).

## Contact

Do you have any questions or idea? My email is: info@relatedcode.com or you can find some more info at [relatedcode.com](http://relatedcode.com)
