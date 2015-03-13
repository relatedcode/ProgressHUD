//
// Copyright (c) 2014 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import UIKit;

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define HUD_STYLE               UIBarStyleDefault

#define HUD_STATUS_FONT			[UIFont boldSystemFontOfSize:16]
#define HUD_STATUS_COLOR		[UIColor blackColor]

#define HUD_SPINNER_COLOR		[UIColor colorWithRed:185.0/255.0 green:220.0/255.0 blue:47.0/255.0 alpha:1.0]
#define HUD_BACKGROUND_COLOR	[UIColor colorWithWhite:0.0 alpha:0.1]
#define HUD_WINDOW_COLOR		[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2]

#define HUD_IMAGE_SUCCESS		[UIImage imageNamed:@"ProgressHUD.bundle/progresshud-success.png"]
#define HUD_IMAGE_ERROR			[UIImage imageNamed:@"ProgressHUD.bundle/progresshud-error.png"]

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface ProgressHUD : UIView
//-------------------------------------------------------------------------------------------------------------------------------------------------

+ (ProgressHUD *)shared;

+ (void)dismiss;

+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status Interaction:(BOOL)Interaction;

+ (void)showSuccess:(NSString *)status;
+ (void)showSuccess:(NSString *)status Interaction:(BOOL)Interaction;

+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status Interaction:(BOOL)Interaction;

@property (nonatomic, readonly) BOOL interaction;

@property (nonatomic, readonly, strong) UIWindow *window;
@property (nonatomic, readonly, strong) UIView *background;
@property (nonatomic, readonly, strong) UIToolbar *hud;
@property (nonatomic, readonly, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, readonly, strong) UIImageView *image;
@property (nonatomic, readonly, strong) UILabel *label;

+ (void)setStyle:(UIBarStyle)style;
+ (void)setStatusFont:(UIFont *)newStatusFont;
+ (void)setStatusColor:(UIColor *)newStatusColor;
+ (void)setSpinnerColor:(UIColor *)newSpinnerColor;
+ (void)setBackgroundColor:(UIColor *)newBackgroundColor;
+ (void)setWindowColor:(UIColor *)newWindowColor;
+ (void)setImageSuccess:(UIImage *)newImageSuccess;
+ (void)setImageError:(UIImage *)newImageError;

@end
