//
//  WebViewController.h
//  风景网
//
//  Created by mac on 15/10/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface WebViewController : UIViewController
@property(nonatomic,assign)HomeModel *model;
@property(nonatomic,copy)NSString *urlString;
@end
