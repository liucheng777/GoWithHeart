//
//  HomeTableView.m
//  风景网
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "Commen.h"
#import "HolidayViewController.h"
#import "UIView+UIViewController.h"
#import "RequestXML.h"
#import "DetailView.h"
@implementation HomeTableView

-(instancetype )initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        //注册
        UINib *nib = [UINib nibWithNibName:@"HomeCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"HomeCell"];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_array.count == 0) {
        return 10;
    }
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    imageView.image = [UIImage imageNamed:@"imgTableCellWithLine"];
    imageView.contentMode = UIViewContentModeRedraw;
    cell.backgroundView = imageView;
    
    if (_array.count != 0) {
        
        HomeModel *model = _array[indexPath.row];
        cell.model = model;
    }else{

        
        
    }
    
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 210;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeModel *model = _array[indexPath.item];
    HolidayViewController *holiday = [[HolidayViewController alloc]init];
    NSString *string = [NSString string];
    string = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"tongcheng\",\"Method\":\"GetAbroadLineInfo\",\"Data\":{\"lineId\":\"%@\",\"comments\":\"5\"}}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>",model.lineId];
    //网络请求选中的数据
    [RequestXML postxml:string FinishBlock:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        NSDictionary *data = dic[@"Data"];
        HomeModel *homeModel = [[HomeModel alloc]initWithDataDic:data];
        holiday.model = homeModel;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [holiday.tableView reloadData];
        });
    }];

    holiday.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:holiday animated:YES];

}
@end
