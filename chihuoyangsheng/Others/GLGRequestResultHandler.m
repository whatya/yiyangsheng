//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.3.2
//
// Created by Quasar Development at 09-06-2014
//
//---------------------------------------------------



#import "GLGsuggestions.h"
#import "GLGHelper.h"
#import "GLGRequestResultHandler.h"
#import "GLGSoapError.h"



@implementation GLGRequestResultHandler

@synthesize Header,Body;
@synthesize OutputHeader,OutputBody,OutputFault;
@synthesize Callback;
@synthesize EnableLogging;
static NSDictionary* classNames;
NSMutableData* receivedBuffer;  
NSURLConnection* connection;
NSMutableDictionary* namespaces;
DDXMLDocument *xml;

-(id)init {
if ((self=[super init])) {
        receivedBuffer=[NSMutableData data];
        namespaces=[NSMutableDictionary dictionary];
        [self createEnvelopeXml];

        if(!classNames)
        {
            classNames = [NSDictionary dictionaryWithObjectsAndKeys:    
            [GLGsuggestions class],@"http://service.suggestions.app/^^suggestions",
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
    
    DDXMLNode* nilAttr=[GLGHelper getAttribute:node name:@"nil" url:XSI];
    if(nilAttr!=nil && [[nilAttr stringValue]boolValue])
    {
        return nil;
    }

    DDXMLNode* typeAttr=[GLGHelper getAttribute:node name:@"type" url:XSI];
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

    DDXMLNode* hrefAttr=[GLGHelper getAttribute:node name:@"href" url:@""];
    if(hrefAttr==nil)
    {
        hrefAttr=[GLGHelper getAttribute:node name:@"ref" url:@""];
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

    
    return obj;
}
    
-(id) createInstance:(Class) type node: (DDXMLNode*)node request :(GLGRequestResultHandler *)request
{
    SEL initSelector=@selector(initWithXml:__request:);
    id allocObj=[type alloc];
    IMP imp = [allocObj methodForSelector:initSelector];
    id (*func)(id, SEL, DDXMLNode*, GLGRequestResultHandler *) = (void *)imp;
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
    OutputBody=[GLGHelper getNode:__root  name:@"Body" URI:@"http://schemas.xmlsoap.org/soap/envelope/"];
    OutputHeader=[GLGHelper getNode:__root  name:@"Header" URI:@"http://schemas.xmlsoap.org/soap/envelope/"];
    DDXMLElement* fault=[GLGHelper getNode:OutputBody  name:@"Fault" URI:@"http://schemas.xmlsoap.org/soap/envelope/"];
    if(fault!=nil)
    {
        DDXMLElement* faultString=[GLGHelper getNode:fault name:@"faultstring"];
        id faultObj=nil;
        DDXMLElement* faultDetail=[GLGHelper getNode:fault name:@"detail"];
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
        
        OutputFault=[[GLGSoapError alloc] initWithDetails:[faultString stringValue] details:faultObj];
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

-(void) sendImplementation:(NSMutableURLRequest*) request callbackDelegate:(GLGCLB) callbackDelegate
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
    OutputFault=error;
    self.Callback(self);
    connection = nil;
    self.Callback=nil;
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
