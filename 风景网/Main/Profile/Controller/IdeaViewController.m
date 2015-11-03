//
//  IdeaViewController.m
//  风景吧
//
//  Created by Macx on 15/10/30.
//  Copyright (c) 2015年 mac... All rights reserved.
//

#import "IdeaViewController.h"
#import "Commen.h"
@interface IdeaViewController ()<UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation IdeaViewController{
    UITextField*fiel;
    UITextField*file3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatSubViews];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"意见反馈";
    [self _creatItem];
}

- (void)_creatSubViews{
    fiel = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 140)];
    fiel.layer.borderWidth = 1;
    fiel.layer.borderColor = [UIColor blueColor].CGColor;
    
    fiel.placeholder = @"欢迎您提出您的宝贵意见";
    fiel.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;

    [self.view addSubview:fiel];
    
    
    UIView*file2 = [[UIView alloc]initWithFrame:CGRectMake(10, 225-64, kScreenWidth-20, 40)];
    file2.layer.borderWidth = 1;
    file2.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:file2];
    
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 76, 20)];
    label.text = @"手机号码:";
    
    [file2 addSubview:label ];
    
    file3 = [[UITextField alloc]initWithFrame:CGRectMake(88, 10, 180, 20)];
    file3.placeholder = @"选填" ;
    [file2 addSubview:file3];
}
- (void)_creatItem{
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"d01.png"] forState:UIControlStateNormal];
    UIBarButtonItem*left = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =left;
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"loginChooseBut1.png"] forState:UIControlStateNormal];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    UIBarButtonItem*right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [rightButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    rightButton.showsTouchWhenHighlighted = YES;
    self.navigationItem.rightBarButtonItem =right;

}
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)buttonAction{
    if (fiel.text.length != 0) {
        UIAlertView*view = [[UIAlertView alloc]initWithTitle:@" 提示" message:@"提交成功，感谢您的宝贵意见!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [view show];
        
    }else if (fiel.text.length == 0){
        UIAlertView*view = [[UIAlertView alloc]initWithTitle:@" 提示" message:@"请填写反馈意见" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];

    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        fiel.text = nil;
        file3.text = nil;
        
    }
}
@end
