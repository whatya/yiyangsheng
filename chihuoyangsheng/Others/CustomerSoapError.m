//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "CustomerSoapError.h"

@implementation CustomerSoapError
@synthesize Details;

-(id)initWithDetails:(NSString*) faultString details:(id)details;
{
    if(self = [self initWithDomain:faultString code:0 userInfo:nil])
    {
        self.Details=details;
        
    }
    return self;
}
@end