//
//  CityChooseTVC.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-3.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "CityChooseTVC.h"
#import "BasicInformationViewer.h"
#import "GloblalSharedDataManager.h"
@interface CityChooseTVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CityChooseTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.tableView.layer.borderWidth = 1.0f;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.cities[indexPath.row];
    return cell;
}


- (IBAction)confirmChoose:(UIBarButtonItem *)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *cityName = self.cities[indexPath.row];
    [GloblalSharedDataManager sharedDataManager].customer.cityId = [GloblalSharedDataManager sharedDataManager].cityName_cityID[cityName];
    
    BasicInformationViewer *informationViewer = self.navigationController.viewControllers[1];
    [informationViewer reloadTableViews];
    [self.navigationController popToViewController:informationViewer animated:YES];
}

@end
