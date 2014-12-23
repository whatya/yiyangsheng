//
//  ADViewController.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-14.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "ADViewController.h"
#import "ProgressHUD.h"
@interface ADViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webAD;

@end

@implementation ADViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [self.webAD stopLoading];
    [ProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webAD.delegate = self;
    [self updateUI];
}


- (void)setADUrl:(NSString *)ADUrl
{
    _ADUrl = ADUrl;
  
    [self updateUI];
}

- (void)updateUI
{
     [self.webAD loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.ADUrl]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [ProgressHUD show:@"获取中..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD dismiss];
}

@end
