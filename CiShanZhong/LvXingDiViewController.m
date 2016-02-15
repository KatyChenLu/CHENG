//
//  LvXingDiViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/17.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "LvXingDiViewController.h"
#import "LXDCell.h"
#import "LXDModel.h"
#import <AFNetworking/AFNetworking.h>
#import "JWCache.h"
#import "NSString+Tools.h"
@interface LvXingDiViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation LvXingDiViewController

#pragma mark - 重写tableview的添加方法，修改frame



- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"旅行地";
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
    [self.navigationController popViewControllerAnimated:YES];
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
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)downLoadURLFromNet {
   NSString * url = [NSString stringWithFormat:LvXingDiURL,[self.lvXingDiId intValue],1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSData *cacheeData = [JWCache objectForKey:MD5(url)];
    if (cacheeData) {
        NSError *error = nil;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:&error];
        for (NSDictionary * dict in arr) {
            LXDModel * model = [[LXDModel alloc]initWithDictionary:dict error:nil];
            model.ID = dict[@"id"];
            model.description_Detail = dict[@"description"];
            [_dataArray addObject:model];
        }
        
        [_tableView reloadData];
    }else {
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error = nil;
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            for (NSDictionary * dict in arr) {
                LXDModel * model = [[LXDModel alloc]initWithDictionary:dict error:nil];
                model.ID = dict[@"id"];
                model.description_Detail = dict[@"description"];
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

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXDModel * model = _dataArray[indexPath.row];
    return [model.cellHight floatValue];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXDCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[LXDCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.cornerRadius = 15;
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = BLUECOLOR;
    cell.model = _dataArray[indexPath.row];
    return cell;
}


@end
