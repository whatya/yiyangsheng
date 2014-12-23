//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.0.4.1
//
// Created by Quasar Development at 17-10-2014
//
//---------------------------------------------------


#import "HFNDietaryAdviceServiceImplServiceSoapBinding.h"
#import "HFNRequestResultHandler.h"
#import "HFNHelper.h"

@implementation HFNDietaryAdviceServiceImplServiceSoapBinding
@synthesize Url,ShouldAddAdornments,Headers;
@synthesize EnableLogging;

- (id) init {
    if(self = [super init])
    {
        self.Url=[NSString stringWithFormat:@"%@%@",WebserviceUrl,@"dietaryAdvice"];
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

-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(HFNRequestResultHandler*) requestMgr
{
    [requestMgr sendImplementation:request];
}

-(HFNRequestResultHandler*) CreateRequestResultHandler
{
    HFNRequestResultHandler* handler= [[HFNRequestResultHandler alloc]init:SOAPVERSION_11];
        handler.EnableLogging = EnableLogging;
    return handler;
}
-(NSMutableURLRequest*) createRequest:(NSString *)__soapAction __request:(HFNRequestResultHandler*) __request
{
    NSURL *__url = [NSURL URLWithString:Url];
    NSMutableURLRequest *__requestObj = [NSMutableURLRequest requestWithURL:__url];
    [__request prepareRequest:__requestObj];

    [__requestObj addValue: __soapAction forHTTPHeaderField:@"SOAPAction"];

    for (NSString* key in self.Headers) {
        [__requestObj addValue: [self.Headers objectForKey:key] forHTTPHeaderField:key];
    }
    [__requestObj setHTTPMethod:@"POST"];
    return __requestObj;
}

-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(HFNRequestResultHandler*) requestMgr callback:(void (^)(HFNRequestResultHandler *)) callback
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

-(NSMutableURLRequest*) createfindDietaryAdviceRequest:(int) arg0 arg1:(int) arg1 arg2:(HFNdietaryAdvice*) arg2 __request:(HFNRequestResultHandler*) __request
{
    DDXMLElement *__methodElement=[__request writeElement:@"findDietaryAdvice" URI:@"http://service.dietary.app/" parent:__request.Body];
    [self addAdornments:__methodElement];
             
    DDXMLElement* __arg0ItemElement=[__request writeElement:@"arg0" URI:@"" parent:__methodElement];
    [__arg0ItemElement setStringValue: [NSString stringWithFormat:@"%i", arg0]];
             
    DDXMLElement* __arg1ItemElement=[__request writeElement:@"arg1" URI:@"" parent:__methodElement];
    [__arg1ItemElement setStringValue: [NSString stringWithFormat:@"%i", arg1]];
             
    DDXMLElement* __arg2ItemElement=[__request writeElement:arg2 type:[HFNdietaryAdvice class] name:@"arg2" URI:@"" parent:__methodElement skipNullProperty:YES];
    if(__arg2ItemElement!=nil)
    {
        [arg2 serialize:__arg2ItemElement __request: __request];
    }
    
    NSMutableURLRequest* __requestObj= [self createRequest:@""  __request:__request];
    return __requestObj;
}

-(HFNRequestResultHandler*) findDietaryAdviceAsync:(int) arg0 arg1:(int) arg1 arg2:(HFNdietaryAdvice*) arg2 __target:(id) __target __handler:(SEL) __handler
{
    HFNRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindDietaryAdviceRequest:arg0 arg1: arg1 arg2: arg2 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(HFNRequestResultHandler *__requestMgr) {
    id __res;
    if(__requestMgr.OutputFault==nil)
    {
        DDXMLElement *__result=[HFNHelper getResultElement:__request.OutputBody name:@"return"];
        __res= (HFNjsonData*)[__request createObject:__result type:[HFNjsonData class]];
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

-(HFNRequestResultHandler*) findDietaryAdviceAsync:(int) arg0 arg1:(int) arg1 arg2:(HFNdietaryAdvice*) arg2 __target:(id<HFNSoapServiceResponse>) __target
{
    HFNRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindDietaryAdviceRequest:arg0 arg1: arg1 arg2: arg2 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(HFNRequestResultHandler *__requestMgr) {
    if(__requestMgr.OutputFault==nil)
    {
        DDXMLElement *__result=[HFNHelper getResultElement:__request.OutputBody name:@"return"];
        [__target onSuccess:(HFNjsonData*)[__request createObject:__result type:[HFNjsonData class]] methodName:@""];
    }
    else
    {
        [__target onError:__requestMgr.OutputFault];
    }
    }];
    return __request;
}

-(HFNjsonData*) findDietaryAdvice:(int) arg0 arg1:(int) arg1 arg2:(HFNdietaryAdvice*) arg2 __error:(NSError**) __error 
{
    HFNRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindDietaryAdviceRequest:arg0 arg1: arg1 arg2: arg2 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request ];
    if(__request.OutputFault!=nil)
    {
        if(__error)
        {
            *__error=__request.OutputFault;
        }
        return nil;
    }
    DDXMLElement *__result=[HFNHelper getResultElement:__request.OutputBody name:@"return"];
    NSArray *rows = [__result elementsForName:@"rows"];
    NSMutableArray *adviceArray = [[NSMutableArray alloc] init];
    for (DDXMLElement *row in rows){
        id advice = [__request createObject:row type:[HFNdietaryAdvice class]];
        [adviceArray addObject:advice];
    }
    HFNjsonData *adviceJson = (HFNjsonData*)[__request createObject:__result type:[HFNjsonData class]];
    adviceJson.rows = adviceArray;
    return adviceJson;
}

-(HFNRequestResultHandler*) deleteByIdAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler
{
    /*This feature is available in Premium account, Check http://EasyWsdl.com/Payment/PremiumAccountDetails to see all benefits of Premium account*/
    return nil;
}

-(HFNRequestResultHandler*) deleteByIdAsync:(NSString*) arg0 __target:(id<HFNSoapServiceResponse>) __target
{
    /*This feature is available in Premium account, Check http://EasyWsdl.com/Payment/PremiumAccountDetails to see all benefits of Premium account*/
    return nil;
}

-(void) deleteById:(NSString*) arg0 __error:(NSError**) __error 
{
    /*This feature is available in Premium account, Check http://EasyWsdl.com/Payment/PremiumAccountDetails to see all benefits of Premium account*/
}

@end