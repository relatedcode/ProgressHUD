## WHAT'S NEW IN 2.70

- General improvements

## OVERVIEW

ProgressHUD is a lightweight and easy-to-use HUD for iOS (written in Objective-C).

![ProgressHUD](http://relatedcode.com/github/progresshud811.png)
.
![ProgressHUD](http://relatedcode.com/github/progresshud812.png)
.
![ProgressHUD](http://relatedcode.com/github/progresshud813.png)

## INSTALLATION

[CocoaPods](http://cocoapods.org) is the recommended way to add ProgressHUD to your project.

1., Add a pod entry for ProgressHUD to your Podfile `pod 'ProgressHUD'`.

2., Install the pod(s) by running `pod install`.

3., Include ProgressHUD wherever you need it with `#import "ProgressHUD.h"`.

## REQUIREMENTS

- Xcode 6
- iOS 8
- ARC

## USAGE

1., Add the following import to the top of the file:

```
#import "ProgressHUD.h"
```

2., Use the following to display the HUD:

```
[ProgressHUD show:@"Please wait..."];
```

3., Simply dismiss after complete your task:

```
[ProgressHUD dismiss];
```

## CUSTOMIZATION

You can customize the color, font and image options using the following methods:

```
+ (void)statusFont:(UIFont *)font;
+ (void)statusColor:(UIColor *)color;
+ (void)spinnerColor:(UIColor *)color;
+ (void)hudColor:(UIColor *)color;
+ (void)backgroundColor:(UIColor *)color;
+ (void)imageSuccess:(UIImage *)image;
+ (void)imageError:(UIImage *)image;
```

## CREDITS

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
