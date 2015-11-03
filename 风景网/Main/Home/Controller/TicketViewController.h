//
//  TicketViewController.h
//  风景网
//
//  Created by mac on 15/10/18.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface TicketViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *selectTextFile;
- (IBAction)searchAction:(UIButton *)sender;


@end
