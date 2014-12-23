//
//  RegistModel.m
//  YangSheng-ios-3.0
//
//  Created by caoguochi on 14-3-22.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "RegistModel.h"
#import "GloblalSharedDataManager.h"
#import "WhereAmI.h"
@implementation RegistModel

- (void)setAnswerString:(NSString *)answerString
{
    _answerString = answerString;
    GloblalSharedDataManager *dataManager = [GloblalSharedDataManager sharedDataManager];
    if (_methodKey != nil) {
        //[dataManager setValue:answerString forKey:_methodKey];
        
    
        NSString *registType = [[WhereAmI shareLoaction] registLocation];
        
        
        if ([registType isEqualToString:@"基本信息"]) {
            
            @try {
                [dataManager.customer setValue:answerString forKey:_methodKey];
            }
            @catch (NSException *exception) {
                NSLog(@"setValueError:%@",exception);
            }
            @finally {
               //
            }
            
            
        }else{
            @try {
                [dataManager.healthRecord setValue:answerString forKey:_methodKey];
            }
            @catch (NSException *exception) {
                NSLog(@"setValueError:%@",exception);
            }
            @finally {
                //
            }
            
            
        }
    }
    
    
}
@end
