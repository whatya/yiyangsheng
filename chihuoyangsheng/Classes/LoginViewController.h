//
//  LoginViewController.h
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-10.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol loginSuccessDelegate <NSObject>
@required

- (void)dismissLoginVC:(UIViewController*)loginVC;

@end

@interface LoginViewController : UIViewController

@property (nonatomic,weak) id<loginSuccessDelegate> delegate;

@end
