
//  HowToEatTVC.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-9.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "HowToEatTVC.h"
#import "MealService.h"
#import "AsycImageView.h"
#import "HowToEatDetailTVC.h"
#import "ProgressHUD.h"

static NSString *serverImageFolder = @"http://115.28.170.201/yssl/uploadFiles/";

@interface HowToEatTVC ()<UISearchBarDelegate>

@property(nonatomic,strong) NSMutableArray *cookBookList;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation HowToEatTVC

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        [self.cookBookList removeAllObjects];
        [self.tableView reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [ProgressHUD show:@"搜索菜谱中.."];
    NSString *queryString = searchBar.text;
    // NSLog(@"input:%@",queryString);
    NSString *searchParam = [NSString stringWithFormat:@"pageParam={page:1,rows:100}&cookbook={cookbookName:%@}",queryString];
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findCookbook.ws"
                                          queryString:searchParam
                                             callBack:^(NSMutableDictionary *dictionary) {
                                                 //self.cookBookList = dictionary[@"list"];
                                                 _cookBookList = [NSMutableArray arrayWithArray:dictionary[@"list"]];
                                                 if (self.cookBookList.count > 0) {
                                                     [ProgressHUD dismiss];
                                                 }else{
                                                     [ProgressHUD showError:@"没有结果！"];
                                                 }
                                                 [self.tableView reloadData];
                                                 [searchBar resignFirstResponder];
                                             }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cookBookList.count == 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return 1;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    return self.cookBookList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cookBookCell";
    
    static NSString *holderIdentifier = @"holderCell";
    
    if (self.cookBookList.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:holderIdentifier];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        AsycImageView *cookBookImage = [cell.contentView subviews][0];
        UILabel *nameLabel = [cell.contentView subviews][1];
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",serverImageFolder,self.cookBookList[indexPath.row][@"image"]];
        cookBookImage.imageUrl = imageUrl;
        //NSLog(@"图片地址：%@",imageUrl);
        nameLabel.text = self.cookBookList[indexPath.row][@"cookbookName"];
        return cell;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HowToEatDetailTVC *detailTVC = segue.destinationViewController;
    NSIndexPath *temp = [self.tableView indexPathForSelectedRow];
    detailTVC.cookBookDictionary = self.cookBookList[temp.row];
    detailTVC.title = self.cookBookList[temp.row][@"cookbookName"];
}

@end
