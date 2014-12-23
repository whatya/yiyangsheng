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



@interface CustomerhealthRecord : NSObject 

+ (CustomerhealthRecord*)sharedHealthRecord;

@property (retain,nonatomic,getter=getCustomerId) NSString* customerId;

@property (retain,nonatomic,getter=getDiseaseTypeCode) NSString* diseaseTypeCode;

@property (retain,nonatomic,getter=getDpac) NSString* dpac;//

@property (retain,nonatomic,getter=getDrinkingFr) NSString* drinkingFr;//

@property (retain,nonatomic,getter=getDrinkingType) NSString* drinkingType;//

@property (retain,nonatomic,getter=getDrugAllergyFlag) NSString* drugAllergyFlag;//

@property (retain,nonatomic,getter=getDrugAllergySource) NSString* drugAllergySource;//

@property (retain,nonatomic,getter=getDrunkenness) NSString* drunkenness;//

@property (retain,nonatomic,getter=getFamilialDiseaseCode) NSString* familialDiseaseCode;//

@property (retain,nonatomic,getter=getGeneticDiseases) NSString* geneticDiseases;//

@property (retain,nonatomic,getter=get_id) NSString* _id;

@property (retain,nonatomic,getter=getQuitSmokingAge) NSString* quitSmokingAge;//

@property (retain,nonatomic,getter=getRelationship) NSString* relationship;//

@property (retain,nonatomic,getter=getSmoking) NSString* smoking;//

@property (retain,nonatomic,getter=getSmokingAge) NSString* smokingAge;//

@property (retain,nonatomic,getter=getSmokingStatus) NSString* smokingStatus;//

@property (retain,nonatomic,getter=getStartDrinkingAge) NSString* startDrinkingAge;//

@property (retain,nonatomic,getter=getStopDrinkingAge) NSString* stopDrinkingAge;//

@property (retain,nonatomic,getter=getStopDrinkingFlag) NSString* stopDrinkingFlag;//

@property (retain,nonatomic,getter=getSurgery) NSString* surgery;//

@property (retain,nonatomic,getter=getSurgeryFlag) NSString* surgeryFlag;//

@property (retain,nonatomic,getter=getSurgeryTime) NSString* surgeryTime;//

@property (retain,nonatomic,getter=getTransfusionFalg) NSString* transfusionFalg;//

@property (retain,nonatomic,getter=getTransfusionReason) NSString* transfusionReason;//

@property (retain,nonatomic,getter=getTransfusionTime) NSString* transfusionTime;//

@property (retain,nonatomic,getter=getTraumaName) NSString* traumaName;//

@property (retain,nonatomic,getter=getTraumaTime) NSString* traumaTime;//
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(CustomerRequestResultHandler*) __request;
+(CustomerhealthRecord*) createWithXml:(DDXMLElement*)__node __request:(CustomerRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(CustomerRequestResultHandler*) __request;
@end