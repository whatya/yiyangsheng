//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "BaseFoodHelper.h"
#import "BaseFoodbaseFood.h"

@interface BaseFoodbaseFood ()

@property (nonatomic) BOOL highlight;

@end


@implementation BaseFoodbaseFood
    @synthesize alias;
    @synthesize b1;
    @synthesize b2;
    @synthesize b6;
    @synthesize calcium;
    @synthesize carbohydrate;
    @synthesize cholesterol;
    @synthesize createTime;
    @synthesize dietaryFiber;
    @synthesize energy;
    @synthesize fat;
    @synthesize ferri;
    @synthesize folate;
    @synthesize foodName;
    @synthesize foodType;
    @synthesize foodTypeName;
    @synthesize glycemic;
    @synthesize _id;
    @synthesize introduce;
    @synthesize iodine;
    @synthesize nutrition;
    @synthesize nutritionTrait;
    @synthesize picture;
    @synthesize protein;
    @synthesize remark;
    @synthesize vitaminA;
    @synthesize vitaminC;
    @synthesize zinc;

+ (BaseFoodbaseFood *)createWithXml:(DDXMLElement *)__node __request:(BaseFoodRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(BaseFoodRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([BaseFoodHelper hasValue:__node name:@"alias"])
        {
            self.alias = [[BaseFoodHelper getNode:__node name:@"alias"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"b1"])
        {
            self.b1 = [[BaseFoodHelper getNode:__node name:@"b1"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"b2"])
        {
            self.b2 = [[BaseFoodHelper getNode:__node name:@"b2"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"b6"])
        {
            self.b6 = [[BaseFoodHelper getNode:__node name:@"b6"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"calcium"])
        {
            self.calcium = [[BaseFoodHelper getNode:__node name:@"calcium"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"carbohydrate"])
        {
            self.carbohydrate = [[BaseFoodHelper getNode:__node name:@"carbohydrate"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"cholesterol"])
        {
            self.cholesterol = [[BaseFoodHelper getNode:__node name:@"cholesterol"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"createTime"])
        {
            self.createTime = [BaseFoodHelper getDate:[[BaseFoodHelper getNode:__node name:@"createTime"] stringValue]];
        }
        if([BaseFoodHelper hasValue:__node name:@"dietaryFiber"])
        {
            self.dietaryFiber = [[BaseFoodHelper getNode:__node name:@"dietaryFiber"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"energy"])
        {
            self.energy = [[BaseFoodHelper getNode:__node name:@"energy"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"fat"])
        {
            self.fat = [[BaseFoodHelper getNode:__node name:@"fat"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"ferri"])
        {
            self.ferri = [[BaseFoodHelper getNode:__node name:@"ferri"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"folate"])
        {
            self.folate = [[BaseFoodHelper getNode:__node name:@"folate"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"foodName"])
        {
            self.foodName = [[BaseFoodHelper getNode:__node name:@"foodName"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"foodType"])
        {
            self.foodType = [[BaseFoodHelper getNode:__node name:@"foodType"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"foodTypeName"])
        {
            self.foodTypeName = [[BaseFoodHelper getNode:__node name:@"foodTypeName"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"glycemic"])
        {
            self.glycemic = [[BaseFoodHelper getNode:__node name:@"glycemic"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"id"])
        {
            self._id = [[BaseFoodHelper getNode:__node name:@"id"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"introduce"])
        {
            self.introduce = [[BaseFoodHelper getNode:__node name:@"introduce"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"iodine"])
        {
            self.iodine = [[BaseFoodHelper getNode:__node name:@"iodine"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"nutrition"])
        {
            self.nutrition = [[BaseFoodHelper getNode:__node name:@"nutrition"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"nutritionTrait"])
        {
            self.nutritionTrait = [[BaseFoodHelper getNode:__node name:@"nutritionTrait"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"picture"])
        {
            self.picture = [[BaseFoodHelper getNode:__node name:@"picture"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"protein"])
        {
            self.protein = [[BaseFoodHelper getNode:__node name:@"protein"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"remark"])
        {
            self.remark = [[BaseFoodHelper getNode:__node name:@"remark"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"vitaminA"])
        {
            self.vitaminA = [[BaseFoodHelper getNode:__node name:@"vitaminA"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"vitaminC"])
        {
            self.vitaminC = [[BaseFoodHelper getNode:__node name:@"vitaminC"] stringValue];
        }
        if([BaseFoodHelper hasValue:__node name:@"zinc"])
        {
            self.zinc = [[BaseFoodHelper getNode:__node name:@"zinc"] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(BaseFoodRequestResultHandler*) __request
{

             
        DDXMLElement* __aliasItemElement=[__request writeElement:alias type:[NSString class] name:@"alias" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__aliasItemElement!=nil)
        {
            [__aliasItemElement setStringValue:self.alias];
        }
             
        DDXMLElement* __b1ItemElement=[__request writeElement:b1 type:[NSString class] name:@"b1" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__b1ItemElement!=nil)
        {
            [__b1ItemElement setStringValue:self.b1];
        }
             
        DDXMLElement* __b2ItemElement=[__request writeElement:b2 type:[NSString class] name:@"b2" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__b2ItemElement!=nil)
        {
            [__b2ItemElement setStringValue:self.b2];
        }
             
        DDXMLElement* __b6ItemElement=[__request writeElement:b6 type:[NSString class] name:@"b6" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__b6ItemElement!=nil)
        {
            [__b6ItemElement setStringValue:self.b6];
        }
             
        DDXMLElement* __calciumItemElement=[__request writeElement:calcium type:[NSString class] name:@"calcium" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__calciumItemElement!=nil)
        {
            [__calciumItemElement setStringValue:self.calcium];
        }
             
        DDXMLElement* __carbohydrateItemElement=[__request writeElement:carbohydrate type:[NSString class] name:@"carbohydrate" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__carbohydrateItemElement!=nil)
        {
            [__carbohydrateItemElement setStringValue:self.carbohydrate];
        }
             
        DDXMLElement* __cholesterolItemElement=[__request writeElement:cholesterol type:[NSString class] name:@"cholesterol" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__cholesterolItemElement!=nil)
        {
            [__cholesterolItemElement setStringValue:self.cholesterol];
        }
             
        DDXMLElement* __createTimeItemElement=[__request writeElement:createTime type:[NSDate class] name:@"createTime" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__createTimeItemElement!=nil)
        {
            [__createTimeItemElement setStringValue:[BaseFoodHelper getStringFromDate:self.createTime]];
        }
             
        DDXMLElement* __dietaryFiberItemElement=[__request writeElement:dietaryFiber type:[NSString class] name:@"dietaryFiber" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__dietaryFiberItemElement!=nil)
        {
            [__dietaryFiberItemElement setStringValue:self.dietaryFiber];
        }
             
        DDXMLElement* __energyItemElement=[__request writeElement:energy type:[NSString class] name:@"energy" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__energyItemElement!=nil)
        {
            [__energyItemElement setStringValue:self.energy];
        }
             
        DDXMLElement* __fatItemElement=[__request writeElement:fat type:[NSString class] name:@"fat" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__fatItemElement!=nil)
        {
            [__fatItemElement setStringValue:self.fat];
        }
             
        DDXMLElement* __ferriItemElement=[__request writeElement:ferri type:[NSString class] name:@"ferri" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__ferriItemElement!=nil)
        {
            [__ferriItemElement setStringValue:self.ferri];
        }
             
        DDXMLElement* __folateItemElement=[__request writeElement:folate type:[NSString class] name:@"folate" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__folateItemElement!=nil)
        {
            [__folateItemElement setStringValue:self.folate];
        }
             
        DDXMLElement* __foodNameItemElement=[__request writeElement:foodName type:[NSString class] name:@"foodName" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__foodNameItemElement!=nil)
        {
            [__foodNameItemElement setStringValue:self.foodName];
        }
             
        DDXMLElement* __foodTypeItemElement=[__request writeElement:foodType type:[NSString class] name:@"foodType" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__foodTypeItemElement!=nil)
        {
            [__foodTypeItemElement setStringValue:self.foodType];
        }
             
        DDXMLElement* __foodTypeNameItemElement=[__request writeElement:foodTypeName type:[NSString class] name:@"foodTypeName" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__foodTypeNameItemElement!=nil)
        {
            [__foodTypeNameItemElement setStringValue:self.foodTypeName];
        }
             
        DDXMLElement* __glycemicItemElement=[__request writeElement:glycemic type:[NSString class] name:@"glycemic" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__glycemicItemElement!=nil)
        {
            [__glycemicItemElement setStringValue:self.glycemic];
        }
             
        DDXMLElement* ___idItemElement=[__request writeElement:_id type:[NSString class] name:@"id" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(___idItemElement!=nil)
        {
            [___idItemElement setStringValue:self._id];
        }
             
        DDXMLElement* __introduceItemElement=[__request writeElement:introduce type:[NSString class] name:@"introduce" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__introduceItemElement!=nil)
        {
            [__introduceItemElement setStringValue:self.introduce];
        }
             
        DDXMLElement* __iodineItemElement=[__request writeElement:iodine type:[NSString class] name:@"iodine" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__iodineItemElement!=nil)
        {
            [__iodineItemElement setStringValue:self.iodine];
        }
             
        DDXMLElement* __nutritionItemElement=[__request writeElement:nutrition type:[NSString class] name:@"nutrition" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__nutritionItemElement!=nil)
        {
            [__nutritionItemElement setStringValue:self.nutrition];
        }
             
        DDXMLElement* __nutritionTraitItemElement=[__request writeElement:nutritionTrait type:[NSString class] name:@"nutritionTrait" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__nutritionTraitItemElement!=nil)
        {
            [__nutritionTraitItemElement setStringValue:self.nutritionTrait];
        }
             
        DDXMLElement* __pictureItemElement=[__request writeElement:picture type:[NSString class] name:@"picture" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__pictureItemElement!=nil)
        {
            [__pictureItemElement setStringValue:self.picture];
        }
             
        DDXMLElement* __proteinItemElement=[__request writeElement:protein type:[NSString class] name:@"protein" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__proteinItemElement!=nil)
        {
            [__proteinItemElement setStringValue:self.protein];
        }
             
        DDXMLElement* __remarkItemElement=[__request writeElement:remark type:[NSString class] name:@"remark" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__remarkItemElement!=nil)
        {
            [__remarkItemElement setStringValue:self.remark];
        }
             
        DDXMLElement* __vitaminAItemElement=[__request writeElement:vitaminA type:[NSString class] name:@"vitaminA" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__vitaminAItemElement!=nil)
        {
            [__vitaminAItemElement setStringValue:self.vitaminA];
        }
             
        DDXMLElement* __vitaminCItemElement=[__request writeElement:vitaminC type:[NSString class] name:@"vitaminC" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__vitaminCItemElement!=nil)
        {
            [__vitaminCItemElement setStringValue:self.vitaminC];
        }
             
        DDXMLElement* __zincItemElement=[__request writeElement:zinc type:[NSString class] name:@"zinc" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__zincItemElement!=nil)
        {
            [__zincItemElement setStringValue:self.zinc];
        }


}

-(void)turnOnHighlight
{
    self.highlight = YES;
}

- (void)shutDownHighlight
{
    self.highlight = NO;
}

- (BOOL)shouldIHighlight
{
    return self.highlight;
}
@end
