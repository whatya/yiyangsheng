//
//  UpdateInformation.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "UpdateInformation.h"
#import "GloblalSharedDataManager.h"
#import "PrintObject.h"
#import "MealService.h"
@implementation UpdateInformation

- (void)update
{
    Customercustomer *customer = [GloblalSharedDataManager sharedDataManager].customer;
    CustomerhealthRecord *healthRecord = [GloblalSharedDataManager sharedDataManager].healthRecord;
    
    NSDictionary *customerDic = [PrintObject getObjectData:customer];
    NSArray *customerKeys = [customerDic allKeys];
    NSString *customerPostString = @"customer={";
    for (NSString *key in customerKeys){
        NSString *valueTemp = [customerDic objectForKey:key];
        if (valueTemp && valueTemp.length > 0) {
            NSString *keyTemp = key;
            if ([key isEqualToString:@"_id"]) {
                keyTemp = @"id";
            }
            customerPostString = [customerPostString stringByAppendingString:[NSString stringWithFormat:@"'%@':'%@',",keyTemp,customerDic[key]]];
        }
    }
    customerPostString = [customerPostString substringToIndex:customerPostString.length-1];
    customerPostString = [customerPostString stringByAppendingString:@"}"];
    
    NSDictionary *healthRecordDic = [PrintObject getObjectData:healthRecord];
    NSArray *healthRecordKeys = [healthRecordDic allKeys];
    NSString *healthRecordPostString = @"healthRecord={";
    for (NSString *key in healthRecordKeys){
        NSString *valueTemp = [healthRecordDic objectForKey:key];
        if (valueTemp && valueTemp.length > 0) {
            NSString *keyTemp = key;
            if ([key isEqualToString:@"_id"]) {
                keyTemp = @"id";
            }
            healthRecordPostString = [healthRecordPostString stringByAppendingString:[NSString stringWithFormat:@"'%@':'%@',",keyTemp,healthRecordDic[key]]];
        }
    }
    healthRecordPostString = [healthRecordPostString substringToIndex:healthRecordPostString.length -1];
    healthRecordPostString = [healthRecordPostString stringByAppendingString:@"}"];
    
    NSString *updatingPostStirng = [NSString stringWithFormat:@"%@&%@",customerPostString,healthRecordPostString];
    
    [MealService fetchDictionaryFromServerWithBaseUrl:@"updateCustomer.ws"
                                          queryString:updatingPostStirng
                                             callBack:^(id dictionary) {
                                                 //
                                                 NSString *result = dictionary;
                                                 if ([result isEqualToString:@"0"]) {
                                                     result = @"修改成功，请重新登录！";
                                                     [self.updater updatedWithCallBack:@"0"];
                                                 }else{
                                                     result = @"修改失败！";
                                                     [self.updater updatedWithCallBack:@"1"];
                                                 }
                                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:result delegate:self.updater cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                 [alert show];
                                             }];
    
   }


@end
