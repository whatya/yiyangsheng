//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "CookBookHelper.h"
#import "CookBookgetById.h"


@implementation CookBookgetById
    @synthesize arg0;

+ (CookBookgetById *)createWithXml:(DDXMLElement *)__node __request:(CookBookRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(CookBookRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([CookBookHelper hasValue:__node name:@"arg0"])
        {
            self.arg0 = [[CookBookHelper getNode:__node name:@"arg0"] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(CookBookRequestResultHandler*) __request
{

             
        DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[NSString class] name:@"arg0" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__arg0ItemElement!=nil)
        {
            [__arg0ItemElement setStringValue:self.arg0];
        }


}
@end
