//
//  HomeModel.h
//  风景网
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface HomeModel :BaseModel

@property(nonatomic,copy)NSString *lineId;//id
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subTitle;
@property(nonatomic,copy)NSString *startCity;//城市
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *minPrice;//价格
@property(nonatomic,copy)NSString *FavoriteCount;//喜欢人数
@property(nonatomic,copy)NSString *C_DateBeg;//开始时间
@property(nonatomic,copy)NSString *C_DateEnd;//结束时间
@property(nonatomic,copy)NSString *C_days;
@property(nonatomic,copy)NSArray *routelist;
@end
