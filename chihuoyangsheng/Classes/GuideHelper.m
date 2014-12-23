//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 3.0.1.0
//
// Created by Quasar Development at 29-03-2014
//
//---------------------------------------------------
  
#import "GuideHelper.h"

@implementation GuideHelper

+(DDXMLElement*) getResultElement: (DDXMLElement*) body name:(NSString*)name
{
    DDXMLElement* resultElement=(DDXMLElement*)[body childAtIndex:0];
    if([resultElement childCount]>0)
    {
        DDXMLElement* propertyElement=(DDXMLElement*)[resultElement childAtIndex:0];
        if([propertyElement.localName isEqualToString:name])
        {
            return propertyElement;
        }
        if([resultElement.localName isEqualToString:name])
        {
            return resultElement;
        }
    }
    return body;
}

+ (NSData *)base64DataFromString: (NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;

    if (string == nil)
    {
        return [NSData data];
    }

    ixtext = 0;

    tempcstring = (const unsigned char *)[string UTF8String];

    lentext = [string length];

    theData = [NSMutableData dataWithCapacity: lentext];

    ixinbuf = 0;

    while (true)
    {
        if (ixtext >= lentext)
        {
            break;
        }

        ch = tempcstring [ixtext++];

        flignore = false;

        if ((ch >= 'A') && (ch <= 'Z'))
        {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z'))
        {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9'))
        {
            ch = ch - '0' + 52;
        }
        else if (ch == '+')
        {
            ch = 62;
        }
        else if (ch == '=')
        {
            flendtext = true;
        }
        else if (ch == '/')
        {
            ch = 63;
        }
        else
        {
            flignore = true;
        }

        if (!flignore)
        {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;

            if (flendtext)
            {
                if (ixinbuf == 0)
                {
                    break;
                }

                if ((ixinbuf == 1) || (ixinbuf == 2))
                {
                    ctcharsinbuf = 1;
                }
                else
                {
                    ctcharsinbuf = 2;
                }

                ixinbuf = 3;

                flbreak = true;
            }

            inbuf [ixinbuf++] = ch;

            if (ixinbuf == 4)
            {
                ixinbuf = 0;

                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);

                for (i = 0; i < ctcharsinbuf; i++)
                {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }

            if (flbreak)
            {
                break;
            }
        }
    }

    return theData;
}

+ (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];

    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;

    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;

            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }

        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }

    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+(DDXMLElement*) getNode:(DDXMLElement *) node name:(NSString*) name URI:(NSString*) URI
{
    NSArray *items= [node elementsForLocalName:name URI:URI];
    if([items count]>0)
    {
        return [items objectAtIndex:0];
    }
    return nil;
}

+(DDXMLNode*) getAttribute:(DDXMLElement *)node name:(NSString *)name
{
    return [node attributeForName: name];
}

+(DDXMLElement*) getNode:(DDXMLElement *)node name:(NSString *)name
{
    NSArray *items= [node elementsForName:name];
    if([items count]>0)
    {
        DDXMLElement *element= [items objectAtIndex:0];
        return element;
    }
    return nil;
}

+(BOOL) hasAttribute:(DDXMLElement*) node name:(NSString*)name
{
    DDXMLNode* child=[GuideHelper getAttribute:node name:name];
    return child!=nil;
}

+(BOOL) hasValue:(DDXMLElement*) node name:(NSString*)name
{
    DDXMLElement* child=[GuideHelper getNode:node name:name];
    if(child!=nil)
    {
        DDXMLNode* nilAttr=[GuideHelper getAttribute:child name:@"nil" url:XSI];
        return nilAttr==nil;
    }
    return NO;
}

+(NSString*) toBoolStringFromNumber:(NSNumber*)boolNumber
{
    if(boolNumber!=nil)
    {
        return [boolNumber boolValue]?@"true":@"false";
    }
    return nil;
}

+(NSString*) toBoolStringFromBool:(BOOL)boolValue
{
    return (boolValue ==YES?@"true":@"false");
}

+(NSNumber*) getNumber:(NSString*) stringNumber
{
    NSNumberFormatter* formatter=[[NSNumberFormatter alloc] init];
    [formatter setDecimalSeparator:@"."];
    return [formatter numberFromString:stringNumber];
}

+(NSDate*) getDate:(NSString*) stringDate
{
    if([stringDate length]>0)
    {
    
        NSArray* formats = [NSArray arrayWithObjects:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            @"yyyy-MM-dd'T'HH:mm:ss.SSS",
            @"yyyy-MM-dd'T'HH:mm:ssZZZZ",
            @"yyyy-MM-dd'T'HH:mm:ssZ",
            @"yyyy-MM-dd'T'HH:mm:ss",
            @"yyyy-MM-dd'T'HH:mmZ",
            @"yyyy-MM-dd'T'HH:mm",
            @"yyyy-MM-ddZ",
            @"yyyy-MM-dd",nil];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        for (NSString* format in formats) {
            [dateFormatter setDateFormat:format];
            NSDate* date= [dateFormatter dateFromString:stringDate];
            if(date!=nil)
            {
                return date;
            }
        }
    }
    return nil;
}

+(NSString*) getStringFromDate:(NSDate*) date
{
    if(date!=nil)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        return [dateFormatter stringFromDate:date];

    }
    return nil;
}


+(DDXMLNode*) getAttribute:(DDXMLElement*) node name:(NSString*)name url:(NSString*) url
{
    NSString * fullName=name;
    NSString* prefix=[node resolvePrefixForNamespaceURI:url];
    if([prefix length]>0)
    {
        fullName=[prefix stringByAppendingFormat:@":%@",name];
    }
    DDXMLNode * typeAttr=[node attributeForName:fullName];
    return typeAttr;
}
@end