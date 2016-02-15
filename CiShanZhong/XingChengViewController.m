//
//  XingChengViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/5.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "XingChengViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XingChengModel.h"
#import "XingChengTableViewCell.h"
#import "UIView+Common.h"
#import "DetailViewController.h"
#import "JWCache.h"
#import "NSString+Tools.h"
@interface XingChengViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation XingChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"行程";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:25];
    
    self.navigationItem.titleView = titleLabel;

    _dataArray = [NSMutableArray new];
    self.view.backgroundColor = [UIColor clearColor];
    [self downLoadURLFromNet];
    [self createTableView];
    [self createBackNavButton];
}
- (void)createBackNavButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button setBackgroundImage:[[UIImage imageNamed:@"ic_nav_left_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(touchesBack) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
- (void)touchesBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)downLoadURLFromNet {
    NSString *url = [NSString stringWithFormat:XingChengURL,_xingChengId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSData *cacheeData = [JWCache objectForKey:MD5(url)];
    if (cacheeData) {
        NSError *error = nil;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:&error];
        for (NSDictionary *dic in arr) {
            XingChengModel *model = [[XingChengModel alloc] initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        
        
    }else {
           
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error = nil;
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            for (NSDictionary *dic in arr) {
                XingChengModel *model = [[XingChengModel alloc] initWithDictionary:dic error:nil];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
            /**
             *  缓存
             */
            
            [JWCache setObject:responseObject forKey:MD5(url)];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error description]);
        }];
    }
    
}

-(void)createTableView
{
    _tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
     _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    UINib *cellNib = [UINib nibWithNibName:@"XingChengTableViewCell" bundle:nil];
    [_tableView registerNib:cellNib forCellReuseIdentifier:@"huhu"];
    
    [self.view addSubview:_tableView];
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenWidth()/2+100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XingChengTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"huhu"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XingChengModel *model = _dataArray[indexPath.row];
    cell.layer.cornerRadius = 15;
    cell.layer.masksToBounds = YES;
    cell.model = model;
    cell.backgroundColor = BLUECOLOR;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
