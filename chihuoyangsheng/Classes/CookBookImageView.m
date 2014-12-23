//
//  CookBookImageView.mq//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-2.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "CookBookImageView.h"
@implementation CookBookImageView

- (void)setImageUrlString:(NSString *)imageUrlString
{
    _imageUrlString = imageUrlString;
    
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]
                                                                      delegate: nil
                                                                 delegateQueue: [NSOperationQueue mainQueue]];
    
    [[delegateFreeSession dataTaskWithURL: [NSURL URLWithString:self.imageUrlString]
                        completionHandler:^(NSData *data, NSURLResponse *response,
                                            NSError *error) {
                            
                            if (!error) {
                                UIImage *dowloadImage = [UIImage imageWithData:data];
                                self.image = dowloadImage;
                            }
                            
                        }] resume];

    
}

@end
