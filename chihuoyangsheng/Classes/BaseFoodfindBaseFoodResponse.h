//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class BaseFoodjsonData;
#import "BaseFoodRequestResultHandler.h"
#import "DDXML.h"



@interface BaseFoodfindBaseFoodResponse : NSObject 


@property (retain,nonatomic,getter=get_return) BaseFoodjsonData* _return;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(BaseFoodRequestResultHandler*) __request;
+(BaseFoodfindBaseFoodResponse*) createWithXml:(DDXMLElement*)__node __request:(BaseFoodRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(BaseFoodRequestResultHandler*) __request;
@end