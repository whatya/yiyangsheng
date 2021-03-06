//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "GuideSuggestionsServiceImplServiceSoapBinding.h"
#import "GuideRequestResultHandler.h"
#import "GuideHelper.h"

@implementation GuideSuggestionsServiceImplServiceSoapBinding
@synthesize Url,ShouldAddAdornments,Headers;

- (id) init {
    if(self = [super init])
    {
        self.Url=[NSString stringWithFormat:@"%@%@",WebserviceUrl,@"suggestions"];
        self.ShouldAddAdornments=YES;
    }
    return self;
}

- (id) initWithUrl: (NSString*) url {
    if(self = [self init])
    {
        self.Url=url;
    }
    return self;
}

-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(GuideRequestResultHandler*) requestMgr
{
    [requestMgr sendImplementation:request];
}

-(GuideRequestResultHandler*) CreateRequestResultHandler
{
    return [[GuideRequestResultHandler alloc]init];
}
-(NSMutableURLRequest*) createRequest:(NSString *)__soapAction __request:(GuideRequestResultHandler*) __request
{
    NSString *__soapMessage=[__request getEnvelopeString];
    NSURL *__url = [NSURL URLWithString:Url];
    NSMutableURLRequest *__requestObj = [NSMutableURLRequest requestWithURL:__url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[__soapMessage length]];

    [__requestObj addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [__requestObj addValue: __soapAction forHTTPHeaderField:@"SOAPAction"];
    [__requestObj addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    for (NSString* key in self.Headers) {
        [__requestObj addValue: [self.Headers objectForKey:key] forHTTPHeaderField:key];
    }
    [__requestObj setHTTPMethod:@"POST"];
    [__requestObj setHTTPBody: [__soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    return __requestObj;
}

-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(GuideRequestResultHandler*) requestMgr callback:(void (^)(GuideRequestResultHandler *)) callback
{
    [requestMgr sendImplementation:request callbackDelegate:callback];
}

-(void) addAdornments:(DDXMLElement*)__methodElement
{
    if(ShouldAddAdornments)
    {
        [__methodElement addAttribute:[DDXMLNode attributeWithName:@"id" stringValue:@"o0"]];
        [__methodElement addAttribute:[DDXMLNode attributeWithName:@"c:root" stringValue:@"1"]];
    }
}

-(NSMutableURLRequest*) createfindRequest:(Guidesuggestions*) arg0 __request:(GuideRequestResultHandler*) __request
{
    DDXMLElement *__methodElement=[__request writeElement:@"find" URI:@"http://service.suggestions.app/" parent:__request.Body];
    [self addAdornments:__methodElement];
             
        DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[Guidesuggestions class] name:@"arg0" URI:@"" parent:__methodElement skipNullProperty:__request.SkipNullProperties];
        if(__arg0ItemElement!=nil)
        {
            [arg0 serialize:__arg0ItemElement __request: __request];
        }
    
    NSMutableURLRequest* __requestObj= [self createRequest:@""  __request:__request];
    return __requestObj;
}

-(GuideRequestResultHandler*) findAsync:(Guidesuggestions*) arg0 __target:(id) __target __handler:(SEL) __handler
{
    GuideRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(GuideRequestResultHandler *__requestMgr) {
    id __res;
    if(__requestMgr.OutputFault==nil)
    {
        DDXMLElement *__result=[GuideHelper getResultElement:__request.OutputBody name:@"findResponse"];
        __res= (GuidefindResponse*)[__request createObject:__result type:[GuidefindResponse class]];
    }
    else
    {
        __res=__requestMgr.OutputFault;
    }
    
    IMP imp = [__target methodForSelector:__handler];
    void (*func)(id, SEL,id) = (void *)imp;
    func(__target, __handler,__res);
    }];
    return __request;
}

-(GuideRequestResultHandler*) findAsync:(Guidesuggestions*) arg0 __target:(id<GuideSoapServiceResponse>) __target
{
    GuideRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(GuideRequestResultHandler *__requestMgr) {
    if(__requestMgr.OutputFault==nil)
    {
        DDXMLElement *__result=[GuideHelper getResultElement:__request.OutputBody name:@"findResponse"];
        [__target onSuccess:(GuidefindResponse*)[__request createObject:__result type:[GuidefindResponse class]]];
    }
    else
    {
        [__target onError:__requestMgr.OutputFault];
    }
    }];
    return __request;
}

-(GuidefindResponse*) find:(Guidesuggestions*) arg0 __error:(NSError**) __error 
{
    GuideRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request ];
    if(__request.OutputFault!=nil)
    {
        if(__error)
        {
            *__error=__request.OutputFault;
        }
        return nil;
    }
    DDXMLElement *__result=[GuideHelper getResultElement:__request.OutputBody name:@"findResponse"];
    return (GuidefindResponse*)[__request createObject:__result type:[GuidefindResponse class]];
}
-(NSMutableURLRequest*) createsaveRequest:(Guidesuggestions*) arg0 __request:(GuideRequestResultHandler*) __request
{
    DDXMLElement *__methodElement=[__request writeElement:@"save" URI:@"http://service.suggestions.app/" parent:__request.Body];
    [self addAdornments:__methodElement];
             
        DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[Guidesuggestions class] name:@"arg0" URI:@"" parent:__methodElement skipNullProperty:__request.SkipNullProperties];
        if(__arg0ItemElement!=nil)
        {
            [arg0 serialize:__arg0ItemElement __request: __request];
        }
    
    NSMutableURLRequest* __requestObj= [self createRequest:@""  __request:__request];
    return __requestObj;
}

-(GuideRequestResultHandler*) saveAsync:(Guidesuggestions*) arg0 __target:(id) __target __handler:(SEL) __handler
{
    GuideRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createsaveRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(GuideRequestResultHandler *__requestMgr) {
    id __res;
    if(__requestMgr.OutputFault==nil)
    {
        __res=nil; 
    }
    else
    {
        __res=__requestMgr.OutputFault;
    }
    
    IMP imp = [__target methodForSelector:__handler];
    void (*func)(id, SEL,id) = (void *)imp;
    func(__target, __handler,__res);
    }];
    return __request;
}

-(GuideRequestResultHandler*) saveAsync:(Guidesuggestions*) arg0 __target:(id<GuideSoapServiceResponse>) __target
{
    GuideRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createsaveRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(GuideRequestResultHandler *__requestMgr) {
    if(__requestMgr.OutputFault==nil)
    {
        [__target onSuccess:nil];
    }
    else
    {
        [__target onError:__requestMgr.OutputFault];
    }
    }];
    return __request;
}

-(void) save:(Guidesuggestions*) arg0 __error:(NSError**) __error 
{
    GuideRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createsaveRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request ];
    if(__request.OutputFault!=nil)
    {
        if(__error)
        {
            *__error=__request.OutputFault;
        }
        return;
    }
}

@end
