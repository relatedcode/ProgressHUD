//
// Copyright (c) 2018 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface ProgressHUD : UIView
//-------------------------------------------------------------------------------------------------------------------------------------------------

#pragma mark - Display methods

+ (void)dismiss;

+ (void)show;
+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status Interaction:(BOOL)interaction;

+ (void)showSuccess;
+ (void)showSuccess:(NSString *)status;
+ (void)showSuccess:(NSString *)status Interaction:(BOOL)interaction;

+ (void)showError;
+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status Interaction:(BOOL)interaction;

#pragma mark - Property methods

+ (void)fontStatus:(UIFont *)font;
+ (void)colorStatus:(UIColor *)color;
+ (void)colorSpinner:(UIColor *)color;
+ (void)colorHUD:(UIColor *)color;
+ (void)colorBackground:(UIColor *)color;
+ (void)imageSuccess:(UIImage *)image;
+ (void)imageError:(UIImage *)image;

#pragma mark - Properties

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIView *viewBackground;
@property (strong, nonatomic) UIToolbar *toolbarHUD;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *labelStatus;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) UIFont *fontStatus;
@property (strong, nonatomic) UIColor *colorStatus;
@property (strong, nonatomic) UIColor *colorSpinner;
@property (strong, nonatomic) UIColor *colorHUD;
@property (strong, nonatomic) UIColor *colorBackground;
@property (strong, nonatomic) UIImage *imageSuccess;
@property (strong, nonatomic) UIImage *imageError;

@end
