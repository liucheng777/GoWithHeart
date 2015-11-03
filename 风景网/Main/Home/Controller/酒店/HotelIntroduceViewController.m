//
//  HotelIntroduceViewController.m
//  风景网
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HotelIntroduceViewController.h"
#import "Commen.h"

@interface HotelIntroduceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIScrollView *_scrollView;
    UIPageControl *_pageC;
}

@end

@implementation HotelIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)setName:(NSString *)name
{
    _name = name;
    self.title = _name;
    [self _createView];
}
-(void)setCheckInDate:(NSString *)checkInDate
{
    _checkInDate = checkInDate;
}
-(void)setCheckOutDate:(NSString *)checkOutDate
{
    _checkOutDate = checkOutDate;
}
-(void)setAddress:(NSString *)address
{
    _address = address;
}

-(void)_createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
#pragma mark - 创建头视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    
    //给tableView的头视图属性赋值
    _tableView.tableHeaderView =  view;
#pragma mark - 创建scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:view.bounds];
    //内容尺寸
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 5, 160);
    //设置代理
    _scrollView.delegate = self;
    
    //分页效果
    _scrollView.pagingEnabled = YES;
    
    //隐藏水平方向的滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 1; i < 5; i ++) {
        //循环创建图片视图，添加到scrollView上
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i - 1) * kScreenWidth + 30, 0, kScreenWidth - 60, 160)];
        
        UIImage *image = [UIImage imageNamed:@"bgnodata"];
        //        image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        imageView.image = image;
        //        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //添加子视图
        [_scrollView addSubview:imageView];
    }
    
    //头视图添加滑动视图
    [view addSubview:_scrollView];
#pragma mark - 创建PageControl
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, view.bounds.size.height - 30, kScreenWidth, 30)];
    
    //常用的属性
    _pageC.numberOfPages = 5;
    _pageC.backgroundColor = [UIColor clearColor];
    
    _pageC.currentPage = 0;
    _pageC.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [_pageC addTarget:self
               action:@selector(pageCon:) forControlEvents:UIControlEventValueChanged];
    
    
    [view addSubview:_pageC];
    
    
    
    [self.view addSubview:_tableView];
    
}

-(void)pageCon :(UIPageControl *)sender {
    
    //    NSLog(@"%ld",sender.currentPage);
    //点击pageCoontrol时，scrollView切换到对应图片
    NSInteger index = sender.currentPage;
    
    //计算scrollView的偏移量
    CGFloat contentOffsetX = index * kScreenWidth;
    
    CGPoint Off = CGPointMake(contentOffsetX, 0);
    
    //滚动视图设置偏移量
    
    [_scrollView setContentOffset:Off animated:YES];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 5;
    }
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        if (indexPath.row ==0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 22, 24)];
            imageView.image = [UIImage imageNamed:@"detailItemImage0"];
            [cell.contentView addSubview:imageView];
            //地址
            UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 10, kScreenWidth - 50, 24)];
            lable1.text = _address;
            lable1.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:lable1];
//            //距离
//            UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 22, kScreenWidth - 50, 17)];
//            lable2.font = [UIFont systemFontOfSize:13];
//            lable2.text = ;
//            lable2.textColor = [UIColor grayColor];
        }
        else if (indexPath.row == 1)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 22, 24)];
            imageView.image = [UIImage imageNamed:@"detailItemImage1"];
            [cell.contentView addSubview:imageView];
            //地址
            UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 10, 60, 24)];
            lable1.text = @"酒店设施";
            lable1.font = [UIFont systemFontOfSize:15];
            lable1.textColor = [UIColor grayColor];
            [cell.contentView addSubview:lable1];
            for (int i = 0; i < 4; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(65 + 44 + i * 24, 7, 24, 24)];
//                UIImage imageNamed:@"introducitem20"
                if (i == 0) {
                    NSString *imageName = [NSString stringWithFormat:@"introducitem%i",i];
                    imageView.image = [UIImage imageNamed:imageName];
                }
                else
                {
                    NSString *imageName = [NSString stringWithFormat:@"introducitem2%i",i];
                    imageView.image = [UIImage imageNamed:imageName];
                }
                [cell.contentView addSubview:imageView];
            }
        }
        else if (indexPath.row == 2) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 22, 24)];
            imageView.image = [UIImage imageNamed:@"detailItemImage2"];
            [cell.contentView addSubview:imageView];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(44, 10, 200, 24)];
            if (_checkOutDate != nil) {
                
                lable.text = _checkInDate;
            }
            lable.text = @"10月30日入住";
            lable.font = [UIFont systemFontOfSize:15];
            lable.textColor = [UIColor grayColor];
            [cell.contentView addSubview:lable];
        }
        else if (indexPath.row == 3) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 22, 24)];
            imageView.image = [UIImage imageNamed:@"detailItemImage2"];
            [cell.contentView addSubview:imageView];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(44, 10, 200, 24)];
            if (_checkOutDate != nil) {

                lable.text = _checkOutDate;
            }
            else{
            lable.text = @"10月31日离店";
            lable.font = [UIFont systemFontOfSize:15];
            lable.textColor = [UIColor grayColor];
            }
            [cell.contentView addSubview:lable];
        }
        else
        {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 24)];
            lable.font = [UIFont systemFontOfSize:14];
            lable.textColor = [UIColor orangeColor];
            lable.text = @"共一晚";
            [cell.contentView addSubview:lable];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 22, 18)];
            imageView.image= [UIImage imageNamed:@"imgReview"];
            [cell.contentView addSubview:imageView];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(44, 10, 60, 22)];
            lable.text = @"评价";
            [cell.contentView addSubview:lable];
        }
        else
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, 5, kScreenWidth - 20, 34);
            [button setImage:[UIImage imageNamed:@"imgBtnWriteReview"] forState:UIControlStateNormal];
            [cell.contentView addSubview:button];
        }
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
