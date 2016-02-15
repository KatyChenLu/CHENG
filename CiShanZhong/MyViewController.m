//
//  MyViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "MyViewController.h"
#import "UIView+Common.h"
#import "DetailModel.h"
#import "DBManager.h"
#import <UIImageView+WebCache.h>
#import "FavourtTableViewCell.h"
#import "DetailViewController.h"
#import "DetailModel.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSArray *_dataArray;
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgationTitle:@"我的收藏"];
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDataFromDB];
}
- (void)getDataFromDB {
    NSArray *models = [[DBManager sharedManager] readModels];
    _dataArray = models;
 
    UIImageView *nothingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EmptyPlaceholder"]];
    nothingImageView.contentMode = UIViewContentModeCenter;
    UIImageView *tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, screenHeight()-100, 90, 50)];
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, screenHeight()-130, 200, 50)];
    tipsLabel.adjustsFontSizeToFitWidth = YES;
    tipsLabel.text = @"快去收藏自己喜欢的游记吧~";
    tipsLabel.textColor = [UIColor lightGrayColor];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipImageView.image = [UIImage imageNamed:@"jiantoutou"];
    if (_dataArray.count == 0) {
        _tableView.backgroundView = nothingImageView;
        [self.view addSubview:tipsLabel];
        [self.view addSubview:tipImageView];
    }else {
        _tableView.backgroundView = nil;
        [tipImageView removeFromSuperview];
        [tipsLabel removeFromSuperview];
    }
       [_tableView reloadData];
}
-(void)createTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight()-40) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identidier=@"cellId";
    FavourtTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[FavourtTableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identidier];
        // 设置选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenWidth()*0.5;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO:详情页面
    FeaturedModel *model = _dataArray[indexPath.row];
    DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    dvc.hidesBottomBarWhenPushed = YES;
    dvc.Id = model.Mid;
   
    dvc.fModel = model;
    
    
    [self.navigationController pushViewController:dvc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
