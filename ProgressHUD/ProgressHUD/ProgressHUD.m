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

#import "ProgressHUD.h"

@implementation ProgressHUD

@synthesize window, viewBackground, toolbarHUD, spinner, imageView, labelStatus, timer;
@synthesize fontStatus, colorStatus, colorSpinner, colorHUD, colorBackground, imageSuccess, imageError;

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (ProgressHUD *)shared
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	static dispatch_once_t once;
	static ProgressHUD *progressHUD;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	dispatch_once(&once, ^{ progressHUD = [[ProgressHUD alloc] init]; });
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return progressHUD;
}

#pragma mark - Display methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)dismiss
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudHide];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)show
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:nil image:nil spin:YES hide:NO interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)show:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:nil spin:YES hide:NO interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)show:(NSString *)status Interaction:(BOOL)interaction
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:nil spin:YES hide:NO interaction:interaction];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showSuccess
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:nil image:[self shared].imageSuccess spin:NO hide:YES interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showSuccess:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:[self shared].imageSuccess spin:NO hide:YES interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showSuccess:(NSString *)status Interaction:(BOOL)interaction
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:[self shared].imageSuccess spin:NO hide:YES interaction:interaction];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showError
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:nil image:[self shared].imageError spin:NO hide:YES interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showError:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:[self shared].imageError spin:NO hide:YES interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showError:(NSString *)status Interaction:(BOOL)interaction
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:[self shared].imageError spin:NO hide:YES interaction:interaction];
	});
}

#pragma mark - Property methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)fontStatus:(UIFont *)font			{ [self shared].fontStatus		= font;	 }
+ (void)colorStatus:(UIColor *)color		{ [self shared].colorStatus		= color; }
+ (void)colorSpinner:(UIColor *)color		{ [self shared].colorSpinner	= color; }
+ (void)colorHUD:(UIColor *)color			{ [self shared].colorHUD		= color; }
+ (void)colorBackground:(UIColor *)color	{ [self shared].colorBackground	= color; }
+ (void)imageSuccess:(UIImage *)image		{ [self shared].imageSuccess	= image; }
+ (void)imageError:(UIImage *)image			{ [self shared].imageError		= image; }
//-------------------------------------------------------------------------------------------------------------------------------------------------

#pragma mark -

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)init
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UIColor *labelColor = [UIColor blackColor];
	if (@available(iOS 13, *)) { labelColor = [UIColor labelColor]; }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	fontStatus			= [UIFont boldSystemFontOfSize:16];
	colorStatus			= labelColor;
	colorSpinner		= labelColor;
	colorHUD			= [UIColor grayColor];
	colorBackground		= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];;
	NSBundle *bundle	= [NSBundle bundleForClass:[self class]];
	imageSuccess		= [UIImage imageNamed:@"ProgressHUD.bundle/progresshud-success" inBundle:bundle compatibleWithTraitCollection:nil];
	imageError			= [UIImage imageNamed:@"ProgressHUD.bundle/progresshud-error" inBundle:bundle compatibleWithTraitCollection:nil];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([delegate respondsToSelector:@selector(window)])
		window = [delegate performSelector:@selector(window)];
	else window = [[[UIApplication sharedApplication] windows] firstObject];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.alpha = 0;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return self;
}

#pragma mark -

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudCreate:(NSString *)status image:(UIImage *)image spin:(BOOL)spin hide:(BOOL)hide interaction:(BOOL)interaction
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (toolbarHUD == nil)
	{
		toolbarHUD = [[UIToolbar alloc] initWithFrame:CGRectZero];
		toolbarHUD.translucent = YES;
		toolbarHUD.backgroundColor = colorHUD;
		toolbarHUD.layer.cornerRadius = 10;
		toolbarHUD.layer.masksToBounds = YES;
		[self registerNotifications];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (toolbarHUD.superview == nil)
	{
		if (interaction == NO)
		{
			viewBackground = [[UIView alloc] initWithFrame:window.frame];
			viewBackground.backgroundColor = colorBackground;
			[window addSubview:viewBackground];
			[viewBackground addSubview:toolbarHUD];
		}
		else [window addSubview:toolbarHUD];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (spinner == nil)
	{
		UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleWhiteLarge;
		if (@available(iOS 13, *)) { style = UIActivityIndicatorViewStyleLarge; }
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
		spinner.color = colorSpinner;
		spinner.hidesWhenStopped = YES;
	}
	if (spinner.superview == nil) [toolbarHUD addSubview:spinner];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (imageView == nil)
	{
		imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
	}
	if (imageView.superview == nil) [toolbarHUD addSubview:imageView];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (labelStatus == nil)
	{
		labelStatus = [[UILabel alloc] initWithFrame:CGRectZero];
		labelStatus.font = fontStatus;
		labelStatus.textColor = colorStatus;
		labelStatus.backgroundColor = [UIColor clearColor];
		labelStatus.textAlignment = NSTextAlignmentCenter;
		labelStatus.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		labelStatus.numberOfLines = 0;
	}
	if (labelStatus.superview == nil) [toolbarHUD addSubview:labelStatus];
	//---------------------------------------------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------------------------------------------
	labelStatus.text = status;
	labelStatus.hidden = (status == nil) ? YES : NO;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	imageView.image = image;
	imageView.hidden = (image == nil) ? YES : NO;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (spin) [spinner startAnimating]; else [spinner stopAnimating];
	//---------------------------------------------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self hudSize];
	[self hudPosition:nil];
	[self hudShow];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (hide) [self timedHide];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)registerNotifications
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIDeviceOrientationDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillShowNotification object:nil];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudDestroy
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[labelStatus removeFromSuperview];		labelStatus = nil;
	[imageView removeFromSuperview];		imageView = nil;
	[spinner removeFromSuperview];			spinner = nil;
	[toolbarHUD removeFromSuperview];		toolbarHUD = nil;
	[viewBackground removeFromSuperview];	viewBackground = nil;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (timer != nil) { [timer invalidate]; timer = nil; }
}

