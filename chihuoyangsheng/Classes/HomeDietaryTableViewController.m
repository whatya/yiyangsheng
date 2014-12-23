//
//  HomeDietaryTableViewController.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-8-18.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "HomeDietaryTableViewController.h"
#import "GloblalSharedDataManager.h"
#import "CookBookTableViewController.h"
#import "RNFrostedSidebar.h"
#import "AppDelegate.h"
#import "DietaryDatePickerVC.h"
#import "MealService.h"
#import "AsycImageView.h"
#import "ADViewController.h"
#import "HFNDietaryAdviceServiceImplServiceSoapBinding.h"
#import "ProgressHUD.h"


#define centerPoint self.swapView.center
#define leftPoint CGPointMake(self.swapView.center.x - self.swapView.bounds.size.width, self.swapView.center.y)
#define rightPoint CGPointMake(self.swapView.center.x + self.swapView.bounds.size.width, self.swapView.center.y)
@interface HomeDietaryTableViewController ()<RNFrostedSidebarDelegate>

@property (weak, nonatomic) IBOutlet UIButton *timeMark;

@property (nonatomic,strong) NSString *visitType;
@property (nonatomic,strong) NSString *constitutionID;
@property (nonatomic,strong) NSString *dietaryDateString;
@property (nonatomic,strong) NSString *provinceId;
@property (nonatomic,strong) NSString *cityId;

@property (nonatomic,strong) NSMutableArray *adsArray;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *allStataicCells;

@property (strong,nonatomic) HFNdietaryAdvice *adviceWithDate;

@property (strong,nonatomic) NSMutableArray *adviceArray;


@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (weak, nonatomic) IBOutlet UILabel *constitutionNameLabel;


#pragma mark- swap iages
@property (weak, nonatomic) IBOutlet UIView *swapView;
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *frontView;
@property (strong,nonatomic) NSMutableArray *imageUrls;
@property (nonatomic) int currentIndex;
@property (nonatomic,strong) NSURLSession *delegateFreeSession;
@end

@implementation HomeDietaryTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [WhereAmI shareLoaction].isUpdating = NO;
    NSString *location = [WhereAmI shareLoaction].currentLocation;
    NSString *constitutionNameText = [GloblalSharedDataManager sharedDataManager].customer.constitutionName;
    if ([location isEqualToString:@"随便看看"]) {
        constitutionNameText = [GloblalSharedDataManager sharedDataManager].constitutionName;
    }
    self.constitutionNameLabel.text = constitutionNameText;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    [self configurationPostParameters];
    [self fetchDietary];
    [self fetchHomePageAds];
}

#pragma mark- show sidebar

- (IBAction)onBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"sidebar_cookbook"],
                        [UIImage imageNamed:@"sidebar_basefood"],
                        [UIImage imageNamed:@"sidebar_profile"],
                        [UIImage imageNamed:@"sidebar_test"],
                        [UIImage imageNamed:@"sideBar_suggestion"],
                        [UIImage imageNamed:@"sidebar_exit"],
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images
                                                         selectedIndices:self.optionIndices
                                                            borderColors:colors];
    callout.title = @"每日食谱";
    callout.delegate = self;
    callout.showFromRight = YES;
    callout.tintColor = [UIColor colorWithRed:231/255.f green:211/255.f blue:169/255.f alpha:0.83];
    callout.itemSize = CGSizeMake(85, 85);
    [callout show];
}


#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    [sidebar dismissAnimated:YES completion:nil];
    switch (index) {
        case 0:
            if ([self isTourist]) {
                [self performSegueWithIdentifier:@"choose a date" sender:self];
            }
            break;
        case 1:
            [self performSegueWithIdentifier:@"base food view controller" sender:self];
            break;
        case 2:
            if ([self isTourist]) {
                [self showUser];
            }
            break;
        case 3:
            [self showBodyTest];
            break;
        case 4:
            [self performSegueWithIdentifier:@"post suggestion view controller" sender:self];
            break;
        case 5:
            [self exitHomePage];
            break;

        default:
            break;
    }
    
}

