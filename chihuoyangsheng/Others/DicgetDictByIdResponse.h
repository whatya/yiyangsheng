//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class Dicdict;
#import "DicRequestResultHandler.h"
#import "DDXML.h"



@interface DicgetDictByIdResponse : NSObject 


@property (retain,nonatomic,getter=get_return) Dicdict* _return;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(DicRequestResultHandler*) __request;
+(DicgetDictByIdResponse*) createWithXml:(DDXMLElement*)__node __request:(DicRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(DicRequestResultHandler*) __request;
@end