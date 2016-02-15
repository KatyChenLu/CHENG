//
//  TabBarViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "TabBarViewController.h"
#import "ListViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createViewControllers];

}

- (void)createViewControllers {
    
    NSArray *nameArray = @[@"Featured",@"Destination",@"Offline",@"Toolbox",@"My"];
    NSArray *nameArray1 = @[@"游记",@"攻略",@"专题",@"工具箱",@"我的"];
    NSMutableArray *controllers = [NSMutableArray new];
    for (int i = 0; i < nameArray.count; i++) {
        NSString *name = [NSString stringWithFormat:@"%@ViewController",nameArray[i]];
        Class cls = NSClassFromString(name);
        ListViewController *lvc = [[cls alloc]init];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:lvc];

              nc.navigationBar.barTintColor =[UIColor colorWithRed:4/255.0 green:155/255.0 blue:225 /255.0 alpha:0.1];
        NSString *selectedName = [NSString stringWithFormat:@"TabBarIcon%@",nameArray[i]];
        lvc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
        NSString *imageName = [NSString stringWithFormat:@"%@Normal",selectedName];
        lvc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        lvc.title = nameArray1[i];
        [controllers addObject:nc];
    }
    self.viewControllers = controllers;
  
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
