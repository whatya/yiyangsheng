//
//  CustomTextView.m
//  TVAnimationsGestures
//
//  Created by Bob Zhang on 14-3-9.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//
#import "APLSectionHeaderView.h"

@implementation APLSectionHeaderView

- (void)awakeFromNib {
    self.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.layer.borderWidth = 0.6f;
    [self.disclosureButton setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateSelected];
    [self.choosenButton setImage:[UIImage imageNamed:@"choose_yes.png"] forState:UIControlStateSelected];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(toggleOpen:)];
    [self addGestureRecognizer:tapGesture];
}



- (IBAction)toggleOpen:(id)sender {
    
    [self toggleOpenWithUserAction:YES];
}

- (void)toggleOpenWithUserAction:(BOOL)userAction {
    
    self.disclosureButton.selected = !self.disclosureButton.selected;
    self.choosenButton.selected = !self.choosenButton.selected;
    
    if (userAction) {
        if (self.disclosureButton.selected) {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
                [self.delegate sectionHeaderView:self sectionOpened:self.section];
            }
        }
        else {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                [self.delegate sectionHeaderView:self sectionClosed:self.section];
            }
        }
    }
}

@end
