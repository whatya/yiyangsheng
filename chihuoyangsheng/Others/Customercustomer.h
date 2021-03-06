//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------
#import <Foundation/Foundation.h>
#import "CustomerRequestResultHandler.h"
#import "DDXML.h"

@interface Customercustomer : NSObject 

+ (Customercustomer*)sharedCustomer;

@property (retain,nonatomic,getter=getAgeGroup) NSString* ageGroup;

@property (retain,nonatomic,getter=getAgeGroupName) NSString* ageGroupName;

@property (retain,nonatomic,getter=getAllergen) NSString* allergen;

@property (retain,nonatomic,getter=getAreaName) NSString* areaName;

@property (retain,nonatomic,getter=getBirthday) NSString* birthday;

@property (retain,nonatomic,getter=getBloodPressure) NSString* bloodPressure;

@property (retain,nonatomic,getter=getBloodType) NSString* bloodType;

@property (retain,nonatomic,getter=getBodyMassIndex) NSString* bodyMassIndex;

@property (retain,nonatomic,getter=getCityId) NSString* cityId;

@property (retain,nonatomic,getter=getConstitution) NSString* constitution;

@property (retain,nonatomic,getter=getConstitutionName) NSString* constitutionName;

@property (retain,nonatomic,getter=getCustomerName) NSString* customerName;

@property (retain,nonatomic,getter=getDietHabit) NSString* dietHabit;

@property (retain,nonatomic,getter=getEducation) NSString* education;

@property (retain,nonatomic,getter=getEmail) NSString* email;

@property (retain,nonatomic,getter=getEthnic) NSString* ethnic;

@property (retain,nonatomic,getter=getEthnicName) NSString* ethnicName;

@property (retain,nonatomic,getter=getHeight) NSString* height;

@property (retain,nonatomic,getter=get_id) NSString* _id;

@property (retain,nonatomic,getter=getIdNumber) NSString* idNumber;

@property (retain,nonatomic,getter=getIdType) NSString* idType;

@property (retain,nonatomic,getter=getLoginName) NSString* loginName;

@property (retain,nonatomic,getter=getMaritalStatus) NSString* maritalStatus;

@property (retain,nonatomic,getter=getNickname) NSString* nickname;

@property (retain,nonatomic,getter=getPassword) NSString* password;

@property (retain,nonatomic,getter=getPhoneNumber) NSString* phoneNumber;

@property (retain,nonatomic,getter=getProfession) NSString* profession;

@property (retain,nonatomic,getter=getProvince) NSString* province;

@property (retain,nonatomic,getter=getProvinceId) NSString* provinceId;

@property (retain,nonatomic,getter=getSex) NSString* sex;

@property (retain,nonatomic,getter=getTestDate) NSString* testDate;

@property (retain,nonatomic,getter=getWeight) NSString* weight;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(CustomerRequestResultHandler*) __request;
+(Customercustomer*) createWithXml:(DDXMLElement*)__node __request:(CustomerRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(CustomerRequestResultHandler*) __request;
@end