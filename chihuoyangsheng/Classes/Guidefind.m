//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "Guidesuggestions.h"
#import "GuideHelper.h"
#import "Guidefind.h"


@implementation Guidefind
    @synthesize arg0;

+ (Guidefind *)createWithXml:(DDXMLElement *)__node __request:(GuideRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(GuideRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([GuideHelper hasValue:__node name:@"arg0"])
        {
            self.arg0 = (Guidesuggestions*)[__request createObject:[GuideHelper getNode:__node name:@"arg0"] type:[Guidesuggestions class]];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(GuideRequestResultHandler*) __request
{

             
        DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[Guidesuggestions class] name:@"arg0" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(__arg0ItemElement!=nil)
        {
            [self.arg0 serialize:__arg0ItemElement __request: __request];
        }


}
@end
