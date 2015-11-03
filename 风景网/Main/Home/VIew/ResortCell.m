//
//  ResortCell.m
//  风景网
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ResortCell.h"
#import "UIImageView+WebCache.h"
@implementation ResortCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(ResortModel *)model{
    
    if (_model != model) {
        _model = model;
        
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _wayLabel.layer.borderWidth = 1;
    _wayLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _wayLabel.layer.cornerRadius = 3;

    _way2Label.layer.borderWidth = 1;
    _way2Label.layer.borderColor = [UIColor whiteColor].CGColor;
    _way2Label.layer.cornerRadius = 3;

    [_bgImage sd_setImageWithURL:[NSURL URLWithString:_model.headImage]];
    
    _titleLabel.text = _model.title;
    
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.backgroundColor = [UIColor orangeColor];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@起",_model.likeCount];
    _routeDays.text = [NSString stringWithFormat:@"需要时间:%@天",_model.routeDays];
    
    
}
@end
