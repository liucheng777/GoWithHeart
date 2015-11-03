//
//  DiscoverCell.m
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DiscoverCell.h"
#import "UIImageView+WebCache.h"

@implementation DiscoverCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setModel:(DiscoverModel *)model
{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    

//    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text09"]]];
    
    if (_model != nil) {
        
        [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_model.voice_Picture]];
        _nameLable.text = _model.SName;
        _addressLable.text = _model.Address;
        _priceLable.text = [NSString stringWithFormat:@"售价：￥%@",_model.SalePrice];
    }
    else
    {
        
        _bigImageView.image = [UIImage imageNamed:@"imgTopLogo3"];
        _nameLable.text = @"...";
        _addressLable.text = @"...";
        _priceLable.text = @"...";
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
