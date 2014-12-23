//
//  GloblalSharedDataManager.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-28.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "GloblalSharedDataManager.h"
#import "AllDicsDictTypeServiceImplServiceSoapBinding.h"
#import "DicDictServiceImplServiceSoapBinding.h"
#import "AllDicsdictType.h"
#import "PrintObject.h"
#import "AreaAreaServiceImplServiceSoapBinding.h"
#import "Areaprovince.h"
#import "Areacity.h"
#import "BaseFoodBaseFoodServiceImplServiceSoapBinding.h"
#import "BaseFoodjsonData.h"
#import "WhereAmI.h"
#import "MobileDB.h"
#import "MealService.h"

#pragma mark- 单利初始化
@implementation GloblalSharedDataManager

- (void)showNetworkWarining
{
    
}

+ (GloblalSharedDataManager*)sharedDataManager
{
    static GloblalSharedDataManager *_sharedDataManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *userInfromation = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInformation"];
        if (userInfromation) {
            _sharedDataManager = [[self alloc] initFromUserDefaults];
        }else{
            _sharedDataManager = [[super alloc] init];
        }
        [_sharedDataManager synchronousToUserDefaults];
    });
    
    
    return _sharedDataManager;
}





- (instancetype)initFromUserDefaults
{
    self = [super init];
    if (self) {
        NSDictionary *userInfromation = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInformation"];
        if (userInfromation) {
            _customer = [[Customercustomer alloc] init];
            _healthRecord = [[CustomerhealthRecord alloc] init];
            [_customer setValuesForKeysWithDictionary:userInfromation[@"customer"]];
            [_healthRecord setValuesForKeysWithDictionary:userInfromation[@"healthRecord"]];
            _autoLogin = userInfromation[@"autoLogin"];
            
        }else{
            self = nil;
        }
    }
    return self;
}


- (void)synchronousToUserDefaults
{
    NSDictionary *userInformation = [PrintObject getObjectData:self];
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    [userData setObject:userInformation forKey:@"userInformation"];
    [userData synchronize];
}

#pragma mark- 根据属性名称从字典中获取对应的idkey
- (NSString*)id_keyForName:(NSString*)nameForKey
{
    NSString *id_key = self.entireDictionary[nameForKey][@"_id"];
    return id_key;
}

- (NSString*)name_ForKey:(NSString*)nameKey
{
    NSString *name = self.entireDictionary[nameKey][@"dictName"];
    return name;
}

- (WhereAmI *)currentLocation
{
    return [WhereAmI shareLoaction];
}


+ (GloblalSharedDataManager*)sharedDataManagerForRegistion
{
    static GloblalSharedDataManager *_sharedDataManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataManager = [[GloblalSharedDataManager alloc] init];
        _sharedDataManager.customer = [[Customercustomer alloc] init];
        _sharedDataManager.healthRecord = [[CustomerhealthRecord alloc] init];
    });
    
    
    return _sharedDataManager;
}

- (NSString *)cityNameForKey:(NSString *)cityKey
{
    for (id key in self.cityName_cityID.allKeys){
        NSString *temp = self.cityName_cityID[key];
        if ([temp isEqualToString:cityKey]) {
            return key;
        }
    }
    return nil;
}

- (NSMutableDictionary*)baseFoodDictionary
{
    if (!_baseFoodDictionary) {
        _baseFoodDictionary = [[MobileDB dbInstance] allBaseFood];
    }
    return _baseFoodDictionary;
}

- (NSMutableDictionary*)entireDictionary
{
    if (!_entireDictionary) {
        _entireDictionary = [[MobileDB dbInstance] allDictionaries];
    }
    return _entireDictionary;
}

- (NSMutableDictionary*)provinceID_provinceName
{
    if (!_provinceID_provinceName) {
        _provinceID_provinceName = [[NSMutableDictionary alloc] init];
        NSArray *pros = [[MobileDB dbInstance] allProvinces];
        for (Areaprovince *pro in pros){
            [_provinceID_provinceName setObject:pro.getName forKey:pro.get_id];
        }
    }
    return _provinceID_provinceName;
}

- (NSMutableDictionary*)provinceName_provinceID
{
    if (!_provinceName_provinceID) {
        _provinceName_provinceID = [[NSMutableDictionary alloc] init];
        NSArray *pros = [[MobileDB dbInstance] allProvinces];
        for (Areaprovince *pro in pros){
            [_provinceName_provinceID setObject:pro.get_id forKey:pro.getName];
        }

    }
    return _provinceName_provinceID;
}

- (NSMutableDictionary*)cityName_cityID
{
    if (!_cityName_cityID) {
        _cityName_cityID = [[NSMutableDictionary alloc] init];
        NSArray *cits = [[MobileDB dbInstance] allCities] ;
        for (Areacity *city in cits){
            [_cityName_cityID setObject:city.get_id forKey:city.getName];
        }
    }
    return _cityName_cityID;
}

- (NSMutableDictionary*)addressDictionary
{
    if (!_addressDictionary) {
        _addressDictionary = [[NSMutableDictionary alloc] init];
        
        NSArray *pros = [[MobileDB dbInstance] allProvinces];
        NSArray *cits = [[MobileDB dbInstance] allCities];
        
        for (Areaprovince *pro in pros){
            NSMutableArray *cities = [[NSMutableArray alloc] init];
            [_addressDictionary setObject:cities forKey:pro.getName];
        }
        
        for (Areacity *city in cits){
            [_addressDictionary[self.provinceID_provinceName[city.getProvinceId]] addObject:city.getName];
        }

    }
    return _addressDictionary;
    
}


@end
