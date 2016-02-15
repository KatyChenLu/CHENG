//
//  YIJianViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/13.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "YIJianViewController.h"
@interface YIJianViewController ()<UITextViewDelegate>{
    UILabel *uilable;
}

@end

@implementation YIJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMyNavigation];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"意见反馈";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:25];
    
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(onClick:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
//    self.view.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    
    [self createText];
    [self createBackNavButton];
}
- (void)createText {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 120)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.hidden = NO;
    textView.delegate = self;
    //其次在UITextView上面覆盖个UILable,UILable设置为全局变量。
    uilable=[[UILabel alloc]initWithFrame:CGRectMake(0,-70, self.view.frame.size.width, 100)];
    uilable.text = @"请您在这里填写您对我们的意见，我们将不断努力改进，感谢支持~~";
    uilable.numberOfLines=0;
    uilable.enabled = NO;//lable必须设置为不可用
    uilable.backgroundColor = [UIColor clearColor];
    [textView addSubview:uilable];
    [self.view addSubview:textView];
    
    
    UITextField *text2=[[UITextField alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 40)];
    text2.placeholder=@"请您留下您的QQ/电话，以便我们与您联系。";
    text2.backgroundColor=[UIColor whiteColor];
    text2.adjustsFontSizeToFitWidth=YES;
    text2.font=[UIFont fontWithName:@"Arial" size:15.0f];
    
    [self.view addSubview:text2];
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
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        uilable.text = @"请您在这里填写您对我们的意见，我们将不断努力改进，感谢支持~~";
    }else{
//        uilable.text = @"";
    }
}

-(void)onClick:(UIBarButtonItem *)item{
//    uilable.text = @"";
    if (uilable.text.length > 0) {
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发送成功，感谢您的建议~" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"(⊙v⊙)嗯" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [alert addAction:alertAction];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];

    }
  
    
    
}


@end
