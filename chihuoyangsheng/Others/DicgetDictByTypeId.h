//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

#import "DicRequestResultHandler.h"
#import "DDXML.h"



@interface DicgetDictByTypeId : NSObject 


@property (retain,nonatomic,getter=getArg0) NSString* arg0;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(DicRequestResultHandler*) __request;
+(DicgetDictByTypeId*) createWithXml:(DDXMLElement*)__node __request:(DicRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(DicRequestResultHandler*) __request;
@end