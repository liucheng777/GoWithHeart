//
//  ProfileViewController.m
//  风景网
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "Commen.h"
#import "IdeaViewController.h"
#import "AboutViewController.h"
@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ProfileViewController
{
    UILabel*cachlabel;
    UITableView*tabView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.9];
    ;
    [self creatTabView];
}
#pragma mark-创建tableView
- (void)creatTabView{
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tabView.dataSource = self;
    tabView.delegate = self;
    //    tabView.userInteractionEnabled = NO;
    tabView.showsHorizontalScrollIndicator = NO;
    tabView.showsVerticalScrollIndicator = NO;
    tabView.backgroundColor = [UIColor colorWithWhite:0.90 alpha:0.9];
    [self.view addSubview:tabView];
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 2) {
        
        UILabel*label2 = [[UILabel alloc]initWithFrame:CGRectMake(14, 5, 100, cell.bounds.size.height-10)];
        label2.text = @"清楚缓存";
        cachlabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 5, 100, cell.bounds.size.height-10)];
        //        cachlabel.text = @"100MB";
        cachlabel.text = [NSString stringWithFormat:@"%.2fMB", [self countCacheFileSize]];
        label2.font = [UIFont systemFontOfSize:18];
        
        cachlabel.font = [UIFont systemFontOfSize:18];
        [cell.contentView addSubview:cachlabel];
        [cell.contentView addSubview:label2];

    }else if (indexPath.row == 0){

        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(14, 8, 100, cell.bounds.size.height-16)];
        label.text = @"意见反馈";
        [cell.contentView addSubview:label];
    }else if (indexPath.row == 1 ){
     
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(14, 8, 100, cell.bounds.size.height-16)];
        label.text = @"关于我们";
        [cell.contentView addSubview:label];
        
    } else if (indexPath.row == 3){
      
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(14, 8, 100, cell.bounds.size.height-16)];
        label.text = @"欢迎页面";
        [cell.contentView addSubview:label];
        
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
#pragma 缓存方法实现
- (void)viewWillAppear:(BOOL)animated
{
    // 将计算完成的结果 显示到界面上去
    cachlabel.text = [NSString stringWithFormat:@"%.2fMB", [self countCacheFileSize]];
    
}



#pragma mark - 计算当前缓存文件大小

/**
 *  计算当前应用程序缓存文件的大小之和
 *
 *  @return 文件大小
 */
- (CGFloat)countCacheFileSize
{
    // 1. 获取缓存文件夹的路径
    // 函数，用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@", homePath);
    /**
     1) 子文件夹1 视频缓存 /tmp/MediaCache/
     2）子文件夹2 SDWebImage框架的缓存图片  /Library/Caches/com.hackemist.SDWebImageCache.default/
     3) 子文件夹3 /Library/Caches/com.zhujiacong.TimeMovie/
     */
    
    // 2. 使用- (CGFloat)getFileSize:(NSString *)filePath 来计算这些文件夹中文件大小
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/default/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/com.zhujiacong.TimeMovie/"];
    // 文件大小之和
    CGFloat fileSize = 0;
    for (NSString *string in pathArray)
    {
        // 拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@", homePath, string];
        fileSize += [self getFileSize:filePath];
        
    }
    
    // 3. 对上一步计算的结果进行求和 并返回
    
    
    return fileSize;
}

/**
 *  根据传入的路径 计算此路径下的文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 此文件夹下所有文件的总大小  单位MB
 */
- (CGFloat)getFileSize:(NSString *)filePath
{
    // 文件管理器对象  单例
    NSFileManager *manager = [NSFileManager defaultManager];
    // 数组 储存文件夹中所有的子文件夹以及文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    
    long long size = 0;
    
    // 遍历文件夹
    for (NSString *fileName in fileNames)
    {
        // 拼接获取文件的路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@", filePath, fileName];
        // 获取文件信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        NSLog(@"%@",dic);
        // 获取单个文件的大小
        NSNumber *sizeNumber = dic[NSFileSize];
        // 使用一个 long long类型来储存文件大小
        long long subFileSize = [sizeNumber longLongValue];
        
        // 文件大小求和
        size += subFileSize;
        
    }
    
    return size / 1024.0 / 1024;
}



#pragma mark - 清理缓存文件

/**
 *  清理缓存文件
 */
- (void)clearCacheFile
{
    cachlabel.text = @"清理中.." ;
    // 获取缓存文件的路径
    // 1. 获取缓存文件夹的路径
    
    NSString *homePath = NSHomeDirectory();
    
    
    // 2. 删除文件
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/default/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/com.zhujiacong.TimeMovie/"];
    
    for (NSString *string in pathArray)
    {
        // 拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@", homePath, string];
        // 文件管理
        NSFileManager *manager = [NSFileManager defaultManager];
        // 获取子文件夹中的文件名
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        // 遍历文件夹 删除文件
        for (NSString *fileName in fileNames)
        {
            // 拼接子文件路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@", filePath, fileName];
            // 删除文件
            [manager removeItemAtPath:subFilePath error:nil];
        }
        
    }
    
    
    // 重新计算缓存文件大小
    // 将计算完成的结果 显示到界面上去
    cachlabel.text = [NSString stringWithFormat:@"%.2fMB", [self countCacheFileSize]];
    
}

// 单元格的选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        // 弹出一个提示框
        UIAlertView *alret = [[UIAlertView alloc] initWithTitle:@"警告" message:@"是否要清理缓存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alret show];
    }else if (indexPath.row == 0){
        IdeaViewController*idea = [[IdeaViewController alloc]init];
        idea.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:idea animated:YES];
    }else if (indexPath.row == 1){
        AboutViewController*about = [[AboutViewController alloc]init];
        about.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:about animated:YES];
    }
}


// 提示框的按钮点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 判断 点击的按钮为 “是”
    if (buttonIndex == 1)
    {
        // 清理缓存
        [self clearCacheFile];
    }
}

@end