#pragma mark- 个人信息页面
- (void)showUser
{
    UIStoryboard *loginBoard = [UIStoryboard storyboardWithName:@"PersionalInfoManager" bundle:nil];
    UIViewController *test = [loginBoard instantiateInitialViewController];
    [self.navigationController pushViewController:test animated:YES];
}

#pragma mark- 体质测试界面
- (void)showBodyTest
{
    
    UIStoryboard *loginBoard = [UIStoryboard storyboardWithName:@"MainBranch" bundle:nil];
    UIViewController *test = [loginBoard instantiateViewControllerWithIdentifier:@"healthTestVC"];
    [self.navigationController pushViewController:test animated:YES];
}


#pragma mark- 返回登陆界面
- (void)exitHomePage
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate moveToLoginPage];
}

#pragma mark- 配置请求参数
- (void)configurationPostParameters
{
    GloblalSharedDataManager *manager = [GloblalSharedDataManager sharedDataManager];
    NSString *location = [[WhereAmI shareLoaction] currentLocation];
    if ([location isEqualToString:@"随便看看"]) {
        self.constitutionID = manager.constitution;
        self.provinceId = manager.cityId;
        self.cityId = manager.provinceId;
        self.title = @"游客";
        
    }else{
        self.constitutionID = manager.customer.constitution;
        self.provinceId = manager.customer.cityId;
        self.cityId = manager.customer.provinceId;
        self.title = manager.customer.nickname;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dietaryDateString = self.dietaryDateString ? self.dietaryDateString : [formatter stringFromDate:[NSDate date]];
}

#pragma mark -请求食谱
- (void)fetchDietary
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        HFNDietaryAdviceServiceImplServiceSoapBinding *newGetter = [[HFNDietaryAdviceServiceImplServiceSoapBinding alloc] init];
        
        [ProgressHUD show:@"获取食谱中..."];
        HFNdietaryAdvice *postAdvice = [[HFNdietaryAdvice alloc] init];
        postAdvice.cookbookDate = self.dietaryDateString;
        postAdvice.provinceId = self.provinceId;
        postAdvice.cityId = self.cityId;
        postAdvice.constitution = self.constitutionID;
        HFNjsonData *tempJsonData = [newGetter findDietaryAdvice:1
                                                                    arg1:1
                                                                    arg2:postAdvice
                                                                 __error:NULL];
        
        NSArray *gotData = tempJsonData.rows;
        HFNdietaryAdvice *adviceItem = [gotData firstObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"食谱json：%@",adviceItem);
            self.adviceWithDate = adviceItem;
            if (self.adviceWithDate) {
                [ProgressHUD showSuccess:@"食谱获取成功！"];
            }else{
                [ProgressHUD showError:@"没有食谱信息！"];
            }
            [self updateTimeMark];
            [self.tableView reloadData];
        });
    });
    
}


#pragma mark- 设置左上角时间按钮
- (void)updateTimeMark
{
    NSString *newDateString = [self.adviceWithDate.cookbookDate substringFromIndex:5];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    if ([newDateString isEqualToString:date]) {
        [self.timeMark setTitle:@"今天" forState:UIControlStateNormal];
    }else{
        [self.timeMark setTitle:newDateString
                       forState:UIControlStateNormal];
        
    }
    
}


#pragma mark- tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * temp = self.allStataicCells[indexPath.row];
    [self configurateCellWithRowIndex:indexPath.row andCell:temp];
    [temp setNeedsLayout];
    [temp layoutIfNeeded];
    return [temp.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}