#pragma mark -

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudSize
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGRect rectLabel = CGRectZero;
	CGFloat widthHUD = 100, heightHUD = 100;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (labelStatus.text != nil)
	{
		NSDictionary *attributes = @{NSFontAttributeName:labelStatus.font};
		NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
		rectLabel = [labelStatus.text boundingRectWithSize:CGSizeMake(200, 300) options:options attributes:attributes context:NULL];

		widthHUD = rectLabel.size.width + 50;
		heightHUD = rectLabel.size.height + 75;

		if (widthHUD < 100) widthHUD = 100;
		if (heightHUD < 100) heightHUD = 100;

		rectLabel.origin.x = (widthHUD - rectLabel.size.width) / 2;
		rectLabel.origin.y = (heightHUD - rectLabel.size.height) / 2 + 25;
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	toolbarHUD.bounds = CGRectMake(0, 0, widthHUD, heightHUD);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGFloat imageX = widthHUD/2;
	CGFloat imageY = (labelStatus.text == nil) ? heightHUD/2 : 36;
	imageView.center = spinner.center = CGPointMake(imageX, imageY);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	labelStatus.frame = rectLabel;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudPosition:(NSNotification *)notification
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGFloat heightKeyboard = 0;
	NSTimeInterval duration = 0;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (notification != nil)
	{
		NSDictionary *info = [notification userInfo];
		CGRect keyboard = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
		duration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
		if ((notification.name == UIKeyboardWillShowNotification) || (notification.name == UIKeyboardDidShowNotification))
		{
			heightKeyboard = keyboard.size.height;
		}
	}
	else heightKeyboard = [self keyboardHeight];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGRect screen = [UIScreen mainScreen].bounds;
	CGPoint center = CGPointMake(screen.size.width/2, (screen.size.height-heightKeyboard)/2);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		self.toolbarHUD.center = CGPointMake(center.x, center.y);
	} completion:nil];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (viewBackground != nil) viewBackground.frame = window.frame;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)keyboardHeight
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	for (UIWindow *testWindow in [[UIApplication sharedApplication] windows])
	{
		if ([[testWindow class] isEqual:[UIWindow class]] == NO)
		{
			for (UIView *possibleKeyboard in [testWindow subviews])
			{
				if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"])
				{
					return possibleKeyboard.bounds.size.height;
				}
				else if ([[possibleKeyboard description] hasPrefix:@"<UIInputSetContainerView"])
				{
					for (UIView *hostKeyboard in [possibleKeyboard subviews])
					{
						if ([[hostKeyboard description] hasPrefix:@"<UIInputSetHost"])
						{
							return hostKeyboard.frame.size.height;
						}
					}
				}
			}
		}
	}
	return 0;
}

#pragma mark -

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudShow
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (timer != nil) [timer invalidate];

	if (self.alpha == 0)
	{
		self.alpha = 1;
		toolbarHUD.alpha = 0;
		toolbarHUD.transform = CGAffineTransformScale(toolbarHUD.transform, 1.4, 1.4);

		UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			self.toolbarHUD.transform = CGAffineTransformScale(self.toolbarHUD.transform, 1/1.4, 1/1.4);
			self.toolbarHUD.alpha = 1;
		} completion:nil];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudHide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (self.alpha == 1)
	{
		UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;
		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			self.toolbarHUD.transform = CGAffineTransformScale(self.toolbarHUD.transform, 0.7, 0.7);
			self.toolbarHUD.alpha = 0;
		}
		completion:^(BOOL finished) {
			[self hudDestroy];
			self.alpha = 0;
		}];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)timedHide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSTimeInterval delay = labelStatus.text.length * 0.04 + 0.5;
	timer = [NSTimer scheduledTimerWithTimeInterval:delay repeats:NO block:^(NSTimer *timer) {
		[self hudHide];
	}];
}

@end
