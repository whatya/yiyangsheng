//
//  CookBookTableViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-2.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "CookBookTableViewController.h"
#import "CookBookCell.h"
#import "CookBookWebViewController.h"
#import "CookBookCookbookServiceImplServiceSoapBinding.h"
#import "GloblalSharedDataManager.h"
#import "BaseFoodbaseFood.h"
#import "BaseFoodDetailViewController.h"
#import "ProgressHUD.h"
@implementation CookBookTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cookBookArray.count == 0) {
        return 1;
    }else{
        return self.cookBookArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cookBook";
    CookBookCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (self.cookBookArray.count == 0) {
        cell.operaionTypeNameLabel.text = @"暂无信息！";
    }else{
        cell.operaionTypeNameLabel.text = @"查看详情>>";
        cell.cookBook = self.cookBookArray[indexPath.row];

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cookBookArray.count == 0) {
        return;
    }
    
    CookBookcookbook *cookBook = self.cookBookArray[indexPath.row];
    if ([[self helperArray] containsObject:self.title]) {
        BaseFoodbaseFood *baseFood = [[BaseFoodbaseFood alloc ] init];
        
        GloblalSharedDataManager *manager =[GloblalSharedDataManager sharedDataManager];
        NSMutableDictionary *entireBaseFoodDictionary = manager.baseFoodDictionary;
        NSMutableDictionary *subBaseFoodTypeDictionary = nil;
        if ([self.title isEqualToString:@"水果"]) {
            subBaseFoodTypeDictionary = entireBaseFoodDictionary[@"水果类"];
        }
        if ([self.title isEqualToString:@"茶水"]) {
            subBaseFoodTypeDictionary = entireBaseFoodDictionary[@"饮品"];
        }
        for (BaseFoodbaseFood *fruitOrTea in subBaseFoodTypeDictionary){
            if ([fruitOrTea.foodName isEqualToString:cookBook.cookbookName]) {
                baseFood = fruitOrTea;
                break;
            }
        }
        [self performSegueWithIdentifier:@"showBaseFoodFromCookBookList" sender:baseFood];

    }else{
        [self performSegueWithIdentifier:@"showCookBookWebView" sender:cookBook];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showBaseFoodFromCookBookList"]) {
        BaseFoodDetailViewController *baseDetailVC = segue.destinationViewController;
        baseDetailVC.food = sender;
    }else{
        CookBookWebViewController *bookWebView = segue.destinationViewController;
        CookBookcookbook *cookBook = sender;
        bookWebView.contentUrl = cookBook.url;
        bookWebView.contentTitle = cookBook.cookbookName;
    }
}
- (IBAction)refresh:(UIRefreshControl *)sender {
    [self.refreshControl endRefreshing];
}

- (void)fetchCookBookWithNames:(NSArray*)cookBookNames
{
    [ProgressHUD show:@"获取中.."];
    [self.refreshControl beginRefreshing];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        //食谱测试
        CookBookCookbookServiceImplServiceSoapBinding *cookBookService = [[CookBookCookbookServiceImplServiceSoapBinding alloc] init];
        CookBookpageParam *pager = [[CookBookpageParam alloc] init];
        pager.rows = 1;
        pager.page = 1;
        for(NSString *cookBookName in cookBookNames){
            
//                    NSString *filteredCookBookName = [[cookBookName stringByReplacingOccurrencesOfString:@"1" withString:@""] stringByReplacingOccurrencesOfString:@"一" withString:@""];
            
            CookBookjsonData *result = [cookBookService findCookbookByName:pager arg1:cookBookName __error:nil];
            if (result.rows.count > 0) {
                [self.cookBookArray addObject:[result.rows lastObject]];
                
            }
            //[self.refreshControl endRefreshing];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [ProgressHUD dismiss];
            [self.tableView reloadData];
        });
    });
    
    
}

- (void)fetchBaseFoodAsCookBook
{
    GloblalSharedDataManager *manager =[GloblalSharedDataManager sharedDataManager];
    NSMutableDictionary *entireBaseFoodDictionary = manager.baseFoodDictionary;
    NSMutableDictionary *subBaseFoodTypeDictionary = nil;
    if ([self.title isEqualToString:@"水果"]) {
        subBaseFoodTypeDictionary = entireBaseFoodDictionary[@"水果类"];
    }
    if ([self.title isEqualToString:@"茶水"]) {
        subBaseFoodTypeDictionary = entireBaseFoodDictionary[@"饮品"];
    }
    for (BaseFoodbaseFood *fruitOrTea in subBaseFoodTypeDictionary){
        
        NSString *fruitOrTeaName = fruitOrTea.foodName;
//        if ([self.cookBookNames containsObject:fruitOrTeaName] ) {
//            CookBookcookbook *model = [[CookBookcookbook alloc] init];
//            model.cookbookName = fruitOrTea.getFoodName;
//            model.image = fruitOrTea.getPicture;
//            [self.cookBookArray addObject:model];
//        }
        
        for (NSString *searchedStirng in self.cookBookNames){
            if ([fruitOrTeaName rangeOfString:searchedStirng].location != NSNotFound) {
                CookBookcookbook *model = [[CookBookcookbook alloc] init];
                model.cookbookName = fruitOrTea.getFoodName;
                model.image = fruitOrTea.getPicture;
                [self.cookBookArray addObject:model];
            }
        }
        
        
    }

}

- (void)setCookBookNames:(NSArray *)cookBookNames
{
    _cookBookNames = cookBookNames;
    NSString *vcTitle = self.title;
    if ([[self helperArray] containsObject:vcTitle] ) {
        [self fetchBaseFoodAsCookBook];
    }else{
        [self fetchCookBookWithNames:cookBookNames];
    }
    
}

-(NSArray*)helperArray
{
    return @[@"水果",@"茶水"];
}

- (NSMutableArray *)cookBookArray
{
    if (!_cookBookArray) {
        _cookBookArray = [[NSMutableArray alloc] init];
    }
    return _cookBookArray;
}

@end
