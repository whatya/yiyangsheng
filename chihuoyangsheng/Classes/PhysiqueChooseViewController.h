//
//  PhysiqueChooseViewController.h
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-11.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APLSectionHeaderView.h"
#import "BasicInformationViewer.h"
@interface PhysiqueChooseViewController : UIViewController<SectionHeaderViewDelegate>

@property (nonatomic) NSArray *sectionHeaders;
@property (nonatomic,weak) BasicInformationViewer *basicInformationViewer;
- (void)dismisAndReloadParent;
@end
