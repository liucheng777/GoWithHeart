//
//  LoginViewController.m
//  风景网
//
//  Created by mac on 15/10/30.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "RequestXML.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)LoginAction:(UIButton *)sender {
    
    NSString *string = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RequestServiceData xmlns=\"http://tempuri.org/\"><requestMessage>{\"RCode\":\"fengjing@#*!2014\",\"ClientType\":0,\"Module\":\"system\",\"Method\":\"UserLogin\",\"Data\":{\"userName\":\"%@\",\"password\":\"%@\"}}</requestMessage></RequestServiceData></soap:Body></soap:Envelope>",_nameL,_passWord];
    
    [RequestXML postxml:string FinishBlock:^(NSDictionary *dic) {
       
        NSLog(@"%@",dic);
    }];
    
}
@end
