//
//  DiscoverDetailViewController.h
//  风景网
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DiscoverModel.h"

@interface DiscoverDetailViewController : BaseViewController

@property(nonatomic,strong) DiscoverModel *model;
@property(nonatomic,copy)NSMutableArray *imgArrays;
@property(nonatomic,copy)UITableView *tableView;
@property(nonatomic,copy)NSString  *indexArray;
@end
