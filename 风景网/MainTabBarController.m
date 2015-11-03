//
//  MainTabBarController.m
//  风景网
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavController.h"
#import "Commen.h"

@interface MainTabBarController (){
    BOOL isSelect[5];
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _createSubCotrollers];
    
    [self _createTabBar];
    
    
}

-(void)_createSubCotrollers{
    
    NSArray *names = @[@"Discover",@"Home",@"Profile"];
    
    NSMutableArray *navArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    for (int i = 0; i < names.count; i++) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:names[i] bundle:nil];
        BaseNavController *nav = [sb instantiateInitialViewController];
        [navArray addObject:nav];
        
    }
    
    self.viewControllers = navArray;
    
}

-(void)_createTabBar{
//    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    //移除tabBarButton
    for (UIView *view in self.tabBar.subviews) {
        
        //通过字符串获得类对象
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            [view removeFromSuperview];
        }
        
        CGFloat width = kScreenWidth/3;
        NSArray *picArray = @[@"tabbarimgClicked0.png",@"tabbarimgClicked2.png",@"tabbarimgClicked3.png"];
        //NSArray *selectetArray = @[@"tabbarimgClicked0.png",@"tabbarimgClicked1.png",@"tabbarimgClicked2.png",@"tabbarimgClicked3.png",@"tabbarimgClicked4.png"];
        for(int i = 0;i<picArray.count;i++){
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*width, 0, width, 52);
            btn.tag = i+1;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-40, 0, 80, 49)];
            imageView.image = [UIImage imageNamed:picArray[i]];
            [btn addSubview:imageView];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            //[btn setImage:[UIImage imageNamed:picArray[i]] forState:UIControlStateNormal];

            //[btn setImage:[UIImage imageNamed:selectetArray[i]] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.tabBar addSubview:btn];
            
        }
        
    }
    
}
-(void)selectedAction:(UIButton *)button{

    NSInteger index = button.tag-1;
    self.selectedIndex = index;
 

}

@end
