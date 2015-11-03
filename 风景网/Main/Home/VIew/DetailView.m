//
//  DetailView.m
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

-(void)setModel:(HomeModel *)model{
    
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _messageLabel.text = [NSString stringWithFormat:@"%@ %@",_model.title,_model.subTitle];
    NSLog(@"%@",_messageLabel);
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.minPrice];


}

@end
