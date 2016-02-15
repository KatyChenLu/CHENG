//
//  FeaturedViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "FeaturedViewController.h"
#import "FeaturedTableViewCell.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "UIView+Common.h"
#import <MJRefresh/MJRefresh.h>
#import "CBStoreHouseRefreshControl.h"
#import "DetailViewController.h"
#import "JWCache.h"
#import "NSString+Tools.h"
@interface FeaturedViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FeaturedViewController {
    AFHTTPRequestOperationManager *_manager;
    BOOL _isMore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.title = @"蝉游记";
        _dataArray = [NSMutableArray array];
    [self createTableView];
    [self setNavgationTitle:@"CHENG"];
    [self createBarButtons];
    //    [self loadDataFromNet];
}

- (void)createTableView {
    if (_appTableView == nil) {
        _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, screenWidth(), screenHeight()-40) style:UITableViewStylePlain];
        _appTableView.backgroundColor = [UIColor clearColor];
        _appTableView.delegate = self;
        _appTableView.dataSource = self;
        _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_appTableView];
    }
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.storeHouseRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:_appTableView target:self refreshAction:@selector(refreshTriggered:) plist:@"CHENG" color:[UIColor whiteColor] lineWidth:3 dropHeight:80 scale:0.7 horizontalRandomness:300 reverseLoadingAnimation:NO internalAnimationFactor:0.7];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        NSLog(@"***********GETmore");
        [self loadDataFromNet:YES];
        _isMore = YES;
    }];
    _appTableView.mj_footer = footer;
    
    [_appTableView.mj_footer beginRefreshing];

    
}
#pragma mark - Listening for the user to trigger a refresh

- (void)refreshTriggered:(id)sender
{
    
    [self performSelector:@selector(finishRefreshControl) withObject:nil afterDelay:4.4 inModes:@[NSRunLoopCommonModes]];
}
- (void)finishRefreshControl
{
//    [self loadDataFromNet:NO];
    [self.storeHouseRefreshControl finishingLoading];

}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - Notifying refresh control of scrolling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.storeHouseRefreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.storeHouseRefreshControl scrollViewDidEndDragging];
}
- (void)loadDataFromNet:(BOOL)isMore {
    //TODO:下载数据
    static NSInteger page = 1;
    NSString *urlString = nil;
    
    if (_isMore) {
        page++;
    }else {
        page = 1;
    }
    urlString = [NSString stringWithFormat:FeaturedURL,page];
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    _manager.securityPolicy = securityPolicy;
    
    
    NSData *cacheeData = [JWCache objectForKey:MD5(urlString)];
    if (cacheeData) {
        
        NSError *error = nil;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:&error];
        for (NSDictionary *dic in arr) {
            FeaturedModel *model = [[FeaturedModel alloc]initWithDictionary:dic error:nil];
            if (isMore) {
                [_dataArray addObject:model];
            } else {
                [_dataArray removeAllObjects];
                [_appTableView reloadData];
                
            }
            [_appTableView reloadData];

        }
              isMore?[_appTableView.mj_footer endRefreshing]:[self finishRefreshControl];
        
    }else {
    
    
    [_manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSArray *arr = (NSArray *)responseObject;
        NSError *error = nil;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        for (NSDictionary *dic in arr) {
            FeaturedModel *model = [[FeaturedModel alloc]initWithDictionary:dic error:nil];
            if (isMore) {
                [_dataArray addObject:model];
            } else {
                [_dataArray removeAllObjects];
                [_appTableView reloadData];
          
            }
            [_appTableView reloadData];
        }
        isMore?[_appTableView.mj_footer endRefreshing]:[self finishRefreshControl];
        /**
         *  缓存
         */
      
            [JWCache setObject:responseObject forKey:MD5(urlString)];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.58*screenWidth()+10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"huhu";
    FeaturedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FeaturedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.model = _dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO:详情页面
    FeaturedModel *model = _dataArray[indexPath.row];
     DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    dvc.hidesBottomBarWhenPushed = YES;
    dvc.Id = model.Mid;
    dvc.ShareTitle = model.name;
    dvc.fModel = model;
 
    [self.navigationController pushViewController:dvc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