#pragma mark- configurateCellContent
- (void)configurateCellWithRowIndex:(NSInteger)index andCell:(UITableViewCell*)cell
{
    if (!self.adviceWithDate) {
        return;
    }
    if (index == 2) {
        UILabel *constitutionLabel = cell.contentView.subviews[1];
        constitutionLabel.text = self.adviceWithDate.constitutionName;
    }else if (index == 4){
        UILabel *shouldLabel = cell.contentView.subviews[1];
        shouldLabel.text = self.adviceWithDate.suitable;
    }else if (index == 5){
        UILabel *tabooLabel = cell.contentView.subviews[1];
        tabooLabel.text = self.adviceWithDate.taboo;
    }else if (index == 6){
        UILabel *tabooLabel = cell.contentView.subviews[1];
        tabooLabel.text = self.adviceWithDate.ys;
    }else if (index == 8){
        UILabel *morningLabel = cell.contentView.subviews[1];
        morningLabel.text = self.adviceWithDate.breakfast;
    }else if (index == 9){
        UILabel *lunchLabel = cell.contentView.subviews[1];
        lunchLabel.text = self.adviceWithDate.lunch;
    }
    else if (index == 10){
        UILabel *supperLabel = cell.contentView.subviews[1];
        supperLabel.text = self.adviceWithDate.supper;
    }
    else if (index == 11){
        UILabel *fruitLabel = cell.contentView.subviews[1];
        fruitLabel.text = self.adviceWithDate.fruit;
    }
    else if (index == 12){
        UILabel *teaLabel = cell.contentView.subviews[1];
        teaLabel.text = self.adviceWithDate.tea;
    }else if (index == 1){
        UILabel *weatherType = (UILabel*)[cell viewWithTag:2001];
        UILabel *tempreture = (UILabel*)[cell viewWithTag:2002];
        UILabel *cityName = (UILabel*)[cell viewWithTag:2003];
        
        NSData *data = [self.adviceWithDate.weather dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
        if (jsonResponse) {
            weatherType.text = jsonResponse[@"weatherinfo"][@"weather"];
            tempreture.text = [NSString stringWithFormat:@"%@/%@",jsonResponse[@"weatherinfo"][@"temp2"],jsonResponse[@"weatherinfo"][@"temp1"]];
            // self.currentDate.text = jsonResponse[@"weatherinfo"][@"ptime"];;
            cityName.text = jsonResponse[@"weatherinfo"][@"city"];;
        }
    }
    
}

#pragma mark- perform segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     if ([segue.identifier isEqualToString:@"show my body description"] ||
     [segue.identifier isEqualToString:@"base food view controller"] ||
     [segue.identifier isEqualToString:@"post suggestion view controller"] ||
     [segue.identifier isEqualToString:@"body test view controller"] ||
     [segue.identifier isEqualToString:@"choose a date"]) {
     return;
     }
     
     int segueID = [segue.identifier intValue];
     NSString *cookListTitle = nil;
     switch (segueID) {
     case 1:
     cookListTitle = @"早餐";
     break;
     case 2:
     cookListTitle = @"午餐";
     break;
     case 3:
     cookListTitle = @"晚餐";
     break;
     case 4:
     cookListTitle = @"水果";
     break;
     case 5:
     cookListTitle = @"茶";
     break;
     default:
     cookListTitle = @"早餐";
     break;
     }
     
     CookBookTableViewController *cookBookTVC = segue.destinationViewController;
     cookBookTVC.title = cookListTitle;
     
     //分割字符串数组
     UITableViewCell *cell = sender;
     UILabel *foodNameLabel = cell.contentView.subviews[1];
     NSString *foodNamesString = [foodNameLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
     NSArray * temp = [self stringToArray:foodNamesString];
     cookBookTVC.cookBookNames = temp;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ADViewController *ad = [storyboard instantiateViewControllerWithIdentifier:@"AD"];
        if (self.adsArray.count > 0) {
           ad.ADUrl = self.adsArray[self.currentIndex][@"url"];
            [self.navigationController pushViewController:ad animated:YES];
        }
    }
}

#pragma mark - 验证是否是游客
- (BOOL)isTourist
{
    NSString *location = [[WhereAmI shareLoaction] currentLocation];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请注册或登录!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    if ([location isEqualToString:@"随便看看"]) {
        [alert show];
        return NO;
    }else{
        return YES;
    }
    
}

