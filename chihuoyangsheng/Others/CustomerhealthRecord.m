//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "CustomerHelper.h"
#import "CustomerhealthRecord.h"


@implementation CustomerhealthRecord
    @synthesize customerId;
    @synthesize diseaseTypeCode;
    @synthesize dpac;
    @synthesize drinkingFr;
    @synthesize drinkingType;
    @synthesize drugAllergyFlag;
    @synthesize drugAllergySource;
    @synthesize drunkenness;
    @synthesize familialDiseaseCode;
    @synthesize geneticDiseases;
    @synthesize _id;
    @synthesize quitSmokingAge;
    @synthesize relationship;
    @synthesize smoking;
    @synthesize smokingAge;
    @synthesize smokingStatus;
    @synthesize startDrinkingAge;
    @synthesize stopDrinkingAge;
    @synthesize stopDrinkingFlag;
    @synthesize surgery;
    @synthesize surgeryFlag;
    @synthesize surgeryTime;
    @synthesize transfusionFalg;
    @synthesize transfusionReason;
    @synthesize transfusionTime;
    @synthesize traumaName;
    @synthesize traumaTime;

+ (CustomerhealthRecord *)createWithXml:(DDXMLElement *)__node __request:(CustomerRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

+ (CustomerhealthRecord*)sharedHealthRecord
{
    static CustomerhealthRecord *_sharedHealthRecordr = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHealthRecordr = [[self alloc] init];
    });
    
    return _sharedHealthRecordr;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(CustomerRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([CustomerHelper hasValue:__node name:@"customerId"])
        {
            self.customerId = [[CustomerHelper getNode:__node name:@"customerId"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"diseaseTypeCode"])
        {
            self.diseaseTypeCode = [[CustomerHelper getNode:__node name:@"diseaseTypeCode"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"dpac"])
        {
            self.dpac = [[CustomerHelper getNode:__node name:@"dpac"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"drinkingFr"])
        {
            self.drinkingFr = [[CustomerHelper getNode:__node name:@"drinkingFr"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"drinkingType"])
        {
            self.drinkingType = [[CustomerHelper getNode:__node name:@"drinkingType"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"drugAllergyFlag"])
        {
            self.drugAllergyFlag = [[CustomerHelper getNode:__node name:@"drugAllergyFlag"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"drugAllergySource"])
        {
            self.drugAllergySource = [[CustomerHelper getNode:__node name:@"drugAllergySource"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"drunkenness"])
        {
            self.drunkenness = [[CustomerHelper getNode:__node name:@"drunkenness"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"familialDiseaseCode"])
        {
            self.familialDiseaseCode = [[CustomerHelper getNode:__node name:@"familialDiseaseCode"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"geneticDiseases"])
        {
            self.geneticDiseases = [[CustomerHelper getNode:__node name:@"geneticDiseases"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"id"])
        {
            self._id = [[CustomerHelper getNode:__node name:@"id"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"quitSmokingAge"])
        {
            self.quitSmokingAge = [[CustomerHelper getNode:__node name:@"quitSmokingAge"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"relationship"])
        {
            self.relationship = [[CustomerHelper getNode:__node name:@"relationship"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"smoking"])
        {
            self.smoking = [[CustomerHelper getNode:__node name:@"smoking"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"smokingAge"])
        {
            self.smokingAge = [[CustomerHelper getNode:__node name:@"smokingAge"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"smokingStatus"])
        {
            self.smokingStatus = [[CustomerHelper getNode:__node name:@"smokingStatus"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"startDrinkingAge"])
        {
            self.startDrinkingAge = [[CustomerHelper getNode:__node name:@"startDrinkingAge"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"stopDrinkingAge"])
        {
            self.stopDrinkingAge = [[CustomerHelper getNode:__node name:@"stopDrinkingAge"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"stopDrinkingFlag"])
        {
            self.stopDrinkingFlag = [[CustomerHelper getNode:__node name:@"stopDrinkingFlag"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"surgery"])
        {
            self.surgery = [[CustomerHelper getNode:__node name:@"surgery"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"surgeryFlag"])
        {
            self.surgeryFlag = [[CustomerHelper getNode:__node name:@"surgeryFlag"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"surgeryTime"])
        {
            self.surgeryTime = [[CustomerHelper getNode:__node name:@"surgeryTime"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"transfusionFalg"])
        {
            self.transfusionFalg = [[CustomerHelper getNode:__node name:@"transfusionFalg"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"transfusionReason"])
        {
            self.transfusionReason = [[CustomerHelper getNode:__node name:@"transfusionReason"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"transfusionTime"])
        {
            self.transfusionTime = [[CustomerHelper getNode:__node name:@"transfusionTime"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"traumaName"])
        {
            self.traumaName = [[CustomerHelper getNode:__node name:@"traumaName"] stringValue];
        }
        if([CustomerHelper hasValue:__node name:@"traumaTime"])
        {
            self.traumaTime = [[CustomerHelper getNode:__node name:@"traumaTime"] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(CustomerRequestResultHandler*) __request
{

             
        DDXMLElement* __customerIdItemElement=[__request writeElement:customerId type:[NSString class] name:@"customerId" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__customerIdItemElement!=nil)
        {
            [__customerIdItemElement setStringValue:self.customerId];
        }
             
        DDXMLElement* __diseaseTypeCodeItemElement=[__request writeElement:diseaseTypeCode type:[NSString class] name:@"diseaseTypeCode" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__diseaseTypeCodeItemElement!=nil)
        {
            [__diseaseTypeCodeItemElement setStringValue:self.diseaseTypeCode];
        }
             
        DDXMLElement* __dpacItemElement=[__request writeElement:dpac type:[NSString class] name:@"dpac" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__dpacItemElement!=nil)
        {
            [__dpacItemElement setStringValue:self.dpac];
        }
             
        DDXMLElement* __drinkingFrItemElement=[__request writeElement:drinkingFr type:[NSString class] name:@"drinkingFr" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__drinkingFrItemElement!=nil)
        {
            [__drinkingFrItemElement setStringValue:self.drinkingFr];
        }
             
        DDXMLElement* __drinkingTypeItemElement=[__request writeElement:drinkingType type:[NSString class] name:@"drinkingType" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__drinkingTypeItemElement!=nil)
        {
            [__drinkingTypeItemElement setStringValue:self.drinkingType];
        }
             
        DDXMLElement* __drugAllergyFlagItemElement=[__request writeElement:drugAllergyFlag type:[NSString class] name:@"drugAllergyFlag" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__drugAllergyFlagItemElement!=nil)
        {
            [__drugAllergyFlagItemElement setStringValue:self.drugAllergyFlag];
        }
             
        DDXMLElement* __drugAllergySourceItemElement=[__request writeElement:drugAllergySource type:[NSString class] name:@"drugAllergySource" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__drugAllergySourceItemElement!=nil)
        {
            [__drugAllergySourceItemElement setStringValue:self.drugAllergySource];
        }
             
        DDXMLElement* __drunkennessItemElement=[__request writeElement:drunkenness type:[NSString class] name:@"drunkenness" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__drunkennessItemElement!=nil)
        {
            [__drunkennessItemElement setStringValue:self.drunkenness];
        }
             
        DDXMLElement* __familialDiseaseCodeItemElement=[__request writeElement:familialDiseaseCode type:[NSString class] name:@"familialDiseaseCode" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__familialDiseaseCodeItemElement!=nil)
        {
            [__familialDiseaseCodeItemElement setStringValue:self.familialDiseaseCode];
        }
             
        DDXMLElement* __geneticDiseasesItemElement=[__request writeElement:geneticDiseases type:[NSString class] name:@"geneticDiseases" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__geneticDiseasesItemElement!=nil)
        {
            [__geneticDiseasesItemElement setStringValue:self.geneticDiseases];
        }
             
        DDXMLElement* ___idItemElement=[__request writeElement:_id type:[NSString class] name:@"id" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(___idItemElement!=nil)
        {
            [___idItemElement setStringValue:self._id];
        }
             
        DDXMLElement* __quitSmokingAgeItemElement=[__request writeElement:quitSmokingAge type:[NSString class] name:@"quitSmokingAge" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__quitSmokingAgeItemElement!=nil)
        {
            [__quitSmokingAgeItemElement setStringValue:self.quitSmokingAge];
        }
             
        DDXMLElement* __relationshipItemElement=[__request writeElement:relationship type:[NSString class] name:@"relationship" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__relationshipItemElement!=nil)
        {
            [__relationshipItemElement setStringValue:self.relationship];
        }
             
        DDXMLElement* __smokingItemElement=[__request writeElement:smoking type:[NSString class] name:@"smoking" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__smokingItemElement!=nil)
        {
            [__smokingItemElement setStringValue:self.smoking];
        }
             
        DDXMLElement* __smokingAgeItemElement=[__request writeElement:smokingAge type:[NSString class] name:@"smokingAge" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__smokingAgeItemElement!=nil)
        {
            [__smokingAgeItemElement setStringValue:self.smokingAge];
        }
             
        DDXMLElement* __smokingStatusItemElement=[__request writeElement:smokingStatus type:[NSString class] name:@"smokingStatus" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__smokingStatusItemElement!=nil)
        {
            [__smokingStatusItemElement setStringValue:self.smokingStatus];
        }
             
        DDXMLElement* __startDrinkingAgeItemElement=[__request writeElement:startDrinkingAge type:[NSString class] name:@"startDrinkingAge" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__startDrinkingAgeItemElement!=nil)
        {
            [__startDrinkingAgeItemElement setStringValue:self.startDrinkingAge];
        }
             
        DDXMLElement* __stopDrinkingAgeItemElement=[__request writeElement:stopDrinkingAge type:[NSString class] name:@"stopDrinkingAge" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__stopDrinkingAgeItemElement!=nil)
        {
            [__stopDrinkingAgeItemElement setStringValue:self.stopDrinkingAge];
        }
             
        DDXMLElement* __stopDrinkingFlagItemElement=[__request writeElement:stopDrinkingFlag type:[NSString class] name:@"stopDrinkingFlag" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__stopDrinkingFlagItemElement!=nil)
        {
            [__stopDrinkingFlagItemElement setStringValue:self.stopDrinkingFlag];
        }
             
        DDXMLElement* __surgeryItemElement=[__request writeElement:surgery type:[NSString class] name:@"surgery" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__surgeryItemElement!=nil)
        {
            [__surgeryItemElement setStringValue:self.surgery];
        }
             
        DDXMLElement* __surgeryFlagItemElement=[__request writeElement:surgeryFlag type:[NSString class] name:@"surgeryFlag" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__surgeryFlagItemElement!=nil)
        {
            [__surgeryFlagItemElement setStringValue:self.surgeryFlag];
        }
             
        DDXMLElement* __surgeryTimeItemElement=[__request writeElement:surgeryTime type:[NSString class] name:@"surgeryTime" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__surgeryTimeItemElement!=nil)
        {
            [__surgeryTimeItemElement setStringValue:self.surgeryTime];
        }
             
        DDXMLElement* __transfusionFalgItemElement=[__request writeElement:transfusionFalg type:[NSString class] name:@"transfusionFalg" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__transfusionFalgItemElement!=nil)
        {
            [__transfusionFalgItemElement setStringValue:self.transfusionFalg];
        }
             
        DDXMLElement* __transfusionReasonItemElement=[__request writeElement:transfusionReason type:[NSString class] name:@"transfusionReason" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__transfusionReasonItemElement!=nil)
        {
            [__transfusionReasonItemElement setStringValue:self.transfusionReason];
        }
             
        DDXMLElement* __transfusionTimeItemElement=[__request writeElement:transfusionTime type:[NSString class] name:@"transfusionTime" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__transfusionTimeItemElement!=nil)
        {
            [__transfusionTimeItemElement setStringValue:self.transfusionTime];
        }
             
        DDXMLElement* __traumaNameItemElement=[__request writeElement:traumaName type:[NSString class] name:@"traumaName" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__traumaNameItemElement!=nil)
        {
            [__traumaNameItemElement setStringValue:self.traumaName];
        }
             
        DDXMLElement* __traumaTimeItemElement=[__request writeElement:traumaTime type:[NSString class] name:@"traumaTime" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__traumaTimeItemElement!=nil)
        {
            [__traumaTimeItemElement setStringValue:self.traumaTime];
        }


}
@end
