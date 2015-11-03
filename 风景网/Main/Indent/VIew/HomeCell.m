//
//  HomeCell.m
//  风景网
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"
@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(HomeModel *)model{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_img sd_setImageWithURL:[NSURL URLWithString:_model.img]];
    
    _title.text = _model.title;
    
    _subTitle.text = _model.subTitle;
    
    _favoriteCount.text =[NSString stringWithFormat:@"%@", _model.FavoriteCount ];
    
    _startCity.text = _model.startCity;
    
    _days.text = [NSString stringWithFormat:@"%@days",_model.C_days];
    
    _minPrice.text = [NSString stringWithFormat:@"¥%@",_model.minPrice];
    if (_model.C_DateEnd == nil) {
        _data.text = _model.C_DateBeg;
    }else if(_model.C_DateEnd != nil){
    _data.text = [NSString stringWithFormat:@"%@-%@",_model.C_DateBeg,_model.C_DateEnd];
    }

    
}


@end
