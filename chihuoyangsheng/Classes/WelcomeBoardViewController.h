//
//  WelcomeBoardViewController.h
//  TherapeuticRegimen0.1
//
//  Created by Bob Zhang on 14-3-7.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlidesEnded <NSObject>

- (void)moveToLoginPage;

@end

@interface WelcomeBoardViewController : UIViewController

@property (nonatomic,weak) id<SlidesEnded> delegate;

@end
