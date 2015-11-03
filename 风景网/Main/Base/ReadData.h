//
//  ReadData.h
//  风景网
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadData : NSObject
+(ReadData *)shareInstance;
+(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg completionHandle:(void(^)(id))completionBlock errorhandle:(void(^)(NSError *))errorBlock;;
@end
