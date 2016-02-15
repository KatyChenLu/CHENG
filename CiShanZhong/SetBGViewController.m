//
//  SetBGViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/12.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "SetBGViewController.h"
#import "AppDelegate.h"
#import "UIView+Common.h"
#define LeftPid 20
#define TopPid 20
#define Pid 15
@interface SetBGViewController () {
    UIImageView *_iconSuccessImageView;
    UIButton *_lastButton;
    UIButton *sureButton;
    UIButton *losButton;
}
@end

@implementation SetBGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatbgButtons];
    [self createSeccessImageView];
    self.view.backgroundColor = [UIColor clearColor];
}
- (void)createSeccessImageView {
    if (!_iconSuccessImageView) {
        _iconSuccessImageView = [UIImageView new];
        _iconSuccessImageView.frame = CGRectMake(12.5, 12.5, 25, 25);
        _iconSuccessImageView.image = [UIImage imageNamed:@"IconSyncSuccess"];
        [self.view addSubview:_iconSuccessImageView];
    }
    UIButton *but = (UIButton *)[self.view viewWithTag:[_selectedImageName integerValue]];
     [self chooseBGByImageName:_selectedImageName selectedButton:but];
}
- (void)creatbgButtons {
    CGFloat weight = screenWidth()/2.5;
    CGFloat height = screenHeight()/3.6;
    for (int i = 1; i<7; i++) {
          UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i%2) {
            button.frame = CGRectMake(LeftPid, TopPid+i/2*(Pid+height), weight, height);
        }else {
            button.frame = CGRectMake(screenWidth()-LeftPid-weight, TopPid+(i/2-1)*(Pid+height), weight, height);
        }
        button.tag = i;
        NSString *buttonName = [NSString stringWithFormat:@"0%d",i];
        [button setImage:[[UIImage imageNamed:buttonName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(touchesBgButon:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
  
    sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sureButton.backgroundColor = BLUECOLOR;
    sureButton.frame = CGRectMake(screenWidth()-LeftPid-weight, screenHeight()-TopPid-height*0.2, weight, height*0.2);
    sureButton.titleLabel.font = FONT;
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(touchesSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
    losButton = [UIButton buttonWithType:UIButtonTypeSystem];
    losButton.backgroundColor = BLUECOLOR;
    losButton.frame = CGRectMake(LeftPid, screenHeight()-TopPid-height*0.2, weight, height*0.2);
    losButton.titleLabel.font = FONT;
   [losButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [losButton setTitle:@"取消" forState:UIControlStateNormal];
    [losButton addTarget:self action:@selector(toucheslosButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:losButton];
    
}
- (void)touchesBgButon :(UIButton *)bgButton {
    NSString *touchNum = [NSString stringWithFormat:@"0%@",@(bgButton.tag)];
    [self chooseBGByImageName:touchNum selectedButton:bgButton];
}
- (void)touchesSureButton:(UIButton *)sureButton {
    if (_passValueHandler) {
        _passValueHandler(_selectedImageName);
    }
    [self dismissSetBGViewController];
}
- (void)toucheslosButton:(UIButton *)losButton {
    [self dismissSetBGViewController];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
//选择背景，使其进入选中状态
- (void)chooseBGByImageName:(NSString *)bgName selectedButton:(UIButton *)button{
    if (button == _lastButton) {
        return;
    }
     NSLog(@"%@",bgName);
    _iconSuccessImageView.center = CGPointMake(button.frame.origin.x, button.frame.origin.y);
    [self.view bringSubviewToFront:_iconSuccessImageView];
    
    self.selectedImageName = bgName;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismissSetBGViewController {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabVC = delegate.tabbarController;
    [self.sideMenuViewController setContentViewController:tabVC animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}


@end
