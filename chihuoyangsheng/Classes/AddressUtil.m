//
//  AddressUtil.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-17.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "AddressUtil.h"
#import "MealService.h"
@implementation AddressUtil


- (void)fetchProAndCity
{
    //第一步，创建URL
    
    NSURL *url = [NSURL URLWithString:@"http://www.chihuo8.com.cn/chys/webservice/findOpenArea.ws"];
    
    //第二步，创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str = @"pageParam={'page':1,'rows':60}&openArea={'areaFlag':'0'}";//设置参数
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error = nil;
    NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:received
                                                                   options:kNilOptions
                                                                     error:&error];
    
    if (!error) {
        [self fetchCitesWithProIDS:result];
    }else{
    }
    
    
}


- (NSMutableDictionary*)fetchCitesWithProIDS:(NSDictionary*)pros
{
    NSMutableDictionary *finalDic = [[NSMutableDictionary alloc] init];
    NSArray *provinces = pros[@"list"];
    
    for (NSDictionary* pro in provinces){
        NSString *proID = pro[@"consId"];
        NSString *proName = pro[@"areaName"];
        [finalDic setObject:[self cityByProID:proID] forKey:proName];
    }

    return nil;
}

- (NSArray*)cityByProID:(NSString*)provinceID
{
    //第一步，创建URL
    
    NSURL *url = [NSURL URLWithString:@"http://www.chihuo8.com.cn/chys/webservice/findOpenArea.ws"];
    
    //第二步，创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str =[NSString stringWithFormat:@"pageParam={'page':1,'rows':60}&openArea={'areaFlag':'1','consId':'%@'}",provinceID];//设置参数
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error = nil;
    NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:received
                                                                   options:kNilOptions
                                                                    error:&error];
    if (!error) {
        
        NSArray *citesArray = result[@"list"];
        for (NSDictionary *cityDicItem in citesArray){
            [array addObject:cityDicItem[@"areaName"]];
        }
    }
    return array;
}

@end
