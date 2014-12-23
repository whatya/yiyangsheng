//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "AllDicsHelper.h"
#import "AllDicsdictType.h"


@implementation AllDicsdictType
    @synthesize _id;
    @synthesize parentId;
    @synthesize remark;
    @synthesize typeCode;
    @synthesize typeName;

+ (AllDicsdictType *)createWithXml:(DDXMLElement *)__node __request:(AllDicsRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(AllDicsRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([AllDicsHelper hasValue:__node name:@"id"])
        {
            self._id = [[AllDicsHelper getNode:__node name:@"id"] stringValue];
        }
        if([AllDicsHelper hasValue:__node name:@"parentId"])
        {
            self.parentId = [[AllDicsHelper getNode:__node name:@"parentId"] stringValue];
        }
        if([AllDicsHelper hasValue:__node name:@"remark"])
        {
            self.remark = [[AllDicsHelper getNode:__node name:@"remark"] stringValue];
        }
        if([AllDicsHelper hasValue:__node name:@"typeCode"])
        {
            self.typeCode = [[AllDicsHelper getNode:__node name:@"typeCode"] stringValue];
        }
        if([AllDicsHelper hasValue:__node name:@"typeName"])
        {
            self.typeName = [[AllDicsHelper getNode:__node name:@"typeName"] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(AllDicsRequestResultHandler*) __request
{

             
        DDXMLElement* ___idItemElement=[__request writeElement:_id type:[NSString class] name:@"id" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(___idItemElement!=nil)
        {
            [___idItemElement setStringValue:self._id];
        }
             
        DDXMLElement* __parentIdItemElement=[__request writeElement:parentId type:[NSString class] name:@"parentId" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__parentIdItemElement!=nil)
        {
            [__parentIdItemElement setStringValue:self.parentId];
        }
             
        DDXMLElement* __remarkItemElement=[__request writeElement:remark type:[NSString class] name:@"remark" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__remarkItemElement!=nil)
        {
            [__remarkItemElement setStringValue:self.remark];
        }
             
        DDXMLElement* __typeCodeItemElement=[__request writeElement:typeCode type:[NSString class] name:@"typeCode" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__typeCodeItemElement!=nil)
        {
            [__typeCodeItemElement setStringValue:self.typeCode];
        }
             
        DDXMLElement* __typeNameItemElement=[__request writeElement:typeName type:[NSString class] name:@"typeName" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__typeNameItemElement!=nil)
        {
            [__typeNameItemElement setStringValue:self.typeName];
        }


}
@end