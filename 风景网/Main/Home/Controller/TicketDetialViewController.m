//
//  TicketDetialViewController.m
//  风景网
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TicketDetialViewController.h"
#import "Commen.h"
#import "ReadData.h"

@interface TicketDetialViewController (){
    NSMutableArray *_arrayAll;
    CGRect _abstractFrame;
}

@end

@implementation TicketDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    self.title = _model.name;
    
    [self createTableView];
}
-(void)loadData{
    NSString *httpUrl = @"http://apis.baidu.com/apistore/attractions/spot";
    NSString *st = _spotName;
    
    NSString *newString = [self transformToSelecte:st];
    //拼接？后面的字符串
    NSString *httpArg = [NSString stringWithFormat:@"id=%@&output=json",newString];
    
    //网络请求
    [ReadData request:httpUrl withHttpArg:httpArg completionHandle:^(id result) {

        NSDictionary *result2 = result[@"result"];
        
        _model = [[DetailTicketModel alloc]initWithDataDic:result2];
        
        [_tableView reloadData];

        
    } errorhandle:^(NSError *error) {
        NSLog(@"读取错误");
    }];

}
-(NSString *)transformToSelecte:(NSString *)city{
    //把汉字转换成拼音，供搜索。
    Boolean CFStringTransform(CFMutableStringRef string, CFRange *range, CFStringRef transform, Boolean reverse);
    NSString *st = city;
    CFStringRef cfstring1 = (__bridge CFStringRef)st;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, cfstring1);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *str = (__bridge NSString *)(string);
    NSString *newString = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    CFRelease(string);
    return newString;
}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailCell"];
    }
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor lightGrayColor];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-80, 100, 60, 60)];
        image.image = [UIImage imageNamed:@"hotelUnCollect"];
        [cell.contentView addSubview:image];
        
        UILabel *star = [[UILabel alloc]initWithFrame:CGRectMake(15, 6, 30, 30)];
        star.text = _model.star;
        star.textAlignment = NSTextAlignmentCenter;
        star.textColor = [UIColor whiteColor];
        [image addSubview:star];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-80, 165, 60, 30)];
        label.text = @"供12张";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:label];
        
    }
    if (indexPath.row == 1) {
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        image.image = [UIImage imageNamed:@"imgTicketDetail"];
        [cell.contentView addSubview:image];
        
        UIButton  *urlButton = [UIButton buttonWithType:UIButtonTypeCustom];
        urlButton.frame = CGRectMake(kScreenWidth-100, 10,80, 40);
        [urlButton setBackgroundImage:[UIImage imageNamed:@"loginChooseBut1"] forState:UIControlStateNormal];
        [urlButton setTitle:@"查看网页" forState:UIControlStateNormal];
        [urlButton addTarget:self action:@selector(gotoUrlAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:urlButton];
        
        
        
    }
    if (indexPath.row == 2) {
        

        if (_model != nil) {
            
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[_model.ticket_info allValues]];
            
            NSString *string = [NSString string];
            
            if(array.count == 2){
                string = [NSString stringWithFormat:@"%@ %@",array[0],array[1]];

            }else if (array.count == 3) {
                NSArray *des = array[2];
                NSDictionary *dic = des[0];
                NSString *str0 = dic[@"name"];

                NSString *str1 = dic[@"description"];
                
                string = [NSString stringWithFormat:@"%@ %@ %@ %@",array[0],array[1],str0,str1];

            }
            
            NSLog(@"?????????????%@",string);
            _abstractFrame = [self boundingRect:string];
            UILabel *abstract = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth-10, _abstractFrame.size.height+20)];
            abstract.numberOfLines = 0;
            abstract.text = string;
            [cell.contentView addSubview:abstract];
        }
        

       
        
        

    
        
    }
    
    return cell;
}

-(void)gotoUrlAction:(UIButton *)btn{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200;
    }
    if (indexPath.row == 1) {
        return 60;
    }
    return _abstractFrame.size.height + 40;
}
#pragma mark-文本自适应
-(CGRect)boundingRect:(NSString *)string{
    
    NSLog(@"总的输出应该是这样的>>%@",string);
    //文本高度自适应
    CGSize size=CGSizeMake(210, 1000);
    NSDictionary *arrtibus=@{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect frame=[string boundingRectWithSize:size
                                              options:NSStringDrawingUsesLineFragmentOrigin attributes:arrtibus
                                              context:nil];
    
    return frame;

}
@end
