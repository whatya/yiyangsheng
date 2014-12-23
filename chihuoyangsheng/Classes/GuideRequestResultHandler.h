//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>
#import "DDXML.h"
    
@protocol GuideIReferenceObject
@end
    
@class GuideRequestResultHandler;
typedef void (^GuideCLB)(GuideRequestResultHandler *);

@interface GuideRequestResultHandler : NSObject

@property BOOL SkipNullProperties;
@property BOOL EnableLogging;    
@property (retain, nonatomic) DDXMLElement* Body;
@property (retain, nonatomic) DDXMLElement* Header;    
@property (retain, nonatomic) DDXMLElement* OutputHeader;
@property (retain, nonatomic) DDXMLElement* OutputBody;
@property (retain, nonatomic) NSError* OutputFault;
@property (nonatomic,copy) GuideCLB Callback;

-(id)init;
-(id)createObject: (DDXMLElement*) node type:(Class) type;
-(NSString*) getEnvelopeString;
-(DDXMLDocument*) createEnvelopeXml;
-(id) createInstance:(Class) type node: (DDXMLNode*)node request :(GuideRequestResultHandler *)request;
-(DDXMLElement*) writeElement:(NSString*)name URI: (NSString*) URI parent:(DDXMLElement*) parent;
-(DDXMLElement*) writeElement:(id)obj type:(Class)type name: (NSString*)name URI: (NSString*) URI parent:(DDXMLElement*) parent skipNullProperty:(BOOL)skipNullProperty;
-(DDXMLNode*) addAttribute:(NSString*) name URI:(NSString*) URI stringValue:(NSString*) stringValue element:(DDXMLElement*) element;
-(void)setResponse:(NSData *)response;
-(void) sendImplementation:(NSMutableURLRequest*) request callbackDelegate:(GuideCLB) callbackDelegate;
-(void)Cancel;    

-(void) sendImplementation:(NSMutableURLRequest*) request;

@end