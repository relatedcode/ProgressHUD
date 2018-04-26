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

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self.window setRootViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]]];
	[self.window makeKeyAndVisible];
	return YES;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillResignActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidEnterBackground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillEnterForeground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidBecomeActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillTerminate:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

@end
