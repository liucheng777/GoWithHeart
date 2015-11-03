//
//  AccentCell.m
//  风景网
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AccentCell.h"
#import "UIImageView+WebCache.h"
@implementation AccentCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setAccentModel:(AccentModel *)accentModel{
    
    if (_accentModel != accentModel) {
        _accentModel = accentModel;
        
        [self setNeedsLayout];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //文本
    _name.text = _accentModel.SName;
    
    _level.text = [NSString stringWithFormat:@"国家%@等级",_accentModel.Level];
    
//    _vioceCount.text = [NSString stringWithFormat:@"来自%@位网友的%@个评价",_accentModel.LocalVoiceCount,_accentModel.LocalVoiceTypeCount];
    
    _likeCount.text = [NSString stringWithFormat:@"%@",_accentModel.ListionVoiceCount];
    
    //图片
    [_voicePic sd_setImageWithURL:[NSURL URLWithString:_accentModel.voice_Picture]];

//    _playPIc.image = [UIImage imageNamed:@"imageBtnPlayForVoice.png"];
//    _playPIc.contentMode = UIViewContentModeScaleAspectFit;
//    _SpeakPic.image = [UIImage imageNamed:@"icon_recording.png"];
//    _SpeakPic.contentMode = UIViewContentModeScaleAspectFit;
    
}

@end
