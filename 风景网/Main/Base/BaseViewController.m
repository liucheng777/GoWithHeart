//
//  BaseViewController.m
//  风景网
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark-导航栏图标
-(void)setNavItem{
    
    //-------------------左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 0, 34, 30);
    //设置背景 和 标题图片
    UIImage *image = [UIImage imageNamed:@"imgHomePhone.png"];
    [leftBtn setImage:image forState:UIControlStateNormal];
    //设置图片的偏移
//    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, +40)];
//    [leftBtn setTitle:@"设置" forState:UIControlStateNormal];
//    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [leftBtn addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    
    //将按钮打包，添加到导航栏上去
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
    //------------------右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    
    UIImage *imageRight = [UIImage imageNamed:@"imgScanning.png"];
    [rightBtn setImage:imageRight forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(scanningAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)setAction{
    UIWebView *web;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:0573-83032181"]]];
}
-(void)scanningAction{
    
}
#pragma mark-导航栏中心图片
-(void)setCenterImage{
    
    UIImageView *centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-71, 10, 142, 60/2)];
    centerImage.image = [UIImage imageNamed:@"imgTopLogo3.png"];

    [self.navigationController.navigationBar addSubview:centerImage];
}



@end
