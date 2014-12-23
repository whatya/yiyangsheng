//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "AreaHelper.h"
#import "Areacity.h"


@implementation Areacity
    @synthesize _id;
    @synthesize jianpin;
    @synthesize name;
    @synthesize provinceId;

+ (Areacity *)createWithXml:(DDXMLElement *)__node __request:(AreaRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(AreaRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([AreaHelper hasValue:__node name:@"id"])
        {
            self._id = [[AreaHelper getNode:__node name:@"id"] stringValue];
        }
        if([AreaHelper hasValue:__node name:@"jianpin"])
        {
            self.jianpin = [[AreaHelper getNode:__node name:@"jianpin"] stringValue];
        }
        if([AreaHelper hasValue:__node name:@"name"])
        {
            self.name = [[AreaHelper getNode:__node name:@"name"] stringValue];
        }
        if([AreaHelper hasValue:__node name:@"provinceId"])
        {
            self.provinceId = [[AreaHelper getNode:__node name:@"provinceId"] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(AreaRequestResultHandler*) __request
{

             
        DDXMLElement* ___idItemElement=[__request writeElement:_id type:[NSString class] name:@"id" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(___idItemElement!=nil)
        {
            [___idItemElement setStringValue:self._id];
        }
             
        DDXMLElement* __jianpinItemElement=[__request writeElement:jianpin type:[NSString class] name:@"jianpin" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__jianpinItemElement!=nil)
        {
            [__jianpinItemElement setStringValue:self.jianpin];
        }
             
        DDXMLElement* __nameItemElement=[__request writeElement:name type:[NSString class] name:@"name" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__nameItemElement!=nil)
        {
            [__nameItemElement setStringValue:self.name];
        }
             
        DDXMLElement* __provinceIdItemElement=[__request writeElement:provinceId type:[NSString class] name:@"provinceId" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__provinceIdItemElement!=nil)
        {
            [__provinceIdItemElement setStringValue:self.provinceId];
        }


}
@end