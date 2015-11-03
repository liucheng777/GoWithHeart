//
//  ResortModel.h
//  风景网
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface ResortModel : BaseModel

@property(nonatomic,copy)NSString *bookUrl;
@property(nonatomic,copy)NSString *headImage;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *likeCount;
@property(nonatomic,copy)NSString *routeDays;
@property(nonatomic,copy)NSString *startTime;


@end
