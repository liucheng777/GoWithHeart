//
//  DiscoverViewController.h
//  风景网
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface DiscoverViewController : BaseViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    //4 位置管理
    CLLocationManager *_locationManager;
    UILabel *_locLabel;
}

@end
