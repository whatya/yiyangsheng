//
//  TestView.h
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-17.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QuestionViewDelegate

- (void)didSelectedAnScore:(NSNumber*)number inPhysiqueTypeKey:(NSString*)sectionIndex questionIndex:(NSInteger)index;

@end

@interface TestView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *questionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *optionSegementCotrol;
@property (weak,nonatomic) id<QuestionViewDelegate> delegate;
@property (nonatomic) NSUInteger questionIndex;
@property (nonatomic,strong) NSString* physiqueTypeKey;

@end
