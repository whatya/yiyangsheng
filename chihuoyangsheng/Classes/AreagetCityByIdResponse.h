//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class Areacity;
#import "AreaRequestResultHandler.h"
#import "DDXML.h"



@interface AreagetCityByIdResponse : NSObject 


@property (retain,nonatomic,getter=get_return) Areacity* _return;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(AreaRequestResultHandler*) __request;
+(AreagetCityByIdResponse*) createWithXml:(DDXMLElement*)__node __request:(AreaRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(AreaRequestResultHandler*) __request;
@end