//
//  MenuViewController.h
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
@protocol MenuViewControllerDelegate <NSObject>

- (void)updateDietryWithDateString:(NSString*)dateString andTimeMark:(NSString*)timeMark;

@end

@interface MenuViewController : UIViewController

@property (nonatomic,weak) id<MenuViewControllerDelegate> delegate;

@property (strong,nonatomic) NSString *todayOrTomorrow;

@end
