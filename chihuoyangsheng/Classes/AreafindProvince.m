//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "AreaHelper.h"
#import "AreafindProvince.h"


@implementation AreafindProvince
    @synthesize arg0;
    @synthesize arg1;

+ (AreafindProvince *)createWithXml:(DDXMLElement *)__node __request:(AreaRequestResultHandler*) __request
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
        if([AreaHelper hasValue:__node name:@"arg0"])
        {
            self.arg0 = [[AreaHelper getNode:__node name:@"arg0"] stringValue];
        }
        if([AreaHelper hasValue:__node name:@"arg1"])
        {
            self.arg1 = [[AreaHelper getNode:__node name:@"arg1"] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(AreaRequestResultHandler*) __request
{

             
        DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[NSString class] name:@"arg0" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__arg0ItemElement!=nil)
        {
            [__arg0ItemElement setStringValue:self.arg0];
        }
             
        DDXMLElement* __arg1ItemElement=[__request writeElement:arg1 type:[NSString class] name:@"arg1" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__arg1ItemElement!=nil)
        {
            [__arg1ItemElement setStringValue:self.arg1];
        }


}
@end
