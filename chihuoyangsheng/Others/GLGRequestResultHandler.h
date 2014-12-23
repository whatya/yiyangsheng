//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.3.2
//
// Created by Quasar Development at 09-06-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>
#import "DDXML.h"
    
@protocol GLGIReferenceObject
@end
    
@class GLGRequestResultHandler;
typedef void (^GLGCLB)(GLGRequestResultHandler *);

@interface GLGRequestResultHandler : NSObject

@property BOOL EnableLogging;    
@property (retain, nonatomic) DDXMLElement* Body;
@property (retain, nonatomic) DDXMLElement* Header;    
@property (retain, nonatomic) DDXMLElement* OutputHeader;
@property (retain, nonatomic) DDXMLElement* OutputBody;
@property (retain, nonatomic) NSError* OutputFault;
@property (nonatomic,copy) GLGCLB Callback;

-(id)init;
-(id)createObject: (DDXMLElement*) node type:(Class) type;
-(NSString*) getEnvelopeString;
-(DDXMLDocument*) createEnvelopeXml;
-(id) createInstance:(Class) type node: (DDXMLNode*)node request :(GLGRequestResultHandler *)request;
-(DDXMLElement*) writeElement:(NSString*)name URI: (NSString*) URI parent:(DDXMLElement*) parent;
-(DDXMLElement*) writeElement:(id)obj type:(Class)type name: (NSString*)name URI: (NSString*) URI parent:(DDXMLElement*) parent skipNullProperty:(BOOL)skipNullProperty;
-(DDXMLNode*) addAttribute:(NSString*) name URI:(NSString*) URI stringValue:(NSString*) stringValue element:(DDXMLElement*) element;
-(void)setResponse:(NSData *)response;
-(void) sendImplementation:(NSMutableURLRequest*) request callbackDelegate:(GLGCLB) callbackDelegate;
-(void)Cancel;    

-(void) sendImplementation:(NSMutableURLRequest*) request;

@end