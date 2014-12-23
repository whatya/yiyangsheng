//
//  DescriptionInputVC.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-8-21.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "DescriptionInputVC.h"

@interface DescriptionInputVC ()
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation DescriptionInputVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.descriptionTextView.layer.cornerRadius = 10;
    self.descriptionTextView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.descriptionTextView.layer.borderWidth = 1.0f;
}


- (IBAction)disMiss:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:NULL];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.descriptionInput = self.descriptionTextView.text;
}

@end
