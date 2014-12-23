//
//  FeedBackSubmitViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-23.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "FeedBackSubmitViewController.h"
#import "GuideSuggestionsServiceImplServiceSoapBinding.h"
#import "WhereAmI.h"
#import "AppDelegate.h"
#import "GloblalSharedDataManager.h"

@interface FeedBackSubmitViewController ()<UITextViewDelegate,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *feedbackInputTextView;

@end

@implementation FeedBackSubmitViewController


- (IBAction)submitFeedback:(UIButton *)sender
{
    

    
    if ([self.feedbackInputTextView.text isEqualToString:@"请留下宝贵意见！"]
        || self.feedbackInputTextView.text.length == 0) {
        return;
    }
    GloblalSharedDataManager *manager = [GloblalSharedDataManager sharedDataManager];
    GuideSuggestionsServiceImplServiceSoapBinding *suggestionBinding = [[GuideSuggestionsServiceImplServiceSoapBinding alloc] init];
    Guidesuggestions *advice = [[Guidesuggestions alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    advice.content = self.feedbackInputTextView.text;
    advice.customerId = manager.customer.get_id;
    advice.nickname = manager.customer.nickname;
    advice.createTime = [formatter stringFromDate:[NSDate date]];
    [suggestionBinding saveAsync:advice __target:self __handler:@selector(suggestionSaved:)];
}

- (void)suggestionSaved:(id)obj
{
    UIAlertView *suggestionSaved = [[UIAlertView alloc] initWithTitle:@"提交成功！"
                                                              message:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"确定"
                                                    otherButtonTitles:nil, nil];
    [suggestionSaved show];
    [self.feedbackInputTextView resignFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.feedbackInputTextView.delegate = self;
    self.feedbackInputTextView.layer.cornerRadius = 10;
    self.feedbackInputTextView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.feedbackInputTextView.layer.borderWidth = 1.0f;
    
    
}
- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender {
    [self.feedbackInputTextView resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
}


- (void)exitHomePage
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate moveToLoginPage];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if ([alertView.title isEqualToString:@"提示"]) {
        if (buttonIndex == 1) {
            [self exitHomePage];
        }
    }else{
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
}
@end
