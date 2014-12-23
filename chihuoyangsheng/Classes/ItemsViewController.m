//
//  ItemsViewController.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-22.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "ItemsViewController.h"

@interface ItemsViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ItemsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.tableView.layer.borderWidth = 1.0f;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identity = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity forIndexPath:indexPath];
    if (self.itemsArray) {
        cell.textLabel.text = self.itemsArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDeleagete

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _setAnswer( self.itemsArray[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}



@end
