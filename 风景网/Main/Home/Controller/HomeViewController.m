//
//  HomeViewController.m
//  风景网
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableView.h"
#import "Commen.h"
#import "RequestXML.h"
#import "HomeModel.h"
#import "TicketViewController.h"
#import "AccentViewController.h"
#import "GuideViewController.h"
#import "HotelViewController.h"
#import "ResortViewController.h"
@interface HomeViewController (){

    HomeTableView *_tableView;
    NSMutableArray *_arrays;
    UIActivityIndicatorView *_activityView;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, kScreenHeight/2-50, 60, 60)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    _activityView.backgroundColor = [UIColor grayColor];
    _activityView.layer.cornerRadius = 10;
    [_activityView startAnimating];
    
    //主页五个button
    [self _createButton];
    //加载数据
    [self _loadData];
    //创建推送的度假tabelView
    [self _createTabelView];
    
    //拨号图片
    [self setNavItem];
    //导航栏中间视图
    [self setCenterImage];
    
}

#pragma mark-创建上面五个按钮
-(void)_createButton{
    
    CGFloat width = kScreenWidth/5;
    NSArray *buttonImages = @[@"homeTopMenuUnClick0@2x.png",@"homeTopMenuUnClick1@2x.png",@"homeTopMenuUnClick2@2x.png",@"homeTopMenuUnClick3@2x.png",@"homeTopMenuUnClick4@2x.png"];
    for (int i = 0; i<5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width+5, 5, 65, 65);
        button.tag = 100+i;
        [button setBackgroundImage:[UIImage imageNamed:buttonImages[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}
-(void)buttonAction:(UIButton *)button{
    NSInteger index = button.tag -100;
    if (index == 0) {
        NSLog(@"导游");
        GuideViewController *guide = [[GuideViewController alloc]init];
        guide.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:guide animated:YES];
    }
    if (index == 1) {
        NSLog(@"酒店");
        HotelViewController *hotel = [[HotelViewController alloc]init];
        hotel.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hotel animated:YES];
    }
    if (index == 2) {
        NSLog(@"度假");
        ResortViewController *resort = [[ResortViewController alloc]init];
        resort.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:resort animated:YES];
    }
    if (index == 3) {
        NSLog(@"门票");
        TicketViewController *tiket = [[TicketViewController alloc]init];
        tiket.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tiket animated:YES];
    }
    if (index == 4) {
        NSLog(@"最美乡音");
        AccentViewController *accent = [[AccentViewController alloc]init];
        accent.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:accent animated:YES];
    }
}
#pragma mark- 创建tableView
-(void)_createTabelView{
    
    _tableView = [[HomeTableView alloc]initWithFrame:CGRectMake(0, 5+65, kScreenWidth, kScreenHeight-70) style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];
    
}

#pragma mark-加载数据
-(void)_loadData{
   
    _arrays = [[NSMutableArray alloc]init];
        
    [RequestXML postxml:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"tongcheng\",\"Method\":\"getabroadlinehot\",\"Data\":{\"PageIndex\":1,\"PageSize\":20,\"RecordCount\":0,\"Orderby\":null,\"QueryDict\":null,\"Query\":[]}}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>" FinishBlock:^(NSDictionary *dic) {
            
        NSLog(@"+++++_______%@",dic);
        
        NSMutableArray *data = [[NSMutableArray alloc]init];
        
        data = dic[@"Data"];
        
        for (NSDictionary *dicm in data) {
            
            HomeModel *model = [[HomeModel alloc]initWithDataDic:dicm];
            
            [_arrays addObject:model];
        }
        _tableView.array = _arrays;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [_activityView stopAnimating];
        });
        
    }];



    
}

@end
