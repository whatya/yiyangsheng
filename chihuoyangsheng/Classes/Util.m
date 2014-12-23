//
//  Util.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "Util.h"
#import "GloblalSharedDataManager.h"

@implementation Util

+(NSString *)constitutionDescriptionForConstitutionName:(NSString *)name
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"headerArrays" withExtension:@"plist"];
    NSArray *dctionariesArrayFromPlist = [[NSArray alloc ] initWithContentsOfURL:url];
    for (NSDictionary *temp in dctionariesArrayFromPlist){
        NSString *headerame =  temp[@"headerName"];
        NSString *newName =[[headerame componentsSeparatedByString:@"-"] firstObject];
        if ([newName isEqualToString:name]) {
           return temp[@"containedItems"][0][@"itemContent"];
        }
    }
    return nil;
}

@end
