//
//  ResortViewController.m
//  风景网
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ResortViewController.h"
#import "ReadData.h"
#import "ResortModel.h"
#import "ResortCell.h"
#import "WebViewController.h"
@interface ResortViewController (){
    NSMutableArray *_array;
    UITableView *_tableView;
}

@end

@implementation ResortViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    
    [self createTableView];
}
-(void)loadData
{
    
    
    NSString *httpUrl = @"http://apis.baidu.com/qunartravel/travellist/travellist";
    NSString *httpArg = @"query=%22%22&page=1";
    _array = [[NSMutableArray alloc]init];
    [ReadData request:httpUrl withHttpArg:httpArg completionHandle:^(id result) {
        NSLog(@"注册成功:%@",result);
        
        NSDictionary *data = result[@"data"];
        NSDictionary *books = data[@"books"];
        
        for (NSDictionary *dicm in books) {
            ResortModel *resortModel = [[ResortModel alloc]initWithDataDic:dicm];
            [_array addObject:resortModel];
        }
        [_tableView reloadData];
        
    } errorhandle:^(NSError * error) {
        NSLog(@"出错了%@",error);
    }];
    
}

-(void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    UINib *nib = [UINib nibWithNibName:@"ResortCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"ResortCell"];
}
#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_array.count != 0) {
        return _array.count;
    }
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResortCell *cell = (ResortCell *)[tableView dequeueReusableCellWithIdentifier:@"ResortCell" forIndexPath:indexPath];
    if (_array.count != 0) {
        
        ResortModel *model = _array[indexPath.row];
        
        cell.model = model;
    }
    
    return cell;
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200+10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController *web = [[WebViewController alloc]init];
    
    ResortModel *model = _array[indexPath.row];
    
    web.urlString = model.bookUrl;
    
    [self.navigationController pushViewController:web animated:YES];
    
}


@end
