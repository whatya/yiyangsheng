//
//  MealService.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-6.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "MealService.h"

@implementation MealService

#pragma mark- 获取天气

+ (void)fetchDictionaryFromServerWithBaseUrl:(NSString *)baseUrl
                                 queryString:(NSString *)queryString
                                    callBack:(CallBackWithDictionarys)callBack
{
    // 1
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",serverUrl,baseUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 3
    NSString *params = queryString;
    NSError *error = nil;
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
 
    if (!error) {
        // 4
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                       
                                                                       NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                               options:kNilOptions
                                                                                                                                 error:&error];
                                                                      
                                                                       if (!error) {
                                                                           callBack(result);
                                                                       }else{
                                                                            NSString *zeroOrOne = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                                           if ([zeroOrOne isEqualToString:@"0"] ||[zeroOrOne isEqualToString:@"1"] ) {
                                                                               callBack(zeroOrOne);
                                                                           }else{
                                                                               callBack(nil);
                                                                           }
                                                                           
                                                                       }
                                                                   }];
        
        // 5
        [uploadTask resume];
    }else{
        NSLog(@"从服务端获取数据出错：%@",[error localizedDescription]);
    }

}


@end
