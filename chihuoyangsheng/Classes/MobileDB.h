//
//  MobileDB.h
//  chihuoyangsheng
//
//  Created by Bob Zhang on 14-5-26.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBackWithDictionary)(NSMutableDictionary* dictionary);

@interface MobileDB : NSObject

#pragma mark - Base

+ (MobileDB*) dbInstance;

- (id) initWithFile: (NSString*) filePathName;

- (void)fetchAllBaseFoodFromServer;

- (void)fetchAllDictionaryFromServer;

- (void)fetchAllAreaFromServer;

- (void)allBaseFood:(CallBackWithDictionary)callBack;

- (NSMutableDictionary*)allBaseFood;

- (NSMutableDictionary*)allDictionaries;

- (NSMutableArray*)allCities;

- (NSMutableArray*)allProvinces;

@end
