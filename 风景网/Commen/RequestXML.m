//
//  RequestXML.m
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "RequestXML.h"
#import "DDXML.h"
@implementation RequestXML

+(void)postxml:(NSString *)requestString FinishBlock:(void (^)(NSDictionary *))block
{
    //prepar request
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:@"http://travel.fengjing.com/HolidaySvc.asmx"]];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    // 设置请求体
    NSString *XMLStr = requestString;
    
    //    NSLog(@"%@",XMLStr);
    
    // 设置请求头
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    // NSString --> NSData
    request.HTTPBody = [XMLStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //get response
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // XML解析
        DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
        
        
        // 获取文档的根节点
        DDXMLElement *sourceElement = document.rootElement;
        
        // 获取soap:Body节点信息
        NSArray *arr1 = [sourceElement elementsForName:@"soap:Body"];
        DDXMLElement *requestServiceDataResponse = [arr1 firstObject];
        
        // 获取RequestServiceDataResponse节点信息
        NSArray *arr2 = [requestServiceDataResponse elementsForName:@"RequestServiceDataResponse"];
        DDXMLElement *RequestServiceDataResult = [arr2 firstObject];
        
        // 获取RequestServiceDataResult节点信息
        NSArray *arr3 = [RequestServiceDataResult elementsForName:@"RequestServiceDataResult"];
        DDXMLElement *result = [arr3 firstObject];
        
        // 数据解析成字典
        NSData *jsonData = [result.stringValue dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        if (connectionError) {
            NSLog(@"出错，检查一下你的网络%@",connectionError);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        block(dic);
        
    }];
    
}


@end
