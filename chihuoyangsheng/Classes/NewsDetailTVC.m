//
//  NewsDetailTVC.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-8.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "NewsDetailTVC.h"
#import "AsycImageView.h"
#import "MealService.h"
#import "ADViewController.h"

@interface NewsDetailTVC ()
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsDateLabel;
@property (weak, nonatomic) IBOutlet UIWebView *newsContentWebView;

@property (weak, nonatomic) IBOutlet AsycImageView *ad;
@property (nonatomic,strong) NSMutableArray *adsArray;
@property (nonatomic) int adsIndex;
@end

@implementation NewsDetailTVC




- (void)viewDidLoad
{
    [super viewDidLoad];
    self.newsTitleLabel.text = self.newsDictionary[@"newsTitle"];
    self.newsDateLabel.text = self.newsDictionary[@"newsDate"];
    [self.newsContentWebView loadHTMLString:self.newsDictionary[@"newsContent"] baseURL:nil];
    [self fetchHomePageAds];
}
- (IBAction)taped:(UITapGestureRecognizer *)sender {
    if (!self.adsArray.count > 0) {
        return;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ADViewController *ad = [storyboard instantiateViewControllerWithIdentifier:@"AD"];
    
    ad.ADUrl = self.adsArray[self.adsIndex][@"url"];
    [self.navigationController pushViewController:ad animated:YES];
}




#pragma mark- 获取广告
- (void)fetchHomePageAds
{
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findAd.ws"
                                          queryString:@"pageParam={'page':1,'rows':10}"
                                             callBack:^(id dictionary) {
                                                 //
                                                 if ([dictionary isKindOfClass:[NSDictionary class]]) {
                                                     //
                                                     [self filterAds:dictionary];
                                                     [self performSelector:@selector(switchAds)
                                                                withObject:nil afterDelay:5];
                                                 }
                                             }];
}

#pragma mark -广告过滤
- (void)filterAds:(NSDictionary*)ads
{
    self.adsArray = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
    for (NSDictionary *ad in ads[@"list"]){
        if ([ad[@"local"] isEqualToString:@"2"]) {
            NSDate *endTime = [formatter dateFromString:ad[@"adEndTime"]];
            NSDate *currentDate = [NSDate date];
            
            if ([endTime compare:currentDate] == NSOrderedAscending) {
                continue;
            }

            [self.adsArray addObject:ad];
        }
    }
}


#pragma mark - 广告轮播
- (void)switchAds
{
    if (!self.adsArray.count>0) {
        return;
    }
    NSString *imageUrl = self.adsArray[self.adsIndex][@"pic"];
    imageUrl = [serverImageUrl stringByAppendingString:imageUrl];
    self.ad.imageUrl = imageUrl;
    if (self.adsIndex == self.adsArray.count-1) {
        self.adsIndex = 0;
    }else{
        self.adsIndex++;
    }
    
    [self performSelector:@selector(switchAds) withObject:nil afterDelay:5];
}


@end
