//
//  PriceInputVC.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-8-21.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "PriceInputVC.h"

@interface PriceInputVC ()
@property (weak, nonatomic) IBOutlet UITextField *priceInput;

@end

@implementation PriceInputVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.priceString = self.priceInput.text;
}


@end
