//
//  GongLueViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/3.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "GongLueViewController.h"

@interface GongLueViewController ()

@end

@implementation GongLueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMyNavigation];

}
-(void)createMyNavigation
{
    [super createMyNavigation];
    self.navigationController.navigationBarHidden = YES;
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
