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

#import <UIKit/UIKit.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define HUD_STATUS_FONT			[UIFont boldSystemFontOfSize:16]
#define HUD_STATUS_COLOR		[UIColor whiteColor]

#define HUD_SPINNER_COLOR		[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f]
#define HUD_BACKGROUND_COLOR	[UIColor colorWithWhite:0.0f alpha:0.8f]
#define HUD_WINDOW_COLOR		[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f]

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

@property (nonatomic, assign) BOOL interaction;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIView *background;
@property (nonatomic, retain) UIView *hud;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UILabel *label;

@end
