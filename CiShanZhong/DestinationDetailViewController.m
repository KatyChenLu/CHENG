//
//  DestinationDetailViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/3.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "DestinationDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIView+Common.h"
#import "DeatinatneDetailModel.h"
#import "DestinationDetailTableViewCell.h"
#import "GongLueViewController.h"
#import "XingChengViewController.h"
#import "LvXingDiViewController.h"
#import "JWCache.h"
#import "NSString+Tools.h"
@interface DestinationDetailViewController () <UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *_dataArray;
    UITableView *_tableView;
    
    UIView  *_navView;
    UIButton *_backButton;
}

@end

@implementation DestinationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:4/255.0 green:155/255.0 blue:225 /255.0 alpha:0.1];
    _dataArray = [NSMutableArray new];
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
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}
//-(void)viewWillDisappear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = NO;
//}
- (void)downLoadURLFromNet {
    NSString *url = [NSString stringWithFormat:DestinationDetailURL,_Id];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(url)];
    if (cacheeData) {
        NSError *error = nil;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:&error];
        for (NSDictionary *dic in arr) {
            DeatinatneDetailModel *model = [[DeatinatneDetailModel alloc]initWithDictionary:dic error:nil];
            
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
       
    }else{
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        for (NSDictionary *dic in arr) {
            DeatinatneDetailModel *model = [[DeatinatneDetailModel alloc]initWithDictionary:dic error:nil];
          
                [_dataArray addObject:model];
        }
        [_tableView reloadData];

        /**
         *  缓存
         */
        
        [JWCache setObject:responseObject forKey:MD5(url)];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//       NSLog(@"%@",[error description]);
    }];
    }

}

-(void)createTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight()) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = [UIColor clearColor];
   _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *cellNib = [UINib nibWithNibName:@"DestinationDetailTableViewCell" bundle:nil];
    [_tableView registerNib:cellNib forCellReuseIdentifier:@"huhu"];

   [self.view addSubview:_tableView];
    
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    DestinationDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"huhu"];
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DeatinatneDetailModel *DDmodel = _dataArray[indexPath.row];
    
    cell.model = _dataArray[indexPath.row];
    cell.button = ^(NSInteger tag) {
//        NSLog(@"%ld",tag);
        switch (tag) {
            case 10: {
                GongLueViewController *gvc = [[GongLueViewController alloc] init];
                [self.navigationController pushViewController:gvc animated:YES];
            }
                break;
            case 20: {
                XingChengViewController *xvc = [[XingChengViewController alloc] init];
                xvc.xingChengId = DDmodel.Did;
                [self.navigationController pushViewController:xvc animated:YES];
            }
                break;
            case 30:{
                LvXingDiViewController *lvc = [[LvXingDiViewController alloc] init];
                lvc.lvXingDiId = DDmodel.Did;
                [self.navigationController pushViewController:lvc animated:YES];
            }
                break;
//            case <#constant#>:
//                <#statements#>
//                break;
//                
            default:
                break;
        }
    };
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenWidth()/2+74;
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
