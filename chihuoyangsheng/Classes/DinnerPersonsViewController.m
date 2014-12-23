//
//  DinnerPersonsViewController.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-13.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "DinnerPersonsViewController.h"
#import "MealService.h"

@interface DinnerPersonsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *personsArray;
@end

@implementation DinnerPersonsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setDinnerID:(NSString *)dinnerID
{
    _dinnerID = dinnerID;
    if (!dinnerID) {
        return;
    }
    NSString *querStirng = [NSString stringWithFormat:@"id=%@",dinnerID];
    [MealService fetchDictionaryFromServerWithBaseUrl:@"getDinnerPartyById.ws" queryString:querStirng callBack:^(id dictionary) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            self.personsArray = dictionary[@"dinnerPersons"];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.personsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *person = self.personsArray[indexPath.row];
    
    UILabel *nickNameLabel = cell.contentView.subviews[0];
    UILabel *sexLabel = cell.contentView.subviews[1];
    nickNameLabel.text = person[@"nickName"];
    sexLabel.text = person[@"sex"];
    return cell;
}


@end
