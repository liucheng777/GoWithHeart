//
//  ResortCell.h
//  风景网
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResortModel.h"
@interface ResortCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeDays;
@property (weak, nonatomic) IBOutlet UILabel *wayLabel;
@property (weak, nonatomic) IBOutlet UILabel *way2Label;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property(nonatomic,strong)ResortModel *model;

@end
