//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------



#import "DicgetDictById.h"
#import "DicgetDictByIdResponse.h"
#import "Dicdict.h"
#import "DicgetDictByTypeId.h"
#import "DicgetDictByTypeCode.h"
#import "DicHelper.h"
#import "DicRequestResultHandler.h"
#import "DicSoapError.h"



@implementation DicRequestResultHandler

@synthesize Header,Body;
@synthesize OutputHeader,OutputBody,OutputFault;
@synthesize SkipNullProperties,Callback;
@synthesize EnableLogging;
static NSDictionary* classNames;
NSMutableDictionary* referencesTable;
NSMutableDictionary* reverseReferencesTable;
NSMutableData* receivedBuffer;  
NSURLConnection* connection;
NSMutableDictionary* namespaces;
DDXMLDocument *xml;

-(id)init {
if ((self=[super init])) {
        receivedBuffer=[NSMutableData data];
        referencesTable=[NSMutableDictionary dictionary];
        reverseReferencesTable=[NSMutableDictionary dictionary];
        namespaces=[NSMutableDictionary dictionary];
        [self createEnvelopeXml];

        if(!classNames)
        {
            classNames = [NSDictionary dictionaryWithObjectsAndKeys:    
            [DicgetDictById class],@"http://service.dict.sys/^^getDictById",
            [DicgetDictByIdResponse class],@"http://service.dict.sys/^^getDictByIdResponse",
            [Dicdict class],@"http://service.dict.sys/^^dict",
            [DicgetDictByTypeId class],@"http://service.dict.sys/^^getDictByTypeId",
            [DicgetDictByTypeCode class],@"http://service.dict.sys/^^getDictByTypeCode",
            nil]; 

        }
    }
    return self;
}

    
-(NSString*) getEnvelopeString
{
    return [xml XMLString];
}

