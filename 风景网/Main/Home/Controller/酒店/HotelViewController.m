//
//  HotelViewController.m
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HotelViewController.h"
#import "HotelDetailViewController.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"
#import "NSDate+WQCalendarLogic.h"


@interface HotelViewController (){
    
    CalendarHomeViewController *chvc;
    
}

@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}
- (IBAction)cityButton:(UIButton *)sender {
}

- (IBAction)nearHotelButton:(UIButton *)sender {
}

- (IBAction)checkInButton:(UIButton *)sender {
    
    
    [self selectday:sender];
   
}

- (IBAction)checkOutBtton:(UIButton *)sender {
    [self selectday:sender];
}

- (IBAction)searchHotelButton:(UIButton *)sender {
    [self.navigationController pushViewController:[[HotelDetailViewController alloc] init] animated:YES];
}

-(void)selectday:(UIButton *)sender{
    //选择日期
    if (!chvc) {
        
        chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"日期";
        
//        [chvc setAirPlaneToDay:365 ToDateforString:nil];//初始化方法
        [chvc setHotelToDay:365 ToDateforString:nil];
        
    }
    //block 使用弱指针，防止循环引用
    __weak HotelViewController *weakSelf = self;
    chvc.calendarblock = ^(CalendarDayModel *model){
        
//        NSLog(@"\n---------------------------");
//        NSLog(@"1星期 %@",[model getWeek]);
//        NSLog(@"2字符串 %@",[model toString]);
//        NSLog(@"3节日  %@",model.holiday);

        NSDate *date1 = [[NSDate alloc] init];
        NSDate *date2 = [[NSDate alloc] init];
//
 
//        NSString *s1 = [[NSString alloc] init];
//        NSString *s2 = [[NSString alloc] init];

//        __block NSDate *date1;
        __strong HotelViewController *strongSelf = weakSelf;
        
            if (sender.tag == 65) {
                strongSelf.checkInLable.text = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
                strongSelf.checkInLable.font = [UIFont systemFontOfSize:15];
                strongSelf.checkInLable.textColor = [UIColor blackColor];
                NSString *s1 = [model toString];
                date1 = [date1 dateFromString:s1];
//                int day = [NSDate getDayNumbertoDay:date1 beforDay:date2];
     
            }
            else
            {
                strongSelf.checkOutLable.text = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
                strongSelf.checkOutLable.font = [UIFont systemFontOfSize:15];
                strongSelf.checkOutLable.textColor = [UIColor blackColor];
                NSString *s1 = [model toString];
                date2 = [date2 dateFromString:s1];
              
                int day = [NSDate getDayNumbertoDay:date1 beforDay:date2];
                NSString *str = [NSString stringWithFormat:@"共%i晚",day];
                strongSelf.daysLable.textColor = [UIColor orangeColor];
                strongSelf.daysLable.font = [UIFont systemFontOfSize:13];
                strongSelf.daysLable.text = str;
                int day1 = [NSDate getDayNumbertoDay:date2 beforDay:date1];
                NSLog(@"day=%i",day1);
            }
    };
    
    [self.navigationController pushViewController:chvc animated:YES];
    

}

@end
