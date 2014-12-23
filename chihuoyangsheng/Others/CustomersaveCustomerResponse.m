//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "CustomerHelper.h"
#import "CustomersaveCustomerResponse.h"


@implementation CustomersaveCustomerResponse
    @synthesize _return;

+ (CustomersaveCustomerResponse *)createWithXml:(DDXMLElement *)__node __request:(CustomerRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(CustomerRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([CustomerHelper hasValue:__node name:@"return"])
        {
            self._return = [[CustomerHelper getNode:__node name:@"return"] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(CustomerRequestResultHandler*) __request
{

             
        DDXMLElement* ___returnItemElement=[__request writeElement:_return type:[NSString class] name:@"return" URI:@"" parent:__parent skipNullProperty:__request.SkipNullProperties];
        if(___returnItemElement!=nil)
        {
            [___returnItemElement setStringValue:self._return];
        }


}
@end