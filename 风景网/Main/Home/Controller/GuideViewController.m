//
//  GuideViewController.m
//  风景网
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "GuideViewController.h"
#import "RequestXML.h"
#import "AccentModel.h"
#import "AccentCell.h"
@interface GuideViewController (){

    NSMutableArray *_dataArrays;
    UITableView *_tableView;
    CGRect _size;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self loadData];
    [self createTableView];
}
#pragma mark-创建tableView
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //注册
    UINib *nib = [UINib nibWithNibName:@"AccentCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"AccentCell"];
    
    [self.view addSubview:_tableView];
    
}
-(void)loadData{
    _dataArrays = [[NSMutableArray alloc]init];
    [RequestXML postxml:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"scenic\",\"Method\":\"getsceniclistofcity\",\"Data\":{\"PageIndex\":\"1\",\"PageSize\":\"20\",\"RecordCount\":0,\"Orderby\":{},\"QueryDict\":{\"key\":\"杭州\",\"voice\":\"1\",\"comments\":\"5\",\"Lat\":\"\",\"Lon\":\"\"},\"Query\":[]}}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>" FinishBlock:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        NSArray *data = dic[@"Data"];
        for (NSDictionary *dicm in data) {
            AccentModel *accentModel = [[AccentModel alloc]initWithDataDic:dicm];
            [_dataArrays addObject:accentModel];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
}
#pragma mark - UITabelView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_dataArrays.count != 0) {
        return _dataArrays.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccentCell *cell = (AccentCell *)[tableView dequeueReusableCellWithIdentifier:@"AccentCell" forIndexPath:indexPath];
    if (_dataArrays.count != 0) {
        AccentModel *accentModel = _dataArrays[indexPath.row];
        cell.accentModel = accentModel;
        
        
        //创建下面的label
        UILabel *voiceCount = [[UILabel alloc]initWithFrame:CGRectMake(134, 45+30, 230,40)];
        voiceCount.text =[NSString stringWithFormat:@"       %@",accentModel.ScenicMes];
        voiceCount.numberOfLines = 0;
        voiceCount.font = [UIFont systemFontOfSize:13];
        voiceCount.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:voiceCount];
    }
    
    //两个button是不一样的，所以在这里单独创建
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setBackgroundImage:[UIImage imageNamed:@"voiceListPlayPic"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    playButton.frame = CGRectMake(134, 45, 65, 30);
    [cell.contentView addSubview:playButton];
    
    UIButton *rimButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rimButton setBackgroundImage:[UIImage imageNamed:@"voiceListNearbyPic"] forState:UIControlStateNormal];
    [rimButton addTarget:self action:@selector(rimAction:) forControlEvents:UIControlEventTouchUpInside];
    rimButton.frame = CGRectMake(134+65+30, 45, 65, 30);
    [cell.contentView addSubview:rimButton];

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
#pragma mark - button方法
-(void)playAction:(UIButton *)btn{
    //播放
}
-(void)rimAction:(UIButton *)btn{
    //周边
}

@end
