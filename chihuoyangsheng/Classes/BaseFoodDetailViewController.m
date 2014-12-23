//
//  BaseFoodDetailViewController.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-27.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "BaseFoodDetailViewController.h"

@interface BaseFoodDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *foodDetail;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *piner;
@end

@implementation BaseFoodDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self parseHtml];
    self.foodDetail.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.piner stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.piner startAnimating];
}

- (void)parseHtml
{
    
    NSString *foodImageUrl = [NSString stringWithFormat:@"http://115.28.170.201/yssl/uploadFiles/%@",self.food.picture];

    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"食材详细" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString *newHtml = [[[[[[[[[[[[[[[htmlString stringByReplacingOccurrencesOfString:@"食材简介占位符" withString:self.food.introduce] stringByReplacingOccurrencesOfString:@"能量占位符" withString:self.food.energy]
                                   stringByReplacingOccurrencesOfString:@"蛋白质占位符" withString:self.food.protein]
                                  stringByReplacingOccurrencesOfString:@"脂肪占位符" withString:self.food.fat]
                                 stringByReplacingOccurrencesOfString:@"碳水化合物占位符" withString:self.food.carbohydrate]
                                stringByReplacingOccurrencesOfString:@"维生素A占位符" withString:self.food.vitaminA]
                               stringByReplacingOccurrencesOfString:@"B1占位符" withString:self.food.b1]
                              stringByReplacingOccurrencesOfString:@"B2占位符" withString:self.food.b2]
                             stringByReplacingOccurrencesOfString:@"B6占位符" withString:self.food.b6]
                            stringByReplacingOccurrencesOfString:@"叶酸占位符" withString:self.food.folate]
                           stringByReplacingOccurrencesOfString:@"维生素C占位符" withString:self.food.vitaminC]
                          stringByReplacingOccurrencesOfString:@"钙占位符" withString:self.food.calcium]
                         stringByReplacingOccurrencesOfString:@"铁占位符" withString:self.food.ferri]
                         stringByReplacingOccurrencesOfString:@"食材背景占位符" withString:foodImageUrl]
                         stringByReplacingOccurrencesOfString:@"食材名称占位符" withString:self.food.foodName];
    
    
       
    [self.foodDetail loadHTMLString:newHtml baseURL:nil];

}

-(void)setFood:(BaseFoodbaseFood *)food
{
    _food = food;

}

@end
