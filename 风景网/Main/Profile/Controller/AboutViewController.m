//
//  AboutViewController.m
//  风景吧
//
//  Created by Macx on 15/10/30.
//  Copyright (c) 2015年 mac... All rights reserved.
//

#import "AboutViewController.h"
#import "Commen.h"
@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatSubViews];
    [self item];
    }
- (void)_creatSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView*sco = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    sco.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"aoutus.jpg"];
    [sco addSubview:image];
    [self.view addSubview:sco];

}
- (void)item{
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"d01.png"] forState:UIControlStateNormal];
    UIBarButtonItem*left = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =left;
}
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
