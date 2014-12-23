//
//  FoodTypeGetterTVC.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-8-20.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "FoodTypeGetterTVC.h"

@interface FoodTypeGetterTVC ()

@end

@implementation FoodTypeGetterTVC



- (void)viewDidLoad
{
    [super viewDidLoad];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *foodTypeLabel = cell.contentView.subviews[0];
    self.foodType = foodTypeLabel.text;
    [self performSegueWithIdentifier:@"foodTypeUnwind" sender:self];
}

@end
