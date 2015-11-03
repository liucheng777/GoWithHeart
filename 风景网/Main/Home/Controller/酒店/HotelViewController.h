//
//  HotelViewController.h
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface HotelViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *nearHotelButton;
@property (weak, nonatomic) IBOutlet UIButton *checkInButton;
@property (weak, nonatomic) IBOutlet UIButton *checkOutButton;
@property (weak, nonatomic) IBOutlet UILabel *checkInLable;
@property (weak, nonatomic) IBOutlet UILabel *checkOutLable;
@property (weak, nonatomic) IBOutlet UILabel *daysLable;


- (IBAction)cityButton:(UIButton *)sender;
- (IBAction)nearHotelButton:(UIButton *)sender;
- (IBAction)checkInButton:(UIButton *)sender;
- (IBAction)checkOutBtton:(UIButton *)sender;

- (IBAction)searchHotelButton:(UIButton *)sender;



@end
