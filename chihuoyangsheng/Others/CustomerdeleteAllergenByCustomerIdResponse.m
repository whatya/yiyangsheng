//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "CustomerHelper.h"
#import "CustomerdeleteAllergenByCustomerIdResponse.h"


@implementation CustomerdeleteAllergenByCustomerIdResponse

+ (CustomerdeleteAllergenByCustomerIdResponse *)createWithXml:(DDXMLElement *)__node __request:(CustomerRequestResultHandler*) __request
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
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(CustomerRequestResultHandler*) __request
{



}
@end
