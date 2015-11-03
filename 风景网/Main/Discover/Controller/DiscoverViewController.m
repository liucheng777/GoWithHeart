//
//  DiscoverViewController.m
//  风景网
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Commen.h"
#import "CCLocationManager.h"
#import "RequestXML.h"
#import "DiscoverModel.h"
#import "DiscoverCell.h"
#import "DiscoverDetailViewController.h"


#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
@interface DiscoverViewController ()<CLLocationManagerDelegate>{
    CLLocationManager *locationmanager;
    UITableView *_tableView;
    NSMutableArray *_data;
    UIActivityIndicatorView *_activityView;
    
}

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, kScreenHeight/2-50, 60, 60)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    _activityView.backgroundColor = [UIColor grayColor];
    _activityView.layer.cornerRadius = 10;
    [_activityView startAnimating];
    
    [self _loadData];
    [self _createView];
    [self _loaction];
    [_activityView stopAnimating];
}
-(void)_loadData
{
    [RequestXML postxml:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"scenic\",\"Method\":\"discover\",\"Data\":{\"PageIndex\":1,\"PageSize\":20,\"RecordCount\":0,\"Orderby\":{\"ScenicId\":\"\"},\"QueryDict\":{\"Dist\":\"20\",\"Lat\":\"30.322\",\"Lon\":\"120.347\",\"cityName\":\"杭州\"},\"Query\":[]}}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>" FinishBlock:^(NSDictionary *dic) {
        
//        NSLog(@"%@",dic);
        NSArray *Data= dic[@"Data"];
//        NSLog(@"%@",Data);
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *dataDic in Data) {
            DiscoverModel *model = [[DiscoverModel alloc] initWithDataDic:dataDic];
            model.imagesCount = (arc4random() % 5 + 5);
            [_data addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    }];
    
    
}

-(void)_createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 30) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _locLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    _locLabel.hidden = YES;
    _locLabel.font = [UIFont systemFontOfSize:14];
    _locLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_tableView];
    [self.view addSubview:_locLabel];
    UINib *nib = [UINib nibWithNibName:@"DiscoverCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"DiscoverCell"];
}
-(void)_loaction
{

    if (IS_IOS8) {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        locationmanager = [[CLLocationManager alloc] init];
        [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        locationmanager.delegate = self;
    }
    
    
    [self getCity];
}

-(void)getCity
{
    __block NSString *string;
//    if (IS_IOS8) {
//        
//        [[CCLocationManager shareLocation]getCity:^(NSString *cityString) {
//            NSLog(@"%@",cityString);
//            string = [NSString stringWithFormat:@"%@",cityString];
//            _locLabel.text = string;
//        }];
//        
//    }
    if (IS_IOS8) {
        
        [[CCLocationManager shareLocation]getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
//            string = [NSString stringWithFormat:@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude];
        } withAddress:^(NSString *addressString) {
            NSLog(@"%@",addressString);
            string = [NSString stringWithFormat:@"您现在的位置: %@",addressString];
            _locLabel.text = string;
            _locLabel.hidden = NO;

            
        }];
    }
    
}
#pragma tableView代理协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return _data.count;
    if (_data.count != 0) {
        return _data.count;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell" forIndexPath:indexPath];
    if (_data == nil) {

//        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        cell.imageView.clipsToBounds = YES;
        return cell;
    }
    
    DiscoverModel *model = _data[indexPath.row];
    cell.model = model;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverDetailViewController *vc = [[DiscoverDetailViewController alloc] init];
    DiscoverModel *model = _data[indexPath.row];
    vc.model = model;
    [vc.navigationItem setTitle:model.SName];

    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
////    NSLog(@"位置已经更新");
//    [_locationManager stopUpdatingLocation];
//    CLLocation *location = [locations lastObject];
//    CLLocationCoordinate2D coordinate = location.coordinate;
//    
//    NSLog(@"经度 = %lf 纬度 = %lf",coordinate.longitude,coordinate.latitude);
//    
////    二 iOS内置
//    CLGeocoder  *geoCoder = [[CLGeocoder alloc] init];
//    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        CLPlacemark *place = [placemarks lastObject];
//        
//        NSLog(@"%@",place.name);
//        NSLog(@"%@",place.areasOfInterest);
//        _locLabel.text = place.name;
//        _locLabel.hidden = NO;
//        }];
//
//    
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
