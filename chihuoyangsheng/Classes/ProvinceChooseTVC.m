//
//  ProvinceChooseTVC.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-3.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "ProvinceChooseTVC.h"
#import "GloblalSharedDataManager.h"
#import "CityChooseTVC.h"

@interface ProvinceChooseTVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableDictionary *addressDictionary;
@end

@implementation ProvinceChooseTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addressDictionary = [GloblalSharedDataManager sharedDataManager].addressDictionary;
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.tableView.layer.borderWidth = 1.0f;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressDictionary.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.addressDictionary.allKeys[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GloblalSharedDataManager *dataManager = [GloblalSharedDataManager sharedDataManager];
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    NSString *provinceName = self.addressDictionary.allKeys[indexPath.row];
    dataManager.customer.province = provinceName;
    
    NSDictionary *dic2 = dataManager.provinceName_provinceID;
    NSString *provinceID = dic2[provinceName];
    dataManager.customer.provinceId = provinceID;
    
    NSArray *cities = [self.addressDictionary objectForKey:provinceName];
    CityChooseTVC *cityVC = segue.destinationViewController;
    cityVC.cities = cities;
}


@end
