//
//  AccentCell.h
//  风景网
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccentModel.h"
@interface AccentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *level;
//@property (weak, nonatomic) IBOutlet UILabel *vioceCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIImageView *voicePic;
//@property (weak, nonatomic) IBOutlet UIImageView *playPIc;
//@property (weak, nonatomic) IBOutlet UIImageView *SpeakPic;

@property(nonatomic,strong)AccentModel *accentModel;


@end
