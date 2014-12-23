/*
 
 BKSegmentedViewControllers
 
 The MIT License (MIT)
 
 Copyright (c) 2014 Bhavya Kothari
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "MasterSegmentedViewController.h"
#import "WhereAmI.h"
@interface MasterSegmentedViewController ()




@end

@implementation MasterSegmentedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"饭局列表";
    [self performSegueWithIdentifier:@"mealList" sender:nil];
    
}

- (IBAction)switchList:(UISegmentedControl *)sender
{
    int selectedIndex = (int)sender.selectedSegmentIndex;
    NSString *valiStr = [WhereAmI shareLoaction].currentLocation;
    if ([valiStr isEqualToString:@"随便看看"] && selectedIndex == 1) {
        [sender setSelectedSegmentIndex:0];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"请登录！"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    
    
    
    switch (selectedIndex) {
        case 0:
            [self performSegueWithIdentifier:@"mealList" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"myMealList" sender:nil];
            break;
            
        default:
            break;
    }
}





@end
