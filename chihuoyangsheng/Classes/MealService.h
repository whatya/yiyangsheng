//
//  MealService.h
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-6.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^CallBackWithDictionarys)(id dictionary);

@interface MealService : NSObject

+ (void)fetchDictionaryFromServerWithBaseUrl:(NSString*)baseUrl
                                 queryString:(NSString*)queryString
                                    callBack:(CallBackWithDictionarys)callBack;

@end
