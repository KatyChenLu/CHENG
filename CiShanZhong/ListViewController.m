//
//  ListViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController () {
    UIView  *_navView;
    UIButton *_backButton;
}

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavgationTitle:@"蝉游记"];
    [self createBarButtons];
}
- (void)createMyNavigation {
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    _navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Navbar_mask"]];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _backButton.frame = CGRectMake(5, 30, 30, 30);
    [_backButton setImage:[[UIImage imageNamed:@"ic_nav_left_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(touchBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backButton];
    
    [self.view addSubview:_navView];
    
}
- (void)touchBackButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
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
