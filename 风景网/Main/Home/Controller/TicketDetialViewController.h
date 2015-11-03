//
//  TicketDetialViewController.h
//  风景网
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "DetailTicketModel.h"
@interface TicketDetialViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)DetailTicketModel *model;
@property(nonatomic,copy)UITableView *tableView;
@property(nonatomic,copy)NSString *spotName;
@end
