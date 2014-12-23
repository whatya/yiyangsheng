//
//  RegistCell.h
//  YangSheng-ios-3.0
//
//  Created by caoguochi on 14-3-22.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistModel.h"

@interface RegistCell : UITableViewCell
@property (strong, nonatomic) RegistModel *registModel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@end
