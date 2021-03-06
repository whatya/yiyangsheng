//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------



#import <Foundation/Foundation.h>

#import "GuidefindResponse.h"
#import "Guidesuggestions.h"
#import "DDXML.h"

@class GuideRequestResultHandler;

@protocol GuideSoapServiceResponse < NSObject>
- (void) onSuccess: (id) value;
- (void) onError: (NSError*) error;
@end


@interface GuideSuggestionsServiceImplServiceSoapBinding : NSObject
    
@property (retain, nonatomic) NSDictionary* Headers;
@property (retain, nonatomic) NSString* Url;
@property (nonatomic) BOOL ShouldAddAdornments;

- (id) init;
- (id) initWithUrl: (NSString*) url;

-(NSMutableURLRequest*) createfindRequest:(Guidesuggestions*) arg0 __request:(GuideRequestResultHandler*) __request;
-(GuidefindResponse*) find:(Guidesuggestions*) arg0 __error:(NSError**) __error;
-(GuideRequestResultHandler*) findAsync:(Guidesuggestions*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(GuideRequestResultHandler*) findAsync:(Guidesuggestions*) arg0 __target:(id<GuideSoapServiceResponse>) __target;
-(NSMutableURLRequest*) createsaveRequest:(Guidesuggestions*) arg0 __request:(GuideRequestResultHandler*) __request;
-(void) save:(Guidesuggestions*) arg0 __error:(NSError**) __error;
-(GuideRequestResultHandler*) saveAsync:(Guidesuggestions*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(GuideRequestResultHandler*) saveAsync:(Guidesuggestions*) arg0 __target:(id<GuideSoapServiceResponse>) __target;
-(GuideRequestResultHandler*) CreateRequestResultHandler;   
-(NSMutableURLRequest*) createRequest :(NSString*) soapAction __request:(GuideRequestResultHandler*) __request; 
-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(GuideRequestResultHandler*) requestMgr; 
-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(GuideRequestResultHandler*) requestMgr callback:(void (^)(GuideRequestResultHandler *)) callback;

@end
