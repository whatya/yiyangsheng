//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

#import "CookBookRequestResultHandler.h"
#import "DDXML.h"



@interface CookBookjsonData : NSObject 


@property (retain,nonatomic,getter=getErrorTrace) NSString* errorTrace;

@property (retain,nonatomic,getter=getExtData) NSString* extData;

@property (retain,nonatomic,getter=getMsg) NSString* msg;

@property (retain,nonatomic,getter=getRows) NSMutableArray* rows;

@property (nonatomic,getter=getSuccess) BOOL success;

@property (nonatomic,getter=getTotal) int total;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(CookBookRequestResultHandler*) __request;
+(CookBookjsonData*) createWithXml:(DDXMLElement*)__node __request:(CookBookRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(CookBookRequestResultHandler*) __request;
@end