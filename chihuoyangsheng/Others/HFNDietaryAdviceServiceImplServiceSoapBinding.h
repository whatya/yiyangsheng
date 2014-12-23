//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.0.4.1
//
// Created by Quasar Development at 17-10-2014
//
//---------------------------------------------------



#import <Foundation/Foundation.h>

#import "HFNjsonData.h"
#import "HFNdietaryAdvice.h"
#import "DDXML.h"

@class HFNRequestResultHandler;

@protocol HFNSoapServiceResponse < NSObject>
- (void) onSuccess: (id) value methodName:(NSString*)methodName;
- (void) onError: (NSError*) error;
@end


@interface HFNDietaryAdviceServiceImplServiceSoapBinding : NSObject
    
@property (retain, nonatomic) NSDictionary* Headers;
@property (retain, nonatomic) NSString* Url;
@property (nonatomic) BOOL ShouldAddAdornments;
@property BOOL EnableLogging;

- (id) init;
- (id) initWithUrl: (NSString*) url;

-(NSMutableURLRequest*) createfindDietaryAdviceRequest:(int) arg0 arg1:(int) arg1 arg2:(HFNdietaryAdvice*) arg2 __request:(HFNRequestResultHandler*) __request;
-(HFNjsonData*) findDietaryAdvice:(int) arg0 arg1:(int) arg1 arg2:(HFNdietaryAdvice*) arg2 __error:(NSError**) __error;
-(HFNRequestResultHandler*) findDietaryAdviceAsync:(int) arg0 arg1:(int) arg1 arg2:(HFNdietaryAdvice*) arg2 __target:(id) __target __handler:(SEL) __handler;
-(HFNRequestResultHandler*) findDietaryAdviceAsync:(int) arg0 arg1:(int) arg1 arg2:(HFNdietaryAdvice*) arg2 __target:(id<HFNSoapServiceResponse>) __target;
-(void) deleteById:(NSString*) arg0 __error:(NSError**) __error;
-(HFNRequestResultHandler*) deleteByIdAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(HFNRequestResultHandler*) deleteByIdAsync:(NSString*) arg0 __target:(id<HFNSoapServiceResponse>) __target;
-(HFNRequestResultHandler*) CreateRequestResultHandler;   
-(NSMutableURLRequest*) createRequest :(NSString*) soapAction __request:(HFNRequestResultHandler*) __request; 
-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(HFNRequestResultHandler*) requestMgr; 
-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(HFNRequestResultHandler*) requestMgr callback:(void (^)(HFNRequestResultHandler *)) callback;

@end