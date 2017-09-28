//
// Copyright (c) 2016 Related Code - http://relatedcode.com
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
#define HUD_STATUS_FONT			[UIFont boldSystemFontOfSize:16]
#define HUD_STATUS_COLOR		[UIColor blackColor]

#define HUD_SPINNER_COLOR		[UIColor grayColor]
#define HUD_BACKGROUND_COLOR	[UIColor colorWithWhite:0.0 alpha:0.1]
#define HUD_WINDOW_COLOR		[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2]

#define HUD_BUNDLE				[NSBundle bundleForClass:[self class]]
#define HUD_IMAGE_SUCCESS		[UIImage imageNamed:@"ProgressHUD.bundle/progresshud-success" inBundle:HUD_BUNDLE compatibleWithTraitCollection:nil]
#define HUD_IMAGE_ERROR			[UIImage imageNamed:@"ProgressHUD.bundle/progresshud-error" inBundle:HUD_BUNDLE compatibleWithTraitCollection:nil]

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface ProgressHUD : UIView
//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)dismiss;

+ (void)show;
+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status Interaction:(BOOL)interaction;
+ (void)showCustomView:(UIView *)customView delayTime:(NSTimeInterval)delayTime;

+ (void)showSuccess;
+ (void)showSuccess:(NSString *)status;
+ (void)showSuccess:(NSString *)status Interaction:(BOOL)interaction;

+ (void)showError;
+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status Interaction:(BOOL)interaction;
+ (void)hudCreate:(NSString *)status image:(UIImage *)image_ spin:(BOOL)spin hide:(BOOL)hide interaction:(BOOL)interaction;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIView *background;
@property (nonatomic, retain) UIToolbar *hud;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UILabel *label;

@end
