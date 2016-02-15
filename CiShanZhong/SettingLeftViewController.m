//
//  SettingLeftViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/12.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "SettingLeftViewController.h"
#import "TabBarViewController.h"
#import "ListViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "SetBGViewController.h"
#import "RESideMenu.h"
#import "SheZhiViewController.h"
#import "AboutViewController.h"
@interface SettingLeftViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (nonatomic,copy)NSMutableString *bgName;
@end

@implementation SettingLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createMyNavigation];
    [self createBarButtons];
    [self setNavgationTitle:@"CHENG"];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 4) / 2.0f, self.view.frame.size.width, 54 * 4) style:UITableViewStylePlain];
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
-(NSMutableString *)bgName {
    if (_bgName == nil) {
        _bgName = [[NSMutableString alloc] initWithString:@"01"];
    }
    return _bgName;
}
#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarController *tabVC = delegate.tabbarController;
            RESideMenu *sideMenuViewController = delegate.sideMenuViewController;
            [sideMenuViewController setContentViewController:tabVC animated:YES];
            [sideMenuViewController hideMenuViewController];
        }
            break;
        case 1: {
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            RESideMenu *sideMenuViewController = delegate.sideMenuViewController;
            
            SetBGViewController *svc = [[SetBGViewController alloc] init];
            __weak typeof(RESideMenu *) WeakSD = sideMenuViewController;
            svc.passValueHandler = ^(NSString *bgName) {
                WeakSD.backgroundImage = [UIImage imageNamed:bgName];
                WeakSD.bgName = [NSMutableString stringWithString:bgName];
            };
            svc.selectedImageName = sideMenuViewController.bgName;
             [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:svc]
                                                            animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
                        break;
        case 2:{
            AboutViewController *avc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:avc];
            [self.sideMenuViewController setContentViewController:nc animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 3:{
            SheZhiViewController *svc = [[SheZhiViewController alloc] init];
             UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:svc];
            [self.sideMenuViewController setContentViewController:nc animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
 
    NSArray *titles = @[@"主页", @"更改壁纸", @"关于我们", @"设置"];
    NSArray *images = @[@"IconHome", @"IconCalendar", @"Setting_Comment", @"IconSettings"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
