//
//  MealListViewController.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-7.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "MealListViewController.h"
#import "MealService.h"
#import "MealCell.h"
#import "MealDetailTVC.h"
#import <CoreLocation/CoreLocation.h>
#import "GloblalSharedDataManager.h"
#import "ProgressHUD.h"

@interface MealListViewController()

@property(nonatomic,strong) NSMutableDictionary *dataSource;


@end

@implementation MealListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self getMealsWithLocation:[GloblalSharedDataManager sharedDataManager].GPSLocation andRadis:300];
}

#pragma mark- viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"饭局列表";
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    [backBtn setTitle:@"<返回"];
    [self.navigationController.navigationItem setBackBarButtonItem:backBtn];
    [self getMealsWithLocation:[GloblalSharedDataManager sharedDataManager].GPSLocation andRadis:300];

}

#pragma mark- 通过经纬度获取附近饭局数据

- (void)getMealsWithLocation:(CLLocation*)location andRadis:(int)radii
{
    [ProgressHUD show:@"搜索中.."];
    //@"pageParam={page:1,rows:10}&dinnerParty={longitude:114.38667,latitude:31.31607,radii:3}"
    NSString *postParams = [NSString stringWithFormat:@"pageParam={page:1,rows:10}&dinnerParty={longitude:%f,latitude:%f,radii:%d}",location.coordinate.longitude,location.coordinate.latitude,radii];
    
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findDinnerParty.ws"
                                          queryString:postParams
                                             callBack:^(NSMutableDictionary *dictionary) {
                                                 [ProgressHUD dismiss];
                                                 self.dataSource = dictionary;
                                                 [self.tableView reloadData];
                                             }];

}



#pragma mark- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[@"list"] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mealCell";
    MealCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.mealModel = self.dataSource[@"list"][indexPath.row];
    return  cell;
}


#pragma mark- navigate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MealDetailTVC *mealDetail = segue.destinationViewController;
    NSDictionary *param = self.dataSource[@"list"][[self.tableView indexPathForSelectedRow].row];
    mealDetail.mealDetailDictionary = param;
    mealDetail.shouldHidePostButton = NO;
}


@end
