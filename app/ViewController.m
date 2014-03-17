//
// Copyright (c) 2014 Related Code - http://relatedcode.com
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
	NSMutableArray *items;
}
@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation ViewController

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];

	items = [[NSMutableArray alloc] init];

	[items addObject:@"Dismiss"];
	[items addObject:@"No text"];
	[items addObject:@"Some text"];
	[items addObject:@"Long text"];
	[items addObject:@"Success with text"];
	[items addObject:@"Success without text"];
	[items addObject:@"Error with text"];
	[items addObject:@"Error without text"];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return 2;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [items count];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (section == 0)
		return @"User interaction: enabled";
	else return @"User interaction: disabled";
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

	cell.textLabel.text = [items objectAtIndex:indexPath.row];

	return cell;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.section == 0) // User interaction: enabled
	{
		switch (indexPath.row)
		{
			case 0: [ProgressHUD dismiss]; break;
			case 1: [ProgressHUD show:nil]; break;
			case 2: [ProgressHUD show:@"Please wait..."]; break;
			case 3: [ProgressHUD show:@"Please wait. We need some more time to work out this situation."]; break;
			case 4: [ProgressHUD showSuccess:@"That was great!"]; break;
			case 5: [ProgressHUD showSuccess:nil]; break;
			case 6: [ProgressHUD showError:@"Something went wrong."]; break;
			case 7: [ProgressHUD showError:nil]; break;
		}
	}

	if (indexPath.section == 1) // User interaction: disabled
	{
		switch (indexPath.row)
		{
			case 0: [ProgressHUD dismiss]; break;
			case 1: [ProgressHUD show:nil Interaction:NO]; break;
			case 2: [ProgressHUD show:@"Please wait..." Interaction:NO]; break;
			case 3: [ProgressHUD show:@"Please wait. We need some more time to work out this situation." Interaction:NO]; break;
			case 4: [ProgressHUD showSuccess:@"That was great!" Interaction:NO]; break;
			case 5: [ProgressHUD showSuccess:nil Interaction:NO]; break;
			case 6: [ProgressHUD showError:@"Something went wrong." Interaction:NO]; break;
			case 7: [ProgressHUD showError:nil Interaction:NO]; break;
		}
	}
}

@end
