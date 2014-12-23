//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.0.4.1
//
// Created by Quasar Development at 17-10-2014
//
//---------------------------------------------------


#import <Foundation/Foundation.h>
#import "DDXML.h"
    
#define MS_SERIALIZATION_NS @"http://schemas.microsoft.com/2003/10/Serialization/"
#define XSI @"http://www.w3.org/2001/XMLSchema-instance"

@interface HFNHelper : NSObject
    
+(DDXMLElement*) getResultElement: (DDXMLElement*) body name:(NSString*)name;
+(DDXMLElement*) getNode:(DDXMLElement*) node name:(NSString*)name;
+(DDXMLElement*) getNode:(DDXMLElement *)node name:(NSString *)name index:(int)index;
+(DDXMLElement*) getNode:(DDXMLElement *) node name:(NSString*) name URI:(NSString*) URI;
+(BOOL) hasAttribute:(DDXMLElement*) node name:(NSString*)name;
+(DDXMLNode*) getAttribute:(DDXMLElement *)node name:(NSString *)name;
+(BOOL) hasValue:(DDXMLElement*) node name:(NSString*)name;
+(BOOL) hasValue:(DDXMLElement*) node name:(NSString*)name index:(int)index;
+(NSString*) toBoolStringFromNumber:(NSNumber*)boolNumber;
+(NSString*) toBoolStringFromBool:(BOOL)boolValue;
+(NSDate*) getDate:(NSString*) stringDate;
+(NSNumber*) getNumber:(NSString*) stringNumber;
+(NSString*) getStringFromDate:(NSDate*) date;
+(DDXMLNode*) getAttribute:(DDXMLElement*) node name:(NSString*)name url:(NSString*) url;
@end