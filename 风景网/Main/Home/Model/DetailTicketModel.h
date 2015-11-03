//
//  DetailTicketModel.h
//  风景网
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface DetailTicketModel : BaseModel
@property(nonatomic,copy)NSString *abstract;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *telephone;
@property(nonatomic,copy)NSString *star;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSDictionary *ticket_info;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *open_time;
@property(nonatomic,copy)NSString *name2;
//@property(nonatomic,copy)NSString *description;

//初始化方法
-(id)initWthContentsOfDictionary:(NSDictionary *)dictionary;
@end
