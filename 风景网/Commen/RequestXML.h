//
//  RequestXML.h
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestXML : UIView

+(void) postxml:(NSString *)requestString FinishBlock:(void (^)(NSDictionary *))block;

@end
