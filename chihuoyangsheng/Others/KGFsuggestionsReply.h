//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.3.2
//
// Created by Quasar Development at 11-06-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

#import "KGFRequestResultHandler.h"
#import "DDXML.h"



@interface KGFsuggestionsReply : NSObject 


@property (retain,nonatomic,getter=getContent) NSString* content;

@property (retain,nonatomic,getter=getCreateTime) NSString* createTime;

@property (retain,nonatomic,getter=get_id) NSString* _id;

@property (retain,nonatomic,getter=getSuggestionsId) NSString* suggestionsId;

@property (retain,nonatomic,getter=getUserId) NSString* userId;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(KGFRequestResultHandler*) __request;
+(KGFsuggestionsReply*) createWithXml:(DDXMLElement*)__node __request:(KGFRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(KGFRequestResultHandler*) __request;
@end