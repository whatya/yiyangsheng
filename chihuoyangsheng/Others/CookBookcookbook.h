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



@interface CookBookcookbook : NSObject 


@property (retain,nonatomic,getter=getCookbookName) NSString* cookbookName;

@property (retain,nonatomic,getter=get_id) NSString* _id;

@property (retain,nonatomic,getter=getImage) NSString* image;

@property (retain,nonatomic,getter=getJianpin) NSString* jianpin;

@property (retain,nonatomic,getter=getUrl) NSString* url;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(CookBookRequestResultHandler*) __request;
+(CookBookcookbook*) createWithXml:(DDXMLElement*)__node __request:(CookBookRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(CookBookRequestResultHandler*) __request;
@end