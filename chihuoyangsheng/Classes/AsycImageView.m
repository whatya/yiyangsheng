//
//  AsycImageView.m
//  chihuoyangsheng
//
//  Created by Bob Zhang on 14-7-22.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "AsycImageView.h"

@implementation AsycImageView

-(void)setImageUrl:(NSString *)imageUrl
{
    if (imageUrl &&![imageUrl isKindOfClass:[NSNull class]]) {
        _imageUrl = imageUrl;
        NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]
                                                                          delegate: nil
                                                                     delegateQueue: [NSOperationQueue mainQueue]];
        
        [[delegateFreeSession dataTaskWithURL: [NSURL URLWithString:self.imageUrl]
                            completionHandler:^(NSData *data, NSURLResponse *response,
                                                NSError *error) {
                                
                                if (!error) {
                                    UIImage *dowloadImage = [UIImage imageWithData:data];
                                    if (dowloadImage) {
                                        self.image = dowloadImage;
                                    }
                                }
                                
                            }] resume];

    }
    
}

@end
