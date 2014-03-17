[![RelatedCode](http://relatedcode.com/github/header.png)](http://relatedcode.com)

## OVERVIEW

ProgressHUD is a lightweight and easy-to-use HUD for iOS 7 (written in Objective-C).

![ProgressHUD](http://relatedcode.com/github/progresshud01.png)
.
![ProgressHUD](http://relatedcode.com/github/progresshud02.png)
.
![ProgressHUD](http://relatedcode.com/github/progresshud03.png)

## INSTALLATION

Drag the `ProgressHUD/ProgressHUD` folder into your project.

## REQUIREMENTS

- Xcode 5
- iOS 7
- ARC

## Displaying the HUD

```objective-c
+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status Interaction:(BOOL)Interaction;

+ (void)showSuccess:(NSString *)status;
+ (void)showSuccess:(NSString *)status Interaction:(BOOL)Interaction;

+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status Interaction:(BOOL)Interaction;
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

## CREDITS

ProgressHUD was inspired by [SVProgressHUD](https://github.com/samvermette/SVProgressHUD) project.

The success and error icons are from [Glyphish](http://glyphish.com).

## CONTACT

Do you have any questions or idea? My email is: info@relatedcode.com or you can find some more info at [relatedcode.com](http://relatedcode.com)

## LICENSE

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
