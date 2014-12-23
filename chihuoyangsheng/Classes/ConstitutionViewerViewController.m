//
//  ConstitutionViewerViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-31.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "ConstitutionViewerViewController.h"
#import "GloblalSharedDataManager.h"
#import "WhereAmI.h"
#import "Util.h"

@interface ConstitutionViewerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *constitutionDescTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *imagesScrollView;
@property (nonatomic,strong) NSDictionary *constitutionDictionary;
@end

@implementation ConstitutionViewerViewController


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *allKeys = [self.constitutionDictionary allKeys];
    return allKeys[section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSArray *allKeys = [self.constitutionDictionary allKeys];
    allKeys = [[allKeys reverseObjectEnumerator] allObjects];
    NSString *itemString = [self.constitutionDictionary objectForKey:allKeys[indexPath.section]];
    UILabel *label = (UILabel*)[cell viewWithTag:911];
    label.text = itemString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *allKeys = [self.constitutionDictionary allKeys];
    NSString *itemString = [self.constitutionDictionary objectForKey:allKeys[indexPath.section]];
    return [self heightForString:itemString andWidth:320];
}





/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(NSString *)value andWidth:(float)width{

    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:nil        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 56.0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     GloblalSharedDataManager *manager = [GloblalSharedDataManager sharedDataManager];
    
    NSString *locaton = [[WhereAmI shareLoaction] currentLocation];
    NSString *constitutionName = @"";
    if ([locaton isEqualToString:@"随便看看"]) {
        self.constitutionDescTextView.text = [Util constitutionDescriptionForConstitutionName:manager.constitutionName];
        constitutionName = manager.constitutionName;
        self.title = manager.constitutionName;
    }else{
        self.title = manager.customer.constitutionName;
        self.constitutionDescTextView.text = [Util constitutionDescriptionForConstitutionName:manager.customer.constitutionName];
        constitutionName = manager.customer.constitutionName;
    }
    
    self.imagesScrollView.contentSize = CGSizeMake(100*6, 118);
    
    
    for (int i = 0;i < 6; i ++){
        NSString *tempName = [NSString stringWithFormat:@"%@%d.png",constitutionName,i];
        UIImage *tempImage = [UIImage imageNamed:tempName];
        UIImageView *tempImageView = [[UIImageView alloc] init];
        tempImageView.image = tempImage;
        tempImageView.frame = CGRectMake(i*100, 0, 100, 118);
        //[tempImageView sizeToFit];
        [self.imagesScrollView addSubview:tempImageView];
    }
}

- (NSDictionary *)constitutionDictionary
{
    if (!_constitutionDictionary) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"constitution" ofType:@"plist"];
        NSDictionary *questionDic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSString *constitutionType = [GloblalSharedDataManager sharedDataManager].customer.constitutionName;
         NSString *locaton = [[WhereAmI shareLoaction] currentLocation];
        if ([locaton isEqualToString:@"随便看看"]) {
            constitutionType = [GloblalSharedDataManager sharedDataManager].constitutionName;
        }
        
        _constitutionDictionary = [questionDic objectForKey:constitutionType];
    }
    return _constitutionDictionary;
}


@end
