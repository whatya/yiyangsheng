//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.3.2
//
// Created by Quasar Development at 09-06-2014
//
//---------------------------------------------------


#import "GLGHelper.h"
#import "GLGsuggestions.h"


@implementation GLGsuggestions
@synthesize content;
@synthesize createTime;
@synthesize customerId;
@synthesize _id;
@synthesize isReply;
@synthesize nickname;

+ (GLGsuggestions *)createWithXml:(DDXMLElement *)__node __request:(GLGRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(GLGRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([GLGHelper hasValue:__node name:@"content" index:0])
        {
            self.content = [[GLGHelper getNode:__node name:@"content" index:0] stringValue];
        }
        if([GLGHelper hasValue:__node name:@"createTime" index:0])
        {
            self.createTime = [[GLGHelper getNode:__node name:@"createTime" index:0] stringValue];
        }
        if([GLGHelper hasValue:__node name:@"customerId" index:0])
        {
            self.customerId = [[GLGHelper getNode:__node name:@"customerId" index:0] stringValue];
        }
        if([GLGHelper hasValue:__node name:@"id" index:0])
        {
            self._id = [[GLGHelper getNode:__node name:@"id" index:0] stringValue];
        }
        if([GLGHelper hasValue:__node name:@"isReply" index:0])
        {
            self.isReply = [[GLGHelper getNode:__node name:@"isReply" index:0] stringValue];
        }
        if([GLGHelper hasValue:__node name:@"nickname" index:0])
        {
            self.nickname = [[GLGHelper getNode:__node name:@"nickname" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(GLGRequestResultHandler*) __request
{

             
    DDXMLElement* __contentItemElement=[__request writeElement:content type:[NSString class] name:@"content" URI:@"" parent:__parent skipNullProperty:YES];
    if(__contentItemElement!=nil)
    {
        [__contentItemElement setStringValue:self.content];
    }
             
    DDXMLElement* __createTimeItemElement=[__request writeElement:createTime type:[NSString class] name:@"createTime" URI:@"" parent:__parent skipNullProperty:YES];
    if(__createTimeItemElement!=nil)
    {
        [__createTimeItemElement setStringValue:self.createTime];
    }
             
    DDXMLElement* __customerIdItemElement=[__request writeElement:customerId type:[NSString class] name:@"customerId" URI:@"" parent:__parent skipNullProperty:YES];
    if(__customerIdItemElement!=nil)
    {
        [__customerIdItemElement setStringValue:self.customerId];
    }
             
    DDXMLElement* ___idItemElement=[__request writeElement:_id type:[NSString class] name:@"id" URI:@"" parent:__parent skipNullProperty:YES];
    if(___idItemElement!=nil)
    {
        [___idItemElement setStringValue:self._id];
    }
             
    DDXMLElement* __isReplyItemElement=[__request writeElement:isReply type:[NSString class] name:@"isReply" URI:@"" parent:__parent skipNullProperty:YES];
    if(__isReplyItemElement!=nil)
    {
        [__isReplyItemElement setStringValue:self.isReply];
    }
             
    DDXMLElement* __nicknameItemElement=[__request writeElement:nickname type:[NSString class] name:@"nickname" URI:@"" parent:__parent skipNullProperty:YES];
    if(__nicknameItemElement!=nil)
    {
        [__nicknameItemElement setStringValue:self.nickname];
    }


}
@end