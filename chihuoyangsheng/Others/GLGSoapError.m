//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.3.2
//
// Created by Quasar Development at 09-06-2014
//
//---------------------------------------------------


#import "GLGSoapError.h"

@implementation GLGSoapError
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