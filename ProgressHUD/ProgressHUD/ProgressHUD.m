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

#import "ProgressHUD.h"

@implementation ProgressHUD

@synthesize window, background, hud, spinner, image, label;

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (ProgressHUD *)shared
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	static dispatch_once_t once = 0;
	static ProgressHUD *progressHUD;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	dispatch_once(&once, ^{ progressHUD = [[ProgressHUD alloc] init]; });
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return progressHUD;
}

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
		[[self shared] hudCreate:nil image:HUD_IMAGE_SUCCESS spin:NO hide:YES interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showSuccess:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:HUD_IMAGE_SUCCESS spin:NO hide:YES interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showSuccess:(NSString *)status Interaction:(BOOL)interaction
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:HUD_IMAGE_SUCCESS spin:NO hide:YES interaction:interaction];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showError
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:nil image:HUD_IMAGE_ERROR spin:NO hide:YES interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showError:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:HUD_IMAGE_ERROR spin:NO hide:YES interaction:YES];
	});
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showError:(NSString *)status Interaction:(BOOL)interaction
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[self shared] hudCreate:status image:HUD_IMAGE_ERROR spin:NO hide:YES interaction:interaction];
	});
}

#pragma mark -

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)init
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([delegate respondsToSelector:@selector(window)])
		window = [delegate performSelector:@selector(window)];
	else window = [[UIApplication sharedApplication] keyWindow];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	background = nil; hud = nil; spinner = nil; image = nil; label = nil;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.alpha = 0;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return self;
}

#pragma mark -

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudCreate:(NSString *)status image:(UIImage *)image_ spin:(BOOL)spin hide:(BOOL)hide interaction:(BOOL)interaction
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (hud == nil)
	{
		hud = [[UIToolbar alloc] initWithFrame:CGRectZero];
		hud.translucent = YES;
		hud.backgroundColor = HUD_BACKGROUND_COLOR;
		hud.layer.cornerRadius = 10;
		hud.layer.masksToBounds = YES;
		[self registerNotifications];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (hud.superview == nil)
	{
		if (interaction == NO)
		{
			background = [[UIView alloc] initWithFrame:window.frame];
			background.backgroundColor = HUD_WINDOW_COLOR;
			[window addSubview:background];
			[background addSubview:hud];
		}
		else [window addSubview:hud];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (spinner == nil)
	{
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		spinner.color = HUD_SPINNER_COLOR;
		spinner.hidesWhenStopped = YES;
	}
	if (spinner.superview == nil) [hud addSubview:spinner];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (image == nil)
	{
		image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
	}
	if (image.superview == nil) [hud addSubview:image];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (label == nil)
	{
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.font = HUD_STATUS_FONT;
		label.textColor = HUD_STATUS_COLOR;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		label.numberOfLines = 0;
	}
	if (label.superview == nil) [hud addSubview:label];
	//---------------------------------------------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------------------------------------------
	label.text = status;
	label.hidden = (status == nil) ? YES : NO;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	image.image = image_;
	image.hidden = (image_ == nil) ? YES : NO;
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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:)
												 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardDidHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardDidShowNotification object:nil];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudDestroy
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[label removeFromSuperview];		label = nil;
	[image removeFromSuperview];		image = nil;
	[spinner removeFromSuperview];		spinner = nil;
	[hud removeFromSuperview];			hud = nil;
	[background removeFromSuperview];	background = nil;
}

#pragma mark -

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudSize
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGRect labelRect = CGRectZero;
	CGFloat hudWidth = 100, hudHeight = 100;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (label.text != nil)
	{
		NSDictionary *attributes = @{NSFontAttributeName:label.font};
		NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
		labelRect = [label.text boundingRectWithSize:CGSizeMake(200, 300) options:options attributes:attributes context:NULL];

		hudWidth = labelRect.size.width + 50;
		hudHeight = labelRect.size.height + 75;

		if (hudWidth < 100) hudWidth = 100;
		if (hudHeight < 100) hudHeight = 100;

		labelRect.origin.x = (hudWidth - labelRect.size.width) / 2;
		labelRect.origin.y = (hudHeight - labelRect.size.height) / 2 + 25;
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	hud.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGFloat imagex = hudWidth/2;
	CGFloat imagey = (label.text == nil) ? hudHeight/2 : 36;
	image.center = spinner.center = CGPointMake(imagex, imagey);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	label.frame = labelRect;
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
		hud.center = CGPointMake(center.x, center.y);
	} completion:nil];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (background != nil) background.frame = window.frame;
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
	if (self.alpha == 0)
	{
		self.alpha = 1;
		hud.alpha = 0;
		hud.transform = CGAffineTransformScale(hud.transform, 1.4, 1.4);
		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			hud.transform = CGAffineTransformScale(hud.transform, 1/1.4, 1/1.4);
			hud.alpha = 1;
		} completion:nil];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudHide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (self.alpha == 1)
	{
		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;
		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			hud.transform = CGAffineTransformScale(hud.transform, 0.7, 0.7);
			hud.alpha = 0;
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
	NSTimeInterval delay = label.text.length * 0.04 + 0.5;
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
	dispatch_after(time, dispatch_get_main_queue(), ^(void){ [self hudHide]; });
}

@end
