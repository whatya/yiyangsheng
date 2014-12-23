//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------


#import "CookBookCookbookServiceImplServiceSoapBinding.h"
#import "CookBookRequestResultHandler.h"
#import "CookBookHelper.h"

@implementation CookBookCookbookServiceImplServiceSoapBinding
@synthesize Url,ShouldAddAdornments,Headers;

- (id) init {
    if(self = [super init])
    {
        self.Url=[NSString stringWithFormat:@"%@%@",WebserviceUrl,@"cookbook"];
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

-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(CookBookRequestResultHandler*) requestMgr
{
    [requestMgr sendImplementation:request];
}

-(CookBookRequestResultHandler*) CreateRequestResultHandler
{
    return [[CookBookRequestResultHandler alloc]init];
}
-(NSMutableURLRequest*) createRequest:(NSString *)__soapAction __request:(CookBookRequestResultHandler*) __request
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

-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(CookBookRequestResultHandler*) requestMgr callback:(void (^)(CookBookRequestResultHandler *)) callback
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

-(NSMutableURLRequest*) creategetByIdRequest:(NSString*) arg0 __request:(CookBookRequestResultHandler*) __request
{
    DDXMLElement *__methodElement=[__request writeElement:@"getById" URI:@"http://service.cookbook.app/" parent:__request.Body];
    [self addAdornments:__methodElement];
             
        DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[NSString class] name:@"arg0" URI:@"" parent:__methodElement skipNullProperty:__request.SkipNullProperties];
        if(__arg0ItemElement!=nil)
        {
            [__arg0ItemElement setStringValue:arg0];
        }
    
    NSMutableURLRequest* __requestObj= [self createRequest:@""  __request:__request];
    return __requestObj;
}

-(CookBookRequestResultHandler*) getByIdAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler
{
    CookBookRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self creategetByIdRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(CookBookRequestResultHandler *__requestMgr) {
    id __res;
    if(__requestMgr.OutputFault==nil)
    {
        DDXMLElement *__result=[CookBookHelper getResultElement:__request.OutputBody name:@"return"];
        __res= (CookBookcookbook*)[__request createObject:__result type:[CookBookcookbook class]];
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

-(CookBookRequestResultHandler*) getByIdAsync:(NSString*) arg0 __target:(id<CookBookSoapServiceResponse>) __target
{
    CookBookRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self creategetByIdRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(CookBookRequestResultHandler *__requestMgr) {
    if(__requestMgr.OutputFault==nil)
    {
        DDXMLElement *__result=[CookBookHelper getResultElement:__request.OutputBody name:@"return"];
        [__target onSuccess:(CookBookcookbook*)[__request createObject:__result type:[CookBookcookbook class]]];
    }
    else
    {
        [__target onError:__requestMgr.OutputFault];
    }
    }];
    return __request;
}

-(CookBookcookbook*) getById:(NSString*) arg0 __error:(NSError**) __error 
{
    CookBookRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self creategetByIdRequest:arg0 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request ];
    if(__request.OutputFault!=nil)
    {
        if(__error)
        {
            *__error=__request.OutputFault;
        }
        return nil;
    }
    DDXMLElement *__result=[CookBookHelper getResultElement:__request.OutputBody name:@"return"];
    return (CookBookcookbook*)[__request createObject:__result type:[CookBookcookbook class]];
}
-(NSMutableURLRequest*) createfindCookbookByNameRequest:(CookBookpageParam*) arg0 arg1:(NSString*) arg1 __request:(CookBookRequestResultHandler*) __request
{
    DDXMLElement *__methodElement=[__request writeElement:@"findCookbookByName" URI:@"http://service.cookbook.app/" parent:__request.Body];
    [self addAdornments:__methodElement];
             
        DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[CookBookpageParam class] name:@"arg0" URI:@"" parent:__methodElement skipNullProperty:__request.SkipNullProperties];
        if(__arg0ItemElement!=nil)
        {
            [arg0 serialize:__arg0ItemElement __request: __request];
        }
             
        DDXMLElement* __arg1ItemElement=[__request writeElement:arg1 type:[NSString class] name:@"arg1" URI:@"" parent:__methodElement skipNullProperty:__request.SkipNullProperties];
        if(__arg1ItemElement!=nil)
        {
            [__arg1ItemElement setStringValue:arg1];
        }
    
    NSMutableURLRequest* __requestObj= [self createRequest:@""  __request:__request];
    return __requestObj;
}

-(CookBookRequestResultHandler*) findCookbookByNameAsync:(CookBookpageParam*) arg0 arg1:(NSString*) arg1 __target:(id) __target __handler:(SEL) __handler
{
    CookBookRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindCookbookByNameRequest:arg0 arg1: arg1 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(CookBookRequestResultHandler *__requestMgr) {
    id __res;
    if(__requestMgr.OutputFault==nil)
    {
        DDXMLElement *__result=[CookBookHelper getResultElement:__request.OutputBody name:@"return"];
        
        NSArray *rows = [__result elementsForName:@"rows"];
        NSMutableArray *bookArray = [[NSMutableArray alloc] init];
        for (DDXMLElement *row in rows){
            id book = [__request createObject:row type:[CookBookcookbook class]];
            [bookArray addObject:book];
        }
        CookBookjsonData *cookBookJson = (CookBookjsonData*)[__request createObject:__result type:[CookBookjsonData class]];
        cookBookJson.rows = bookArray;
        __res = cookBookJson;
        
        //__res= (CookBookjsonData*)[__request createObject:__result type:[CookBookjsonData class]];
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

-(CookBookRequestResultHandler*) findCookbookByNameAsync:(CookBookpageParam*) arg0 arg1:(NSString*) arg1 __target:(id<CookBookSoapServiceResponse>) __target
{
    CookBookRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindCookbookByNameRequest:arg0 arg1: arg1 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request callback:^(CookBookRequestResultHandler *__requestMgr) {
    if(__requestMgr.OutputFault==nil)
    {
        DDXMLElement *__result=[CookBookHelper getResultElement:__request.OutputBody name:@"return"];
        [__target onSuccess:(CookBookjsonData*)[__request createObject:__result type:[CookBookjsonData class]]];
    }
    else
    {
        [__target onError:__requestMgr.OutputFault];
    }
    }];
    return __request;
}

-(CookBookjsonData*) findCookbookByName:(CookBookpageParam*) arg0 arg1:(NSString*) arg1 __error:(NSError**) __error 
{
    CookBookRequestResultHandler* __request = [self CreateRequestResultHandler];        
    NSMutableURLRequest *__requestObj=[self createfindCookbookByNameRequest:arg0 arg1: arg1 __request:__request];
    [self sendImplementation:__requestObj requestMgr:__request ];
    if(__request.OutputFault!=nil)
    {
        if(__error)
        {
            *__error=__request.OutputFault;
        }
        return nil;
    }
    DDXMLElement *__result=[CookBookHelper getResultElement:__request.OutputBody name:@"return"];
    
    NSArray *rows = [__result elementsForName:@"rows"];
    NSMutableArray *bookArray = [[NSMutableArray alloc] init];
    for (DDXMLElement *row in rows){
        id book = [__request createObject:row type:[CookBookcookbook class]];
        [bookArray addObject:book];
    }
    CookBookjsonData *cookBookJson = (CookBookjsonData*)[__request createObject:__result type:[CookBookjsonData class]];
    cookBookJson.rows = bookArray;
    return cookBookJson;
}

@end
