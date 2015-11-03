//
//  HomeCell.h
//  风景网
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeCell : UITableViewCell
//@property(nonatomic,copy)NSString *title;
//@property(nonatomic,copy)NSString *subTitle;
//@property(nonatomic,copy)NSString *startCity;//城市
//@property(nonatomic,copy)NSString *img;
//@property(nonatomic,assign)CGFloat minPrice;//价格
//@property(nonatomic,assign)CGFloat FavoriteCount;//喜欢人数
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *startCity;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *minPrice;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *days;

@property(nonatomic,strong)HomeModel *model;


@end
