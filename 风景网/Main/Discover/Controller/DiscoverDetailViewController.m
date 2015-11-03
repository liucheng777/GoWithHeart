//
//  DiscoverDetailViewController.m
//  风景网
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DiscoverDetailViewController.h"
#import "Commen.h"
#import "RequestXML.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"

@interface DiscoverDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIScrollView *_scrollView;
    UIPageControl *_pageC;


    
}

@end

@implementation DiscoverDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self _createView];
//    [self _loadData];
}
-(void)_loadData
{
//    [RequestXML ]
}
-(void)setModel:(DiscoverModel *)model
{
    if (_model != model) {
        _model = model;
        [self _createView];
    }
}
-(void)setIndexArray:(NSString *)indexArray{
    if (_indexArray != indexArray) {
        _indexArray = indexArray;
        [self loadPic];
    }
}
-(void)loadPic{
    NSString *string2 = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"scenic\",\"Method\":\"GetScenicPicList\",\"Data\":\"%@\"}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>",_indexArray];
    _imgArrays = [[NSMutableArray alloc]init];
    [RequestXML postxml:string2 FinishBlock:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSArray *array = dic[@"Data"];
        for (NSDictionary *dicm in array) {
            [_imgArrays addObject:dicm[@"url"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _model.imagesCount =( _imgArrays.count-1 );
            [self _createView];
        });
        
    }];

}
-(void)_createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
#pragma mark - 创建头视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    
    //给tableView的头视图属性赋值
    _tableView.tableHeaderView =  view;
#pragma mark - 创建scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:view.bounds];
    //内容尺寸
    if (_imgArrays.count != 0) {
        _model.imagesCount = _imgArrays.count;
    }
    _scrollView.contentSize = CGSizeMake(kScreenWidth * _model.imagesCount, 160);

    //设置代理
    _scrollView.delegate = self;
    
    //分页效果
    _scrollView.pagingEnabled = YES;
    
    //隐藏水平方向的滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addImages];
    //头视图添加滑动视图
    [view addSubview:_scrollView];
#pragma mark - 创建PageControl
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, view.bounds.size.height - 30, kScreenWidth, 30)];
    
    //常用的属性
    _pageC.numberOfPages = _model.imagesCount;
    _pageC.backgroundColor = [UIColor clearColor];
    
    _pageC.currentPage = 0;
    _pageC.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [_pageC addTarget:self
               action:@selector(pageCon:) forControlEvents:UIControlEventValueChanged];
    
    
    [view addSubview:_pageC];
    
    
    
    [self.view addSubview:_tableView];

}
#pragma mark－为滑动视图添加图片
-(void)addImages{
    
    if (_imgArrays.count == 0) {
        
        for (int i = 1; i < _model.imagesCount; i ++) {
            [self createImage:i imageName:@"bgnodata"];
        }
    }else{
        for (int i = 0; i< _model.imagesCount; i++) {

            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i - 1) * kScreenWidth, 0, kScreenWidth, 160)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imgArrays[i]]];
            [_scrollView addSubview:imageView];
        }
    }
    

}
-(void)createImage:(int )i imageName:(NSString *)imgName{
    //循环创建图片视图，添加到scrollView上
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i - 1) * kScreenWidth + 30, 0, kScreenWidth - 60, 160)];
    
    UIImage *image = [UIImage imageNamed:imgName];
    //        image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    imageView.image = image;
    //        imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //添加子视图
    [_scrollView addSubview:imageView];
}


#pragma mark-文本自适应
-(CGRect)boundingRect:(NSString *)string{
    
    //文本高度自适应
    CGSize size=CGSizeMake(kScreenWidth-10-10, 1000);
    NSDictionary *arrtibus=@{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect frame=[string boundingRectWithSize:size
                                      options:NSStringDrawingUsesLineFragmentOrigin attributes:arrtibus
                                      context:nil];
    
    return frame;
    
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
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 1;
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
        if (indexPath.row == 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 34, 34)];
            imageView.image = [UIImage imageNamed:@"imgTicketDetail"];
            [cell.contentView addSubview:imageView];
            
            UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(44, 4, 250, 18)];
            nameLable.font = [UIFont systemFontOfSize:15];
            nameLable.text = _model.SName;
            [cell.contentView addSubview:nameLable];

            
            UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(44, 27, 33, 16)];
            lable1.textColor = [UIColor lightGrayColor];
            lable1.font = [UIFont systemFontOfSize:13];
            lable1.text = @"价格:";
            [cell.contentView addSubview:lable1];

            
            UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(85, 26, 80, 18)];
            priceLable.text = [NSString stringWithFormat:@"￥%@",_model.SalePrice];
            priceLable.font = [UIFont systemFontOfSize:15];
            priceLable.textColor = [UIColor orangeColor];
            priceLable.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:priceLable];

            
            UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(170, 27, 20, 16)];
            lable2.textColor = [UIColor lightGrayColor];
            lable2.font = [UIFont systemFontOfSize:13];
            lable2.text = @"起";
            [cell.contentView addSubview:lable2];
            
        }
        else
        {
            //开放时间
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 18)];
            lable.font = [UIFont systemFontOfSize:15];
            lable.text = @"开放时间";
            [cell.contentView addSubview:lable];
            
            //开放时间介绍
            CGRect frame = [self boundingRect:_model.PriceNotes];
            UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(5, lable.bottom +5, kScreenWidth - 10, frame.size.height + 5)];
            lable1.font = [UIFont systemFontOfSize:13];
            lable1.textColor = [UIColor grayColor];
            lable1.text = _model.PriceNotes;
            [cell.contentView addSubview:lable1];
            lable1.numberOfLines = 0;
            
            //景点地址
            UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(5, lable1.bottom + 5, kScreenWidth - 10, 18)];
            lable2.font = [UIFont systemFontOfSize:15];
            lable2.text = @"景点地址:";
            [cell.contentView addSubview:lable2];
            UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(5, lable2.bottom + 5 , kScreenWidth - 10, 18)];
            lable3.font = [UIFont systemFontOfSize:13];
            lable3.textColor = [UIColor grayColor];
            lable3.text = _model.Address;
            [cell.contentView addSubview:lable3];
            
            //景点介绍
            UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(5, lable3.bottom + 5, kScreenWidth - 10, 18)];
            lable4.font = [UIFont systemFontOfSize:15];
            lable4.text = @"景点介绍:";
            [cell.contentView addSubview:lable4];
            
            CGRect frame2 = [self boundingRect:_model.ScenicMes];
            UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(5, lable4.bottom + 5 , kScreenWidth - 10, frame2.size.height + 5)];
            lable5.font = [UIFont systemFontOfSize:13];
            lable5.textColor = [UIColor grayColor];
            lable5.text = _model.ScenicMes;
            lable5.numberOfLines = 0;
            [cell.contentView addSubview:lable5];
        }
    }
    else if(indexPath.section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 22)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkGrayColor];
        label.text = @"暂无相关票务信息";
        [cell.contentView addSubview:label];
    }
    else
    {
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        }
        else
        {
            CGRect frame = [self boundingRect:_model.PriceNotes];
            CGRect frame2 = [self boundingRect:_model.ScenicMes];
            CGFloat height = frame.size.height + frame2.size.height;
            return height + 115;
        }
    }
    return 44;
    
}

#pragma mark - 结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //获取最终的偏移量
    CGFloat offX = scrollView.contentOffset.x;
    
    
    //计算当前的页数
    NSInteger index =  offX / kScreenWidth;
    
    
    //修改pageControl的currentPage
    _pageC.currentPage = index;
    
    
}



@end
