//
//  MyMealListTVC.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-10.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "MyMealListTVC.h"
#import "MealCell.h"
#import "MealService.h"
#import "MealDetailTVC.h"
#import "GloblalSharedDataManager.h"
#import "ProgressHUD.h"
@interface MyMealListTVC ()

@property (nonatomic,strong) NSMutableArray *myPostMeals;
@property (nonatomic,strong) NSMutableArray *joinedMeals;
@property (nonatomic,strong) NSString *customerID;

@end

@implementation MyMealListTVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customerID = [GloblalSharedDataManager sharedDataManager].customer.get_id;
}

- (void)viewWillAppear:(BOOL)animated
{
     self.customerID = [GloblalSharedDataManager sharedDataManager].customer.get_id;
    [self.joinedMeals removeAllObjects];
    [self.myPostMeals removeAllObjects];
    [self refreshMeals];
}

- (void)refreshMeals
{
    [ProgressHUD show:@"搜索中.."];
    NSString *joinedParams = [NSString stringWithFormat:@"pageParam={page:1,rows:10}&dinnerPerson={customerId:%@,customerType:1}",self.customerID];
    
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findDinnerPartyByPerson.ws"
                                          queryString:joinedParams
                                             callBack:^(NSMutableDictionary *dictionary) {
                                                 [ProgressHUD dismiss];
                                                 [self.joinedMeals addObjectsFromArray:dictionary[@"list"]];
                                                 [self.tableView reloadData];
                                             }];
    
     NSString *myPostParams = [NSString stringWithFormat:@"pageParam={page:1,rows:10}&dinnerPerson={customerId:%@,customerType:0}",self.customerID];
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findDinnerPartyByPerson.ws"
                                          queryString:myPostParams
                                             callBack:^(NSMutableDictionary *dictionary) {
                                                 [self.myPostMeals addObjectsFromArray:dictionary[@"list"]];
                                                 [self.tableView reloadData];
                                             }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.myPostMeals.count;
    }else{
        return self.joinedMeals.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    nameLabel.backgroundColor = [UIColor colorWithRed:213.0/255.0
                                                green:196.0/255.0
                                                 blue:161.0/255.0
                                                alpha:1];
    if (section == 0) {
        nameLabel.text = @"我发起的饭局";
        if (self.myPostMeals.count == 0) {
            nameLabel.text = @"没有我发起的饭局！";
        }
    }else{
        nameLabel.text = @"我参与的饭局";
        if (self.joinedMeals.count == 0) {
            nameLabel.text = @"没有我参与的饭局";
        }
    }
    //[headerView addSubview:nameLabel];
    return nameLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyMealCell";
    MealCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.section == 0) {
        cell.mealModel = self.myPostMeals.count > 0 ? self.myPostMeals[indexPath.row] : nil;
    }else{
        cell.mealModel = self.joinedMeals.count > 0 ? self.joinedMeals[indexPath.row] : nil ;
    }
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    MealDetailTVC *mealDetail = segue.destinationViewController;
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath.section == 0) {
        NSDictionary *param = self.myPostMeals[indexPath.row];
        mealDetail.mealDetailDictionary = param;
    }else{
        NSDictionary *param = self.joinedMeals[indexPath.row];
        mealDetail.mealDetailDictionary = param;
    }
    mealDetail.shouldHidePostButton = YES;
}


- (NSMutableArray *)myPostMeals
{
    if (!_myPostMeals) {
        _myPostMeals = [[NSMutableArray alloc] init];
    }
    return _myPostMeals;
}

- (NSMutableArray *)joinedMeals
{
    if (!_joinedMeals) {
        _joinedMeals = [[NSMutableArray alloc] init];
    }
    return _joinedMeals;
}

@end