-(DDXMLDocument*) createEnvelopeXml
{
    NSString *envelope = [NSString stringWithFormat:@"<soap:Envelope xmlns:c=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"></soap:Envelope>"];
    xml = [[DDXMLDocument alloc] initWithXMLString:envelope options:0 error:nil];
    
    DDXMLElement *root=[xml rootElement];
    Header=[[DDXMLElement alloc] initWithName:@"soap:Header"];
    Body=[[DDXMLElement alloc] initWithName:@"soap:Body"];
    [root addChild:Header];
    [root addChild:Body];
    return xml;
}

-(id)createObject: (DDXMLElement*) node type:(Class) type
{
    DDXMLNode* refAttr=[DicHelper getAttribute:node name:@"Ref" url:MS_SERIALIZATION_NS];
    if(refAttr!=nil)
    {
        return [referencesTable objectForKey:[refAttr stringValue]];
    }
    
    DDXMLNode* nilAttr=[DicHelper getAttribute:node name:@"nil" url:XSI];
    if(nilAttr!=nil && [[nilAttr stringValue]boolValue])
    {
        return nil;
    }

    DDXMLNode* typeAttr=[DicHelper getAttribute:node name:@"type" url:XSI];
    if(typeAttr !=nil)
    {
        NSString* attrValue=[typeAttr stringValue];
        NSArray* splitString=[attrValue componentsSeparatedByString:@":"];
        DDXMLNode* namespace=[node resolveNamespaceForName:attrValue];
        NSString* typeName=[splitString count]==2?[splitString objectAtIndex:1]:attrValue;
        if(namespace!=nil)
        {
            NSString* classType=[NSString stringWithFormat:@"%@^^%@",[namespace stringValue],typeName];
            Class temp=[classNames objectForKey: classType];
            if(temp!=nil)
            {
                type=temp;
            }
        }
    }

    DDXMLNode* hrefAttr=[DicHelper getAttribute:node name:@"href" url:@""];
    if(hrefAttr==nil)
    {
        hrefAttr=[DicHelper getAttribute:node name:@"ref" url:@""];
    }
    if(hrefAttr!=nil)
    {
        NSString* hrefId=[[hrefAttr stringValue] substringFromIndex:1];
        NSString* xpathQuery=[NSString stringWithFormat:@"//*[@id='%@']",hrefId];
        NSArray *nodes=[node.rootDocument nodesForXPath:xpathQuery error:nil];

        if([nodes count]>0)
        {
            node=[nodes objectAtIndex:0];
        }
    }

    id obj=[self createInstance:type node:node request:self];

    DDXMLNode* idAttr=[DicHelper getAttribute:node name:@"Id" url:MS_SERIALIZATION_NS];
    if(idAttr!=nil)
    {
        [referencesTable setObject:obj forKey:[idAttr stringValue]];
    }
    
    return obj;
}
    
-(id) createInstance:(Class) type node: (DDXMLNode*)node request :(DicRequestResultHandler *)request
{
    SEL initSelector=@selector(initWithXml:__request:);
    id allocObj=[type alloc];
    IMP imp = [allocObj methodForSelector:initSelector];
    id (*func)(id, SEL, DDXMLNode*, DicRequestResultHandler *) = (void *)imp;
    id obj = func(allocObj, initSelector, node, self);
    return obj;
}

-(NSString*) getNamespacePrefix:(NSString*) url propertyElement:(DDXMLElement*) propertyElement
{
    if([url length]==0)
    {
        return nil;
    }
    DDXMLElement* rootElement= [[propertyElement rootDocument] rootElement];
    NSString* prefix= [namespaces valueForKey:url];
    if(prefix==nil)
    {
        prefix=[NSString stringWithFormat:@"n%d",(int)([namespaces count]+1)];
        DDXMLNode* ns=[DDXMLNode namespaceWithName:prefix stringValue:url];
        [rootElement addNamespace:ns];
        [namespaces setValue:prefix forKey:url];
    }
    return prefix;
}
        
-(NSString*) getXmlFullName:(NSString*) name URI:(NSString*) URI propertyElement:(DDXMLElement*) propertyElement
{
    NSString *prefix=[self getNamespacePrefix:URI propertyElement:propertyElement];
    NSString *fullname=name;
    if(prefix!=nil)
    {
        fullname=[NSString stringWithFormat:@"%@:%@",prefix,name];
    }
    return fullname;
}
    
-(DDXMLNode*) addAttribute:(NSString*) name URI:(NSString*) URI stringValue:(NSString*) stringValue element:(DDXMLElement*) element
{
    NSString *fullname=[self getXmlFullName:name URI:URI propertyElement:element];
    DDXMLNode *refAttr=[DDXMLNode attributeWithName:fullname stringValue:stringValue];
    [element addAttribute:refAttr];
    return refAttr;
}

-(DDXMLElement*) writeElement:(NSString*)name URI: (NSString*) URI parent:(DDXMLElement*) parent
{
    NSString *fullname=[self getXmlFullName:name URI:URI propertyElement:parent];
    DDXMLElement* propertyElement=[[DDXMLElement alloc] initWithName:fullname];
    [parent addChild:propertyElement];
    return propertyElement;
}


-(DDXMLElement*) writeElement:(id)obj type:(Class)type name: (NSString*)name URI: (NSString*) URI parent:(DDXMLElement*) parent skipNullProperty:(BOOL)skipNullProperty
{
    if(obj==nil && skipNullProperty)
    {
        return nil;
    }
    DDXMLElement* propertyElement=[self writeElement:name URI:URI parent:parent];
    
    if(obj==nil)
    {
        [self addAttribute:@"nil" URI:XSI stringValue:@"true" element:propertyElement];
        return nil;

    }

    NSValue* key=[NSValue valueWithNonretainedObject:obj ] ;
    id idStr=[reverseReferencesTable objectForKey:key];
    if(idStr!=nil)
    {
        [self addAttribute:@"Ref" URI:MS_SERIALIZATION_NS stringValue:idStr element:propertyElement];
        return nil;
    }
    if([obj conformsToProtocol:@protocol(DicIReferenceObject)])
    {
        idStr=[NSString stringWithFormat:@"i%d",(int)([reverseReferencesTable count]+1)];       
        [self addAttribute:@"Id" URI:MS_SERIALIZATION_NS stringValue:idStr element:propertyElement];
        [reverseReferencesTable setObject:idStr forKey:key];
    }
    
    Class currentType=[obj class];
    if(currentType!=type)
    {
        NSString* xmlType=(NSString*)[[classNames allKeysForObject:currentType] lastObject];//add namespace?
        if(xmlType!=nil)
        {
            
            NSArray* splitType=[xmlType componentsSeparatedByString:@"^^"];
            NSString *fullname=[self getXmlFullName:[splitType objectAtIndex:1] URI:[splitType objectAtIndex:0] propertyElement:propertyElement];
            [self addAttribute:@"type" URI:XSI stringValue:fullname element:propertyElement];
        }
        
    }
    return propertyElement;
}



        
-(void)setResponse:(NSData *)response
{
    if(self.EnableLogging) {
        NSString* strResponse = [[NSString alloc] initWithData: response encoding: NSUTF8StringEncoding];
        NSLog(@"%@", strResponse);
    }
    
    DDXMLDocument *__doc=[[DDXMLDocument alloc] initWithData:response options:0 error:nil];
    DDXMLElement *__root=[__doc rootElement];
    if(__root==nil)
    {
        NSString* errorMessage=[[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding ];
        OutputFault=[NSError  errorWithDomain:errorMessage code:0 userInfo:nil];
        return;
    }
    OutputBody=[DicHelper getNode:__root  name:@"Body" URI:@"http://schemas.xmlsoap.org/soap/envelope/"];
    OutputHeader=[DicHelper getNode:__root  name:@"Header" URI:@"http://schemas.xmlsoap.org/soap/envelope/"];
    DDXMLElement* fault=[DicHelper getNode:OutputBody  name:@"Fault" URI:@"http://schemas.xmlsoap.org/soap/envelope/"];
    if(fault!=nil)
    {
        DDXMLElement* faultString=[DicHelper getNode:fault name:@"faultstring"];
        id faultObj=nil;
        DDXMLElement* faultDetail=[DicHelper getNode:fault name:@"detail"];
        if(faultDetail!=nil)
        {
            DDXMLElement* faultClass=(DDXMLElement*)[faultDetail childAtIndex:0];
            if(faultClass!=nil)
            {
                NSString * typeName=[faultClass name];
                DDXMLNode* namespaceNode=[faultClass resolveNamespaceForName:typeName];
                NSString* namespace=nil;
                if(namespaceNode==nil)
                {
                    namespace=[faultClass URI];
                }
                else
                {
                    namespace=[namespaceNode stringValue];
                }
                NSString* classType=[NSString stringWithFormat:@"%@^^%@",namespace,typeName];
                Class temp=[classNames objectForKey: classType];
                if(temp!=nil)
                {
                    faultObj= [self createInstance:temp node:faultClass request:self];
                }
            }
        }
        
        OutputFault=[[DicSoapError alloc] initWithDetails:[faultString stringValue] details:faultObj];
    }
}

-(void) sendImplementation:(NSMutableURLRequest*) request
{
    if(self.EnableLogging) {
        NSString* strRequest = [[NSString alloc] initWithData: request.HTTPBody encoding: NSUTF8StringEncoding];
        NSLog(@"%@", strRequest);
    }
    
    NSError* innerError;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&innerError];
    if(data==nil)
    {
        OutputFault = innerError;
    }
    else
    {
        [self setResponse:data];
    }
}

-(void) sendImplementation:(NSMutableURLRequest*) request callbackDelegate:(DicCLB) callbackDelegate
{
    if(self.EnableLogging) {
        NSString* strRequest = [[NSString alloc] initWithData: request.HTTPBody encoding: NSUTF8StringEncoding];
        NSLog(@"%@", strRequest);
    }
    self.Callback=callbackDelegate;
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedBuffer setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)value {
    [receivedBuffer appendData:value];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    connection = nil;
    self.Callback=nil;
	OutputFault=error;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	connection = nil;
    [self setResponse:receivedBuffer];
    self.Callback(self);
    self.Callback=nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
}

-(void)Cancel
{
    if(connection!=nil)
    {
        [connection cancel];
        connection=nil;
        self.Callback=nil;
    }
}


@end
