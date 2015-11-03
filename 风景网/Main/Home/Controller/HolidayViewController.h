//
//  HolidayViewController.h
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HolidayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HomeModel *model;
@property(nonatomic,copy)UITableView *tableView;
@end
