//
//  HolidayViewController.m
//  风景网
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HolidayViewController.h"
#import "Commen.h"
#import "UIImageView+WebCache.h"
#import "DetailView.h"
@interface HolidayViewController (){
    
    UIActivityIndicatorView *_activityView;
    //头视图
    UIView *_theTableHeaderView;
    DetailView *_detailView;
    CGRect _size;
}

@end

@implementation HolidayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, kScreenHeight/2-50, 60, 60)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    _activityView.backgroundColor = [UIColor grayColor];
    _activityView.layer.cornerRadius = 10;
    [_activityView startAnimating];
    [self.view addSubview:_activityView];
}
-(void)setModel:(HomeModel *)model{
    if (_model != model) {
        _model = model;

        [self _creatHeaderView];
        [self createTableView];
        [_activityView stopAnimating];

    }
}
#pragma mark- 创建tableView的头视图
- (void)_creatHeaderView{
    
    _theTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.img]];
    [_theTableHeaderView addSubview:imageView];
    
}
#pragma mark- 创建tableView
-(void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = _theTableHeaderView;
    [self.view addSubview:_tableView];
    
}
#pragma mark-tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.routelist.count + 2;
    
}

-(UIView *)numberOfRowsInOne{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 30)];
    label.text = @"详细信息";
    label.font = [UIFont systemFontOfSize:14 weight:3];
    [headerView addSubview:label];
    
    NSInteger days = [_model.C_days integerValue];
    
    CGFloat width = (kScreenWidth-40)/days;
    
    UIView *dayView = [[UIView alloc]initWithFrame:CGRectMake(0,0 ,126*days+8, 25)];
    dayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imgTripStart"]];
    CGAffineTransform transform = CGAffineTransformMakeScale((width*days)/(126*days+8), 0.8);

    //日期label
    for (int i = 0; i <= days; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(18+i*width-4, 70, 18, 18)];
        label.text = [NSString stringWithFormat:@"%d",i+1];
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.layer.cornerRadius = 9;
        label.layer.borderColor = [UIColor redColor].CGColor;
        label.layer.borderWidth = 1;
        [headerView addSubview:label];
        
        
    }
    dayView.transform = transform;
    dayView.center = CGPointMake(kScreenWidth/2, 50);
    [headerView addSubview:dayView];
    
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"holiday"];
    //每次清空
    cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"holiday"];
    }
    if (indexPath.row == 0) {
        
        _detailView = [[[NSBundle mainBundle] loadNibNamed:@"DetailView" owner:self options:nil] lastObject];
        _detailView.model = _model;
        _detailView.layer.borderWidth = 1;
        _detailView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _detailView.frame = CGRectMake(0, 0, kScreenWidth, 45);
        [cell.contentView addSubview:_detailView];


    }else if(indexPath.row == 1){
        
        UIView *view = [self numberOfRowsInOne];
        [cell.contentView addSubview:view];
        
    }else{
        //创建左侧上方图标
        UIImageView *imageViewLeft = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
        imageViewLeft.image = [UIImage imageNamed:@"imgTripIcon0"];
        [cell.contentView addSubview:imageViewLeft];
        
        //调用文本自适应
        NSInteger index = indexPath.row - 2;
        NSDictionary *dicm = _model.routelist[index];
        NSString *string = dicm[@"description"];
        _size = [self boundingRect:string];
        
        //创建左侧竹杠图片
        UIImageView *imageViewLeft2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,30 , 10, _size.size.height+20)];
        imageViewLeft2.image = [UIImage imageNamed:@"CalendarBackground"];
        [cell.contentView addSubview:imageViewLeft2];
        
        //创建标题文本
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(55, 5, kScreenWidth-90, 40)];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imgDescTextBackGround"]];
        label.text = [NSString stringWithFormat:@"day%ld %@",(long)index+1,dicm[@"traffic"]];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        //文本内容
        UILabel *labelText = [[UILabel alloc]initWithFrame:CGRectMake(65, 45, kScreenWidth-90-5, _size.size.height+20)];
        labelText.text = dicm[@"description"];
        labelText.font = [UIFont systemFontOfSize:13];
        labelText.numberOfLines = 0;
        labelText.backgroundColor = [UIColor lightTextColor];
        [cell.contentView addSubview:labelText];
    
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        return 100;
    }else if (indexPath.row == 1) {
        return 100;
    }
    return _size.size.height+60;
}

#pragma mark-文本自适应
-(CGRect)boundingRect:(NSString *)string{
    
    NSLog(@"总的输出应该是这样的>>%@",string);
    //文本高度自适应
    CGSize size=CGSizeMake(kScreenWidth-90-10, 1000);
    NSDictionary *arrtibus=@{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect frame=[string boundingRectWithSize:size
                                      options:NSStringDrawingUsesLineFragmentOrigin attributes:arrtibus
                                      context:nil];
    
    return frame;
    
}
@end
