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

#import "ViewController.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface ViewController()
{
	NSMutableArray *items;
}

@property (strong, nonatomic) IBOutlet UITableViewCell *cellText;

@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation ViewController

@synthesize cellText;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.title = @"Related Code";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	items = [[NSMutableArray alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[items addObject:@"Dismiss HUD"];
	[items addObject:@"Progress: no text"];
	[items addObject:@"Progress: short text"];
	[items addObject:@"Progress: longer text"];
	[items addObject:@"Success: no text"];
	[items addObject:@"Success: short text"];
	[items addObject:@"Error: no text"];
	[items addObject:@"Error: short text"];
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return 2;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (section == 0) return 2;
	if (section == 1) return [items count];
	return 0;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (indexPath.section == 0)
	{
		if (indexPath.row == 0) return cellText;
		if (indexPath.row == 1) return [self tableView:tableView cellWithText:@"Dismiss Keyboard"];
	}
	if (indexPath.section == 1)
	{
		return [self tableView:tableView cellWithText:items[indexPath.row]];
	}
	return nil;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellWithText:(NSString *)text
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	cell.textLabel.text = text;
	return cell;
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (indexPath.section == 0)
	{
		if (indexPath.row == 1)	[self.view endEditing:YES];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (indexPath.section == 1)
	{
		if (indexPath.row == 0)	[ProgressHUD dismiss];
		if (indexPath.row == 1)	[ProgressHUD show];
		if (indexPath.row == 2)	[ProgressHUD show:@"Please wait..."];
		if (indexPath.row == 3)	[ProgressHUD show:@"Please wait. We need some more time to work out this situation."];
		if (indexPath.row == 4)	[ProgressHUD showSuccess];
		if (indexPath.row == 5)	[ProgressHUD showSuccess:@"That was great!"];
		if (indexPath.row == 6)	[ProgressHUD showError];
		if (indexPath.row == 7)	[ProgressHUD showError:@"Something went wrong."];
	}
}

@end
