//
//  NewsTableViewController.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-8.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "NewsTableViewController.h"
#import "MealService.h"
#import "NewsDetailTVC.h"
#include "ProgressHUD.h"

@interface NewsTableViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *newsList;
@property (nonatomic,strong) NSDictionary *pageParam;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pinner;
@property (weak, nonatomic) IBOutlet UIView *addMoreView;
@property (weak, nonatomic) IBOutlet UIButton *addMoreButton;

@end

@implementation NewsTableViewController
- (IBAction)addMoreNews:(UIButton *)sender
{
    [self.pinner startAnimating];
    int nextPage = [self.pageParam[@"page"] intValue] + 1;
    NSString *pageQueryString = [NSString
                                 stringWithFormat:@"pageParam={'page':%d,'rows':%d}",
                                 nextPage,
                                 [self.pageParam[@"rows"] intValue]];
    
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findNews.ws"
                                          queryString:pageQueryString
                                             callBack:^(NSMutableDictionary *dictionary) {
                                                 [self.pinner stopAnimating];
                                                 NSArray *temp = dictionary[@"list"];
                                                 if (temp.count == 0) {
                                                     [self.addMoreButton setTitle:@"没有更多资讯！" forState:UIControlStateNormal];
                                                 }
                                                 [self.newsList addObjectsFromArray:temp];
                                                 
                                                 self.pageParam = dictionary[@"pageParam"];
                                                 [self.tableView reloadData];
                                             }];

}

- (IBAction)refresh:(UIRefreshControl *)sender
{
    NSString *pageQueryString = [NSString
                                 stringWithFormat:@"pageParam={'page':%d,'rows':%d}",
                                 1,
                                 10];
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findNews.ws"
                                          queryString:pageQueryString
                                             callBack:^(NSMutableDictionary *dictionary) {
                                                 [self.refreshControl endRefreshing];
                                                 NSArray *temp = dictionary[@"list"];
                                                 if (temp.count == 0) {
                                                     [self.addMoreButton setTitle:@"没有更多资讯！" forState:UIControlStateNormal];
                                                 }else{
                                                     [self.addMoreButton setTitle:@"点击加载更多..." forState:UIControlStateNormal];
                                                 }
                                                 [self.newsList removeAllObjects];
                                                 [self.newsList addObjectsFromArray:temp];
                                                 self.pageParam = dictionary[@"pageParam"];
                                                 [self.tableView reloadData];
                                             }];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addMoreView.hidden = YES;
    self.title = @"资讯列表";
    [ProgressHUD show:@"获取资讯中.."];
    NSString *pageQueryString = [NSString stringWithFormat:@"pageParam={'page':%d,'rows':%d}",[self.pageParam[@"page"] intValue],[self.pageParam[@"rows"] intValue]];
    
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findNews.ws"
                                          queryString:pageQueryString
                                             callBack:^(NSMutableDictionary *dictionary) {
                                                 [ProgressHUD dismiss];
                                                 NSArray *temp = dictionary[@"list"];
                                                 if (temp.count > 0) {
                                                     self.addMoreView.hidden = NO;
                                                 }
                                                 [self.newsList addObjectsFromArray:temp];
                                                 
                                                 self.pageParam = dictionary[@"pageParam"];
                                                 [self.tableView reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"NewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = self.newsList[indexPath.row][@"newsTitle"];
    cell.detailTextLabel.text = self.newsList[indexPath.row][@"newsDate"];
    return cell;
}

- (NSMutableArray *)newsList
{
    if (!_newsList) {
        _newsList = [[NSMutableArray alloc] init];
    }
    return _newsList;
}

- (NSDictionary *)pageParam
{
    if (!_pageParam) {
        _pageParam = @{@"page": @1,@"rows":@10};
    }
    return _pageParam;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    NewsDetailTVC *newsDetailTVC = segue.destinationViewController;
    // Pass the selected object to the new view controller.
    NSIndexPath *temp = [self.tableView indexPathForSelectedRow];
    newsDetailTVC.newsDictionary = self.newsList[temp.row];
}



@end
