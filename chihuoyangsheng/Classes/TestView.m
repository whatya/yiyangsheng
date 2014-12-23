//
//  TestView.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-17.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)awakeFromNib
{
    [[NSBundle mainBundle] loadNibNamed:@"TestView"
                                  owner:self options:nil];
    
    [self addSubview: self.contentView];
}

- (IBAction)answerSelected:(UISegmentedControl *)sender
{
    long score = sender.selectedSegmentIndex+1;
    [self.delegate didSelectedAnScore:@(score) inPhysiqueTypeKey:self.physiqueTypeKey questionIndex:self.questionIndex];
}


@end
