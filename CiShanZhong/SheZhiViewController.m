//
//  SheZhiViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/12.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "SheZhiViewController.h"
#import "JWCache.h"
#import "YIJianViewController.h"
@interface SheZhiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSString *currentCache;
@end

@implementation SheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:4/255.0 green:155/255.0 blue:225 /255.0 alpha:0.1];
    self.view.backgroundColor = [UIColor clearColor];
    [self createNavButton];
    [self creatTableView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"设置";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:25];
    
    self.navigationItem.titleView = titleLabel;
}
- (void)creatTableView {
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 50, self.view.frame.size.width, 50 * 4) style:UITableViewStylePlain];
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
- (void)createNavButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[[UIImage imageNamed:@"IconProfile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

- (void)clear {
    [JWCache resetCache];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"清理成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"清理成功");
        _currentCache = @"0.00";
    }];
    [alert addAction:alertAction2];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _currentCache = [NSString stringWithFormat:@"%.2f",[JWCache folderSizeAtPath:[JWCache cacheDirectory]]];
}

-(void) toClear {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"共有%@M缓存,是否需要清理?",_currentCache] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (![JWCache folderSizeAtPath:[JWCache cacheDirectory]] == 0) {
            [self clear];
        }
        
    }];
    [alert addAction:alertAction1];
    [alert addAction:alertAction2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    sleep(0.5);
    cell.imageView.highlighted = NO;
    switch (indexPath.row) {
        case 0:{
            YIJianViewController *yvc = [[YIJianViewController alloc] init];
            [self.navigationController pushViewController:yvc animated:YES];
        }

            break;
        case 1:{
            
            NSString *str = [NSString stringWithFormat:
                             @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",1076204765];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        }
            break;
        case 2:
            [self toClear];
            break;
   
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        cell.textLabel.textColor = [UIColor whiteColor];

        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }

    NSArray *titles = @[@"给心城提意见", @"去AppStore评价心城",@"清除浏览缓存"];
    NSArray *images = @[@"CommentBorderBarButton", @"FavoriteBorderBarButton",   @"Delete_Dark_Normal"];
    NSArray *highlightedImages = @[@"CommentBorderBarButtonHighlight",@"FavoriteBarButtonHighlight",@"DeleteBarButtonHighlight"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    cell.imageView.highlightedImage = [UIImage imageNamed:highlightedImages[indexPath.row]];
    
    return cell;
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
