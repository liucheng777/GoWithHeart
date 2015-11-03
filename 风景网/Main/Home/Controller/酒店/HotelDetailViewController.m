//
//  HotelDetailViewController.m
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "RequestXML.h"
#import "HotelModel.h"
#import "Commen.h"
#import "HotelModel.h"
#import "HotelCell.h"
#import "HotelIntroduceViewController.h"

@interface HotelDetailViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_data;
    HotelIntroduceViewController *vc;
}

@end

@implementation HotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self _loadData];
    [self _createView];
}
-(void)_createView
{
    vc = [[HotelIntroduceViewController alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    UINib *nib = [UINib nibWithNibName:@"HotelCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"HotelCell"];
    
}
-(void)_loadData
{
    [RequestXML postxml:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"hotel\",\"Method\":\"gethotellist\",\"Data\":{\"PageIndex\":1,\"PageSize\":20,\"RecordCount\":0,\"Orderby\":{\"minPrice\":\"\"},\"QueryDict\":{\"Lat\":\"\",\"Lon\":\"\",\"Dist\":\"\",\"Comments\":\"3\",\"citycode\":\"\",\"keyword\":\"\",\"cityname\":\"杭州\",\"districtsid\":\"\",\"PriceAreaId\":\"\",\"BrandId\":\"\",\"starrate\":\"\"},\"Query\":[]}}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>" FinishBlock:^(NSDictionary *dic) {
    
        NSLog(@"%@",dic);
        NSArray *Data= dic[@"Data"];
        NSLog(@"%@",Data);
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *dataDic in Data) {
            
            HotelModel *model = [[HotelModel alloc] initWithDataDic:dataDic];
            [_data addObject:model];
//            NSLog(@"====%@",model);
//            [_tableView reloadData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    }];

    
}

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
    HotelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
    if (_data == nil) {
        cell.imageView.image = [UIImage imageNamed:@"imgTicketDetail"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.imageView.clipsToBounds = YES;
        return cell;
    }
    
    HotelModel *model = _data[indexPath.row];
    cell.model = model;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HotelModel *model = _data[indexPath.row];
    vc.name = model.Name;
    vc.address = model.Address;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
