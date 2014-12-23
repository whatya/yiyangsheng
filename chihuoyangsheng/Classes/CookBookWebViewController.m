//
//  CookBookWebViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-31.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "CookBookWebViewController.h"

@interface CookBookWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pinner;

@end

@implementation CookBookWebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentWebView.delegate = self;
    self.title = self.contentTitle;
    [self.contentWebView setScalesPageToFit:YES];
    [self.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.contentUrl]]];
}

-(void)setContentUrl:(NSString *)contentUrl
{
    _contentUrl = contentUrl;
    [self.contentWebView reload];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.pinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.pinner stopAnimating];
}
@end
