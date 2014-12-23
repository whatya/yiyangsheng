//
//  RegistCell.m
//  YangSheng-ios-3.0
//
//  Created by caoguochi on 14-3-22.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "RegistCell.h"

@implementation RegistCell
- (IBAction)hideKeyboard:(UITextField *)sender
{
    [sender resignFirstResponder];
}
- (void)setRegistModel:(RegistModel *)registModel
{
    
    _registModel = registModel;
    self.nameLabel.text = registModel.nameString;
    if (registModel.answerString.length == 0) {
        self.answerLabel.text = @"请选择";
    }else{
        self.answerLabel.text = registModel.answerString;
        self.answerTextField.text = registModel.answerString;
    }
    if (registModel.answerType) {
        self.answerLabel.hidden = NO;
        self.answerTextField.hidden = YES;
    }else
    {
        self.answerLabel.hidden = YES;
        self.answerTextField.hidden = NO;
    }
    [self setNeedsDisplay];
}


@end
