//
//  SearchViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/26.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "SearchViewController.h"
#import "MyTextField.h"
#import "UIView+Common.h"
#import "HistoryTableViewCell.h"
#import "HotTableViewCell.h"
#import "SearchHeadView.h"
#import "ToolboxViewController.h"

#import <AFNetworking/AFNetworking.h>
#import "AppDelegate.h"
#import "MapViewController.h"
#define SearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hisDatas.data"]

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    AFHTTPRequestOperationManager *_manager;
}
/** 搜索文本框 */
@property (nonatomic, weak) MyTextField *mySearch;
/** 搜索的tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 搜索的数据 */
@property (nonatomic, strong) NSMutableArray *datas;
/** 历史搜索数据 */
@property (nonatomic, strong) NSMutableArray *hisDatas;
/** 热门数据模型 */
@property (nonatomic, strong) NSArray *hotDatas;

@end

@implementation SearchViewController

- (NSMutableArray *)hisDatas
{
    if (_hisDatas == nil) {
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
        if (_hisDatas == nil) {
            _hisDatas = [NSMutableArray arrayWithObjects:@"火锅", nil];
        }
    }
    return _hisDatas;
}

- (NSArray *)hotDatas
{
    if (_hotDatas == nil) {
        _hotDatas = @[@"法国", @"日本", @"温泉", @"海滩"];
    }
    
    return _hotDatas;
}

/** 模拟数据,懒加载方法 */
- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        
        if (self.hisDatas.count) {
            [_datas addObject:self.hisDatas];
        }
        //热点搜索，估计服务器每次返回四个字符串
        [_datas addObject:self.hotDatas];
        
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //初始化导航条内容
    [self setNavigationItem];
    
    //初始化UI
    [self setUI];
//    [self loadFromNet];
}
- (void)loadFromNet {
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    _manager.securityPolicy = securityPolicy;
 
//    NSData *cacheeData = [JWCache objectForKey:MD5(DestinationURL)];

}
- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
//    [self.mySearch becomeFirstResponder];
    
}

- (void)setNavigationItem
{
    //搜索TextField
   MyTextField  *search = [[MyTextField alloc] init];
    CGFloat w = screenWidth() * 0.5;
    search.frame = CGRectMake(screenWidth()*0.3, screenHeight()/6, w, 30);
    search.delegate = self;

    self.mySearch = search;
    [self.view addSubview:self.mySearch];
    //取消按钮
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(screenWidth()*0.3 + w, screenHeight()/6, 50, 30);
    
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}



- (void)setUI
{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(screenWidth()*0.3, screenHeight()/6+30, screenWidth()*0.6, screenHeight()*0.5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
}

- (void)backClick
{
    if (_mySearch.text.length) {
        for (NSString *text in self.hisDatas) {
            if ([text isEqualToString:_mySearch.text]) {
         
            }
        }
        [self.hisDatas insertObject:_mySearch.text atIndex:0];
        [self.hisDatas writeToFile:SearchHistoryPath atomically:YES];
        [self.tableView reloadData];
        
//        _mySearch.text = @"";
    }
    [self returnSth];
}
- (void)returnSth {
    [self.mySearch resignFirstResponder];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabVC = delegate.tabbarController;
    UINavigationController *nc = tabVC.viewControllers[3];
    MapViewController *map = (MapViewController *)nc.visibleViewController;
    map.IDa = _mySearch.text;
    
    
    [self.sideMenuViewController setContentViewController:tabVC animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
//监听手机键盘点击搜索的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        for (NSString *text in self.hisDatas) {
            if ([text isEqualToString:textField.text]) {
                return YES;
            }
        }
        [self.hisDatas insertObject:textField.text atIndex:0];
        [self.hisDatas writeToFile:SearchHistoryPath atomically:YES];
        [self.tableView reloadData];
       
//        textField.text = @"";
    }
     [self returnSth];

    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    [super touchesBegan:touches withEvent:event];
    
    [self.mySearch resignFirstResponder];
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.datas.count == 2) {
        if (section == 0) {
            return [self.datas[0] count];
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datas.count == 2 && indexPath.section == 0 && self.hisDatas.count) {
        HistoryTableViewCell *cell = [HistoryTableViewCell historyCellWithTableView:tableView IndexPath:indexPath atNSMutableArr:self.hisDatas];
        cell.historyTextLabel.text = self.datas[0][indexPath.row];
//        cell.historyTextLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    } else {
        //这里就一个cell 不用注册了
        HotTableViewCell *cell = [HotTableViewCell hotCellWithHotDatas:self.hotDatas];
         cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //注册head的方法和cell差不多
    SearchHeadView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];

    if (head == nil) {
        head = [SearchHeadView headView];
    }
    
    if (self.hisDatas.count) {
        if (section == 0) {
            head.headTextLabel.text = @"历史";
         
            return head;
        } else {
            head.headTextLabel.text = @"热门";
       
            return head;
        }
    } else {
        head.headTextLabel.text = @"热门";

        return head;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (self.datas.count == 2 && indexPath.section == 0 && self.hisDatas.count) {
        
      self.mySearch.text = self.datas[0][indexPath.row];
  
      
    } else if(indexPath.section == 1){
     NSLog(@"1*******");
    
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
@end
