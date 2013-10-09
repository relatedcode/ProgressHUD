//
// Copyright (c) 2013 Related Code - http://relatedcode.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ViewController.h"
#import "ProgressHUD.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface ViewController()
{
	NSMutableArray *Items;
}
@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation ViewController

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];

	Items = [[NSMutableArray alloc] init];

	[Items addObject:@"Dismiss"];
	[Items addObject:@"No text"];
	[Items addObject:@"Some text"];
	[Items addObject:@"Long text"];
	[Items addObject:@"Success with text"];
	[Items addObject:@"Success without text"];
	[Items addObject:@"Error with text"];
	[Items addObject:@"Error without text"];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [Items count];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

	cell.textLabel.text = [Items objectAtIndex:indexPath.row];

	return cell;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	NSString *tmp = [Items objectAtIndex:indexPath.row];
	
	if ([tmp isEqualToString:@"Dismiss"])				[ProgressHUD dismiss];
	
	if ([tmp isEqualToString:@"No text"])				[ProgressHUD show:nil];
	if ([tmp isEqualToString:@"Some text"])				[ProgressHUD show:@"Please wait..."];
	if ([tmp isEqualToString:@"Long text"])				[ProgressHUD show:@"Please wait. We need some more time to work out this situation."];
	if ([tmp isEqualToString:@"Success with text"])		[ProgressHUD showSuccess:@"That was great!"];
	if ([tmp isEqualToString:@"Success without text"])	[ProgressHUD showSuccess:nil];
	if ([tmp isEqualToString:@"Error with text"])		[ProgressHUD showError:@"Something went wrong."];
	if ([tmp isEqualToString:@"Error without text"])	[ProgressHUD showError:nil];
}

@end
