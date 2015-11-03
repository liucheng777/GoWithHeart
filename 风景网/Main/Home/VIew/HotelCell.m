//
//  HotelCell.m
//  风景网
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HotelCell.h"
#import "UIImageView+WebCache.h"


@implementation HotelCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setModel:(HotelModel *)model
{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_hotelImageView sd_setImageWithURL:[NSURL URLWithString:_model.ImgThumb]];
    _hotelImageView.contentMode = UIViewContentModeScaleAspectFill;
    _hotelImageView.clipsToBounds = YES;
    _titleLable.text = _model.Address;
    _hotelNameLable.text = _model.Name;
    _priceLable.text = [NSString stringWithFormat:@"1%@0元起",_model.minPrice];
    _saleLable.text = [NSString stringWithFormat:@"月售:%@",_model.MonthSaleCount];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
