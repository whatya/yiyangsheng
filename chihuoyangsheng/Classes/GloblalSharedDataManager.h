//
//  GloblalSharedDataManager.h
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-28.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customercustomer.h"
#import "CustomerhealthRecord.h"
#import "WhereAmI.h"
#import <CoreLocation/CoreLocation.h>

@interface GloblalSharedDataManager : NSObject
@property (nonatomic) BOOL didShowed;

#pragma mark- 当前位置信息
@property (nonatomic,strong) WhereAmI *currentLocation;

#pragma mark- 所有食材信息
@property(nonatomic,strong) NSMutableDictionary *baseFoodDictionary;

#pragma mark- 所有地区信息
@property(nonatomic,strong) NSMutableDictionary *addressDictionary;
#pragma mark- 索引字典信息
@property(nonatomic,strong) NSMutableDictionary *provinceName_provinceID;
@property(nonatomic,strong) NSMutableDictionary *provinceID_provinceName;
@property(nonatomic,strong) NSMutableDictionary *cityName_cityID;

#pragma mark- 所有字典信息
@property(nonatomic,strong) NSMutableDictionary *entireDictionary;

#pragma mark- 同步所有用户信息到UserDefaults
- (void)synchronousToUserDefaults;

#pragma mark- 体质类型详情
@property(nonatomic,strong) NSString *constitutionDescription;

#pragma mark- 用户和健康档案对象
@property (nonatomic,strong) Customercustomer *customer;

@property (nonatomic,strong) CustomerhealthRecord *healthRecord;

#pragma mark - 是否自动登陆
@property (nonatomic,strong) NSString *autoLogin;

#pragma mark - GPS
@property (nonatomic,strong) CLLocation *GPSLocation;

#pragma mark -二期用户信息和健康档案字典
@property (nonatomic,strong) NSDictionary *customerAndHealthrecord;

+ (GloblalSharedDataManager*)sharedDataManagerForRegistion;

- (void)showNetworkWarining;

#pragma mark- 所有用户对应的属性
@property (retain,nonatomic) NSString* ageGroup;

@property (retain,nonatomic) NSString* ageGroupName;

@property (retain,nonatomic) NSString* allergen;

@property (retain,nonatomic) NSString* areaName;

@property (retain,nonatomic) NSString* birthday;

@property (retain,nonatomic) NSString* bloodPressure;

@property (retain,nonatomic) NSString* bloodType;

@property (retain,nonatomic) NSString* bodyMassIndex;

@property (retain,nonatomic) NSString* cityId;

@property (retain,nonatomic) NSString* cityName;

@property (retain,nonatomic) NSString* constitution;

@property (retain,nonatomic) NSString* constitutionName;

@property (retain,nonatomic) NSString* customerName;

@property (retain,nonatomic) NSString* dietHabit;

@property (retain,nonatomic) NSString* education;

@property (retain,nonatomic) NSString* email;

@property (retain,nonatomic) NSString* ethnic;

@property (retain,nonatomic) NSString* ethnicName;

@property (retain,nonatomic) NSString* height;

@property (retain,nonatomic) NSString* _id;

@property (retain,nonatomic) NSString* idNumber;

@property (retain,nonatomic) NSString* idType;

@property (retain,nonatomic) NSString* loginName;

@property (retain,nonatomic) NSString* maritalStatus;

@property (retain,nonatomic) NSString* nickname;

@property (retain,nonatomic) NSString* password;

@property (retain,nonatomic) NSString* phoneNumber;

@property (retain,nonatomic) NSString* profession;

@property (retain,nonatomic) NSString* province;

@property (retain,nonatomic) NSString* provinceId;

@property (retain,nonatomic) NSString* sex;

@property (retain,nonatomic) NSString* testDate;

@property (retain,nonatomic) NSString* weight;


#pragma mark- 所有健康档案对应的属性

@property (retain,nonatomic) NSString* customerId;

@property (retain,nonatomic) NSString* diseaseTypeCode;

@property (retain,nonatomic) NSString* dpac;

@property (retain,nonatomic) NSString* drinkingFr;

@property (retain,nonatomic) NSString* drinkingType;

@property (retain,nonatomic) NSString* drugAllergyFlag;

@property (retain,nonatomic) NSString* drugAllergySource;

@property (retain,nonatomic) NSString* drunkenness;

@property (retain,nonatomic) NSString* familialDiseaseCode;

@property (retain,nonatomic) NSString* geneticDiseases;

@property (retain,nonatomic) NSString* quitSmokingAge;

@property (retain,nonatomic) NSString* relationship;

@property (retain,nonatomic) NSString* smoking;

@property (retain,nonatomic) NSString* smokingAge;

@property (retain,nonatomic) NSString* smokingStatus;

@property (retain,nonatomic) NSString* startDrinkingAge;

@property (retain,nonatomic) NSString* stopDrinkingAge;

@property (retain,nonatomic) NSString* stopDrinkingFlag;

@property (retain,nonatomic) NSString* surgery;

@property (retain,nonatomic) NSString* surgeryFlag;

@property (retain,nonatomic) NSString* surgeryTime;

@property (retain,nonatomic) NSString* transfusionFalg;

@property (retain,nonatomic) NSString* transfusionReason;

@property (retain,nonatomic) NSString* transfusionTime;

@property (retain,nonatomic) NSString* traumaName;

@property (retain,nonatomic) NSString* traumaTime;


+ (GloblalSharedDataManager*)sharedDataManager;

- (NSString*)id_keyForName:(NSString*)nameForKey;

- (NSString*)name_ForKey:(NSString*)nameKey;

- (NSString*)cityNameForKey:(NSString*)cityKey;

@end
