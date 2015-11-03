//
//  AccentModel.h
//  风景网
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface AccentModel : BaseModel

@property(nonatomic,copy)NSString *SName;//景点名称
@property(nonatomic,copy)NSString *Level;//景区等级
@property(nonatomic,copy)NSString *ListionVoiceCount;//收听人数
@property(nonatomic,copy)NSString *voice_Picture;//图片
@property(nonatomic,copy)NSString *VoiceFile;//方言音频
@property(nonatomic,copy)NSString *LocalVoiceCount;
@property(nonatomic,copy)NSString *LocalVoiceTypeCount;

//导游界面需要的数据
@property(nonatomic,copy)NSString *ScenicMes;//简介

@end
