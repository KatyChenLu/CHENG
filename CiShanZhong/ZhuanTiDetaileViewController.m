//
//  ZhuanTiDetaileViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/6.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "ZhuanTiDetaileViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ZhuanTiDetailModel.h"
#import "ZhuanTiDetailTableViewCell.h"
#import "DetailViewController.h"
#import "UIView+Common.h"
#import "ZhuanTiDetailHeaderView.h"
#import "JWCache.h"
#import "NSString+Tools.h"
@interface ZhuanTiDetaileViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    UIView *_navView;
    UIImageView *_navImage;
    UIImageView *_bnavImage;
    UIButton *_backButton;
//    UIButton *_backButton1;
    CGFloat _scrollerViewOffY;
          CGFloat _lastOffY ;
    ZhuanTiDetailHeaderView *_headView;
    ZhuanTiDetailHeaderView *_headView1;
    CGFloat _jianBian;
    UIVisualEffectView *_effectView;
    UIVisualEffectView *_effectView1;
    UIView *_dingView;
}

@end

@implementation ZhuanTiDetaileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
    self.view.backgroundColor = [UIColor clearColor];
    [self createMyNavigation];
    
}
- (void)createMyNavigation {
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), 64)];
    _navImage = [[UIImageView alloc] init];
    _bnavImage = [[UIImageView alloc] init];
    _bnavImage.frame = CGRectMake(3, 27, 35, 35);
    _bnavImage.layer.cornerRadius = 15;
    _bnavImage.layer.masksToBounds = YES;
    _bnavImage.backgroundColor = BLUECOLOR;
    [_navView addSubview:_bnavImage];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _backButton.frame = CGRectMake(5, 30, 30, 30);
    [_backButton setImage:[[UIImage imageNamed:@"ic_nav_left_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(touchBackButton:) forControlEvents:UIControlEventTouchUpInside];
  
    [self.view addSubview:_backButton];

    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)touchBackButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)downLoadURLFromNet {
    NSString *url = [NSString stringWithFormat:ZhuanTiDetailURL,_ZTid];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(url)];
    if (cacheeData) {
        ZhuanTiDetailModel *model = [[ZhuanTiDetailModel alloc] initWithData:cacheeData error:nil];
        
        [_dataArray addObjectsFromArray:model.article_sections];
        [_tableView reloadData];
        
        _headView = [ZhuanTiDetailHeaderView headerView];
        _headView.model = model;
        
        _headView.frame = CGRectMake(0, 0, screenWidth(), screenWidth()/3*1.7);
        _tableView.tableHeaderView = _headView;
        _effectView.alpha = 0;
        _effectView.frame = _headView.frame;
        
        [_headView addSubview:_effectView];
        
        
        _headView1 = [ZhuanTiDetailHeaderView headerView];
        _headView1.model = model;
        
        _headView1.frame = CGRectMake(0, 0, screenWidth(), screenWidth()/3*1.7);
        
        _effectView1.alpha = 0.9;
        _effectView1.frame = _headView1.frame;
        [_headView1 addSubview:_effectView1];
        [_effectView1 bringSubviewToFront:_backButton];
        [_dingView addSubview:_headView1];

        NSLog(@"222");

    }else {
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZhuanTiDetailModel *model = [[ZhuanTiDetailModel alloc] initWithData:responseObject error:nil];
        
         [_dataArray addObjectsFromArray:model.article_sections];
        [_tableView reloadData];

         _headView = [ZhuanTiDetailHeaderView headerView];
        _headView.model = model;
      
        _headView.frame = CGRectMake(0, 0, screenWidth(), screenWidth()/3*1.7);
        _tableView.tableHeaderView = _headView;
          _effectView.alpha = 0;
        _effectView.frame = _headView.frame;
        
        [_headView addSubview:_effectView];
      
        
        _headView1 = [ZhuanTiDetailHeaderView headerView];
        _headView1.model = model;
        
        _headView1.frame = CGRectMake(0, 0, screenWidth(), screenWidth()/3*1.7);
      
        _effectView1.alpha = 0.9;
        _effectView1.frame = _headView1.frame;
        [_headView1 addSubview:_effectView1];
        [_effectView1 bringSubviewToFront:_backButton];
        [_dingView addSubview:_headView1];
        NSLog(@"1111");
        [JWCache setObject:responseObject forKey:MD5(url)];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    }
    
}

-(void)createTableView
{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight()) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = [UIColor clearColor];
    UINib *cellNib = [UINib nibWithNibName:@"ZhuanTiDetailTableViewCell" bundle:nil];
    [_tableView registerNib:cellNib forCellReuseIdentifier:@"huhu"];
    _tableView.estimatedRowHeight = 3000;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
      UIBlurEffect *blurEffect1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//     毛玻璃视图
    _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _effectView1 = [[UIVisualEffectView alloc] initWithEffect:blurEffect1];
    _jianBian = screenWidth()/3*1.7-64-10;
    
    _dingView = [[UIView alloc] initWithFrame:CGRectMake(0, -_jianBian, screenWidth(), screenWidth()/3*1.7-10)];
    _dingView.clipsToBounds =YES;
    
    
    [self.view addSubview:_tableView];
    [self downLoadURLFromNet];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZhuanTiDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"huhu"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak ZhuanTiDetaileViewController *weakSelf = self;
    cell.block = ^(NSString *ID) {
        DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        dvc.hidesBottomBarWhenPushed = YES;
        dvc.Id = ID;
        [weakSelf.navigationController pushViewController:dvc animated:YES];

    };
    
    ArticleSectionsModel *DDmodel = _dataArray[indexPath.row];
    
    cell.model = DDmodel;
    
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}
-(void)isShowDing:(BOOL)isShow {
    if (isShow) {
        
           [_dingView addSubview:_headView1];
         [self.view addSubview:_dingView];
        [self.view bringSubviewToFront:_backButton];
        
    }else if (!isShow){
        [_dingView removeFromSuperview];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _tableView) {
        _scrollerViewOffY = scrollView.contentOffset.y;
        
        if (_scrollerViewOffY - _lastOffY > 0 && _scrollerViewOffY > 0) {
            if (_scrollerViewOffY < _jianBian && _scrollerViewOffY > 0) {
                _effectView.alpha = _scrollerViewOffY* (0.9/_jianBian);
                [self isShowDing:NO];
            } else if(_scrollerViewOffY > _jianBian){
                _effectView.alpha = 0.9;
                [self isShowDing:YES];
            }
            _lastOffY = _scrollerViewOffY;
        }else if ( _lastOffY - _scrollerViewOffY >= 0 && _scrollerViewOffY > 0) {
            if (_scrollerViewOffY < _jianBian) {
                _effectView.alpha =  _scrollerViewOffY* (0.9/_jianBian);
                [self isShowDing:NO];
            } else if(_scrollerViewOffY > _jianBian){
                  _effectView.alpha = 0.9;
                [self isShowDing:YES];

            }
            _lastOffY = _scrollerViewOffY;
        }
        
    }

}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
