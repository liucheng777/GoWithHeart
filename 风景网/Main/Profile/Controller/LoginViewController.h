//
//  LoginViewController.h
//  风景网
//
//  Created by mac on 15/10/30.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *nameL;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)LoginAction:(UIButton *)sender;

@end