#pragma mark- 分割字符串为数组
- (NSArray*)stringToArray:(NSString*)foodString
{
    NSArray *array = nil;
    if ([foodString rangeOfString:@"+"].location != NSNotFound) {
        array = [foodString componentsSeparatedByString:@"+"];
    }else if ([foodString rangeOfString:@"、"].location != NSNotFound){
        array = [foodString componentsSeparatedByString:@"、"];
    }
    
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    //去除括号里面的内容
    for (int i = 0; i < array.count; i++) {
        NSString *name = array[i];
        if ([name rangeOfString:@"（"].location != NSNotFound) {
            name = [name substringToIndex:[name rangeOfString:@"（"].location];
        }
        newArray[i]= name;
    }
    
    for (NSString *name in newArray){
        NSLog(@"%@",name);
    }
    
    return newArray;
}


#pragma mark- 获取广告
- (void)fetchHomePageAds
{
    [MealService fetchDictionaryFromServerWithBaseUrl:@"findAd.ws"
                                          queryString:@"pageParam={'page':1,'rows':10}"
                                             callBack:^(id dictionary) {
                                                 if ([dictionary isKindOfClass:[NSDictionary class]]) {
                                                     [self filterAds:dictionary];
                                                 }
                                             }];
}

#pragma mark -广告过滤
- (void)filterAds:(NSDictionary*)ads
{
    self.adsArray = [[NSMutableArray alloc] init];
    self.imageUrls = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
    for (NSDictionary *ad in ads[@"list"]){
        if ([ad[@"local"] isEqualToString:@"1"]) {
            NSDate *endTime = [formatter dateFromString:ad[@"adEndTime"]];
            NSDate *currentDate = [NSDate date];
            
            if ([endTime compare:currentDate] == NSOrderedAscending) {
                continue;
            }
            
            NSString *picName = ad[@"pic"];
            NSString *adImageUrl = [serverImageUrl stringByAppendingString:picName];
            
            [self.imageUrls addObject:adImageUrl];
            [self.adsArray addObject:ad];
        }
    }
    if (self.imageUrls.count < 2) {
        return;
    }
    [self fillImage:self.frontView withUrlString:self.imageUrls[0] withBOOL:NO];
    [self fillImage:self.backView withUrlString:self.imageUrls[1] withBOOL:YES];
    self.currentIndex = 1;
}


#pragma mark- unwind methods
-(void)searchDietaryWithDateString:(NSString *)dateString
{
    self.dietaryDateString = dateString;
    [self configurationPostParameters];
    [self fetchDietary];
}


#pragma mark- swap images methods

#pragma mark- 图片轮播
- (void)fire
{
    self.backView.center = rightPoint;
    
    [UIView animateWithDuration:1
                          delay:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frontView.center = leftPoint;
                         self.backView.center = centerPoint;
                         
                     } completion:^(BOOL finished) {
                         UIImageView *temp = self.frontView;
                         self.frontView = self.backView;
                         self.backView = temp;
                         if (self.currentIndex < self.imageUrls.count-1) {
                             self.currentIndex++;
                         }else{
                             self.currentIndex = 0;
                         }
                         [self fillImage:self.backView
                           withUrlString:self.imageUrls[self.currentIndex]
                                withBOOL:YES];
                     }];
}

#pragma mark- 下载图片
- (void)fillImage:(UIImageView*)beFilledImgaeView withUrlString:(NSString*)imageUrl withBOOL:(BOOL)flag
{
    [[self.delegateFreeSession dataTaskWithURL: [NSURL URLWithString:imageUrl]
                             completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
                                 if (!error) {
                                     UIImage *dowloadImage = [UIImage imageWithData:data];
                                     if (dowloadImage) {
                                         beFilledImgaeView.image = dowloadImage;
                                         [self.swapView layoutSubviews];
                                         if (flag) {
                                             [self fire];
                                         }
                                     }
                                 }
                             }]
     resume];
}

#pragma mark- getter session
- (NSURLSession *)delegateFreeSession
{
    if (!_delegateFreeSession) {
        _delegateFreeSession = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]
                                                             delegate: nil
                                                        delegateQueue: [NSOperationQueue mainQueue]];
    }
    return _delegateFreeSession;
}


@end
