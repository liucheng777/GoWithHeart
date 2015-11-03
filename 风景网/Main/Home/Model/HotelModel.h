//
//  HotelModel.h
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface HotelModel : BaseModel

@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *Address;
@property(nonatomic,copy)NSNumber *minPrice;
@property(nonatomic,copy)NSString *ImgThumb;
@property(nonatomic,copy)NSString *MonthSaleCount;

@end
