//
//  TicketViewController.m
//  风景网
//
//  Created by mac on 15/10/18.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TicketViewController.h"
#import "Commen.h"
#import "RequestXML.h"
#import "UIView+UIViewController.h"
#import "UIImageView+WebCache.h"
#import "TicketDetialViewController.h"
#import "DiscoverModel.h"
#import "DiscoverDetailViewController.h"
@interface TicketViewController ()
{
    
    NSMutableArray *_imgArrays;//存放推送的门票景点图片
    NSMutableArray *_titleArrays;//存放推送门票的名称
    NSMutableArray *_idArrays;//存放景点id
    UICollectionView *_cityCollectionView;

    
}

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self _createCollectionView];

    [self createButton];
}
-(void)viewDidAppear:(BOOL)animated{
    [self loadData];
}
-(void)loadData{
    
    _imgArrays = [[NSMutableArray alloc]init];
    _titleArrays = [[NSMutableArray alloc]init];
    _idArrays = [[NSMutableArray alloc]init];
    [RequestXML postxml:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"scenic\",\"Method\":\"GetTicketHome\",\"Data\":\"杭州\"}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>" FinishBlock:^(NSDictionary *dic) {
     
        NSLog(@"%@",dic);
        NSDictionary *data = dic[@"Data"];
        NSArray *hotsceniclist = data[@"hotsceniclist"];
        for (NSDictionary *dicm in hotsceniclist) {
            [_idArrays addObject:dicm[@"ScSpId"]];
            [_imgArrays addObject:dicm[@"ImageUrl"]];
            [_titleArrays addObject:dicm[@"Title"]];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{

            [_cityCollectionView reloadData];
        });
     }];
    
    
}


#pragma mark-创建button
-(void)createButton{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-75, 255-64, 150, 40)];
    label.text = @"全国热门景区";
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18 weight:2];
    [self.view addSubview:label];
    

    
}

-(void)_createCollectionView{
    
    //创建布局对象
    UICollectionViewFlowLayout *cityLayout = [[UICollectionViewFlowLayout alloc] init];
    cityLayout.minimumLineSpacing = 10;
    cityLayout.minimumInteritemSpacing = 10;
    cityLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    CGFloat itemWidth = (kScreenWidth  - 10 * 4) / 3;
    cityLayout.itemSize = CGSizeMake(itemWidth, itemWidth-20);
    // 创建collectionView
    _cityCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300-64, kScreenWidth, (itemWidth-20)*3+10*4) collectionViewLayout:cityLayout];
    [self.view addSubview:_cityCollectionView];
    _cityCollectionView.backgroundColor = [UIColor whiteColor];
    _cityCollectionView.dataSource = self;
    _cityCollectionView.delegate = self;
    // 注册单元格
    [_cityCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];


}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_imgArrays.count != 0) {
        return _imgArrays.count;
    }
    return 9;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.layer.cornerRadius = 4;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    if(cell.contentView.subviews != 0){
        
        for (UIView *view in [cell.contentView subviews]) {
            [view removeFromSuperview];
        }

    }
    //label
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height-20, cell.bounds.size.width, 20)];
    //背景图片
    UIImageView *image = [[UIImageView alloc]initWithFrame:cell.bounds];
    if (_imgArrays.count == 0) {
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:cell.bounds];
        image.image = [UIImage imageNamed:@"iconLogin"];
        cell.backgroundView = image;
        
    }else{
        NSString *str = _imgArrays[indexPath.row];
        [image sd_setImageWithURL:[NSURL URLWithString:str]];
        cell.clipsToBounds = YES;
        cell.backgroundView = image;
        //景点名称label
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.backgroundColor = [UIColor blackColor];
        lable.alpha = 0.6;
        lable.text = _titleArrays[indexPath.row];
        [cell.contentView addSubview:lable];

    }
    
    return cell;
}



#pragma mark - 单元格的选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DiscoverDetailViewController *discoverDVC = [[DiscoverDetailViewController alloc]init];
    
    NSString  *indexArray =_idArrays[indexPath.item];
    
    //请求网络
    NSString *string = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"scenic\",\"Method\":\"getscenicofsingle\",\"Data\":{\"scenicId\":\"%@\",\"comments\":\"5\",\"CommentType\":\"1\",\"userId\":\"\"}}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>",indexArray];
    
    
    NSLog(@"%@",string);
    
    [RequestXML postxml:string FinishBlock:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSDictionary *data = dic[@"Data"];
       
        DiscoverModel *discoverModel = [[DiscoverModel alloc]initWithDataDic:data];
        discoverDVC.model = discoverModel;
        discoverDVC.indexArray = indexArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [discoverDVC.tableView reloadData];
            
        });
        
    }];


    [self.navigationController pushViewController:discoverDVC animated:YES];

}
//-(NSString *)transformToSelecte:(NSString *)city{
//    //把汉字转换成拼音，供搜索。
//    Boolean CFStringTransform(CFMutableStringRef string, CFRange *range, CFStringRef transform, Boolean reverse);
//    NSString *st = city;
//    CFStringRef cfstring1 = (__bridge CFStringRef)st;
//    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, cfstring1);
//    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
//    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
//    NSString *str = (__bridge NSString *)(string);
//    NSString *newString = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//    CFRelease(string);
//    return newString;
//}



- (IBAction)searchAction:(UIButton *)sender {

    TicketDetialViewController *detail = [[TicketDetialViewController alloc]init];
    detail.spotName = _selectTextFile.text;
    [self.navigationController pushViewController:detail animated:YES];
    _selectTextFile.text = nil;

}

@end
