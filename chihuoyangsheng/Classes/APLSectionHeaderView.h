//
//  CustomTextView.m
//  TVAnimationsGestures
//
//  Created by Bob Zhang on 14-3-9.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SectionHeaderViewDelegate;




@interface APLSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *disclosureButton;
@property (nonatomic, weak) IBOutlet UIButton *choosenButton;
@property (nonatomic, weak) IBOutlet id <SectionHeaderViewDelegate> delegate;

@property (nonatomic) NSInteger section;

- (void)toggleOpenWithUserAction:(BOOL)userAction;

@end

#pragma mark -

@protocol SectionHeaderViewDelegate <NSObject>

@optional

- (void)sectionHeaderView:(APLSectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section;
- (void)sectionHeaderView:(APLSectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section;

@end

