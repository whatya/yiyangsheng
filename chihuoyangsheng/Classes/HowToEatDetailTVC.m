//
//  HowToEatDetailTVC.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-9.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "HowToEatDetailTVC.h"
#import "AsycImageView.h"
#import "GloblalSharedDataManager.h"
#import "WhereAmI.h"
static NSString *serverImageFolder = @"http://115.28.170.201/yssl/uploadFiles/";


@interface HowToEatDetailTVC ()

@property (weak, nonatomic) IBOutlet AsycImageView *cookBookImage;
@property (weak, nonatomic) IBOutlet UILabel *cookBookNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *cookBookDescriptionTextView;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *allStaticRows;
@property (weak, nonatomic) IBOutlet UIButton *tester;

@end

@implementation HowToEatDetailTVC

+ (NSDictionary *)bodyTypeKV
{
    return  @{@"阳虚质": @"yangxz",@"阴虚质": @"yinxz",@"气虚质": @"qixz",@"痰湿质": @"tanxz",@"湿热质": @"shirez",@"血瘀质": @"xueyz",@"特禀质": @"tebz",@"气郁质": @"qiyz",@"平和质": @"pinghz"};
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",serverImageFolder,self.cookBookDictionary[@"image"]];
    self.cookBookImage.imageUrl = imageUrl;
    self.title = self.cookBookDictionary[@"cookbookName"];
    
    NSString *constitionName = [GloblalSharedDataManager sharedDataManager].customer.constitutionName;
    NSString *currentLocation = [WhereAmI shareLoaction].currentLocation;
    if ([currentLocation isEqualToString:@"随便看看"]) {
        constitionName = [GloblalSharedDataManager sharedDataManager].constitutionName;
    }
   NSString *constituionKey = [HowToEatDetailTVC bodyTypeKV][constitionName];
    self.cookBookNameLabel.text = [NSString stringWithFormat:@"%@的人怎么吃",constitionName];
    NSString *desc = self.cookBookDictionary[constituionKey];
    if (!desc || [desc isKindOfClass:[NSNull class]]) {
        self.cookBookDescriptionTextView.text = @"暂无介绍!";
    }else{
        self.cookBookDescriptionTextView.text = desc;
    }
}

//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//    UITableViewCell *temp =  self.allStaticRows[indexPath.row];
//
//    if (indexPath.row == 0) {
//        UILabel *nameLabell = temp.contentView.subviews[0];
//        nameLabell.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate";
//        [temp setNeedsLayout];
//        [temp layoutIfNeeded];
//        return [temp.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+10;
//    }
//
//    return temp.bounds.size.height;
//}


@end
