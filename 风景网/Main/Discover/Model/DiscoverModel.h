//
//  DiscoverModel.h
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface DiscoverModel : BaseModel

@property (nonatomic,copy) NSString *SName;//景点名
@property (nonatomic,copy) NSString *Address;//地址
@property (nonatomic,copy) NSString *voice_Picture;//图片
@property (nonatomic,copy) NSNumber *SalePrice;//售价
@property (nonatomic,copy) NSString *ScenicId;//详情求情编号
@property (nonatomic,copy) NSString *PriceNotes;//开放时间
@property (nonatomic,copy) NSString *ScenicMes;//景点介绍；
@property (nonatomic,assign) NSInteger imagesCount;





@end
