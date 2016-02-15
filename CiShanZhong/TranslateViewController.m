//
//  TranslateViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/9.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "TranslateViewController.h"
#import "NSString+Tools.h"
#import "HTTPManager.h"
#import "NSString+Tools.h"
//#import <AFNetworking/AFNetworking.h>
@interface TranslateViewController ()<UITextFieldDelegate,UITabBarDelegate> {
    NSMutableArray *_tranArray;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *showLabel;
@property (strong, nonatomic) IBOutlet UITextField *translateTextField;
@end
/*
 
 有道翻译API申请成功
 API key：1631081129
 keyfrom：chenlutranslate
 
 创建时间：2016-01-11
 网站名称：chenlutranslate
 网站地址：http://chenlu.com

 */
@implementation TranslateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _tranArray = [NSMutableArray new];
    _translateTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillHid:) name:UIKeyboardWillHideNotification object:nil];
    [self createBackNavButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"翻译";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:25];
    self.navigationItem.titleView = titleLabel;
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

- (void)keyWillHid:(NSNotification *)notification {
    NSDictionary *dictionary = [notification userInfo];

        [UIView animateWithDuration:[dictionary [UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
            self.bgView.transform = CGAffineTransformIdentity;
        }];

}
- (void)keyWillShow:(NSNotification *)notification {
    NSDictionary *dictionary = [notification userInfo];
    CGRect keyBoardRect = [dictionary [UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRect bgRect = self.bgView.frame;
    CGFloat keyBoardorigin = keyBoardRect.origin.y;
    CGFloat bgorigin = self.bgView.frame.origin.y + self.bgView.frame.size.height;
    
    if (bgorigin > keyBoardorigin) {
         [UIView animateWithDuration:[dictionary [UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
          self.bgView.transform = CGAffineTransformMakeTranslation(0, -bgorigin + keyBoardorigin);
    }];
    }else {
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_translateTextField resignFirstResponder];
}
- (void)downLoadFromURL {
    /*
     APP ID：20160109000008743
     密钥：PjDBfGu7d2QUJ350WJrD
     */
    NSString *q = _translateTextField.text;
    NSString *from = @"auto";
    NSString *to = @"zh";
    NSString *appid = @"2015063000000001";
    NSString *salt = @"19941230";
    NSString *key = @"12345678";
    const char *string1 = [[NSString stringWithFormat:@"%@%@%@%@",appid,q,salt,key] UTF8String];
    NSString *sign = MD5Hash(string1);
    NSString *qEncode = URLEncodedString(q);
    NSString *url = [NSString stringWithFormat:@"http://api.fanyi.baidu.com/api/trans/vip/translate?q=%@&from=%@&to=%@&appid=%@&salt=%@&sign=%@",qEncode,from,to,appid,salt,sign];
    [[HTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSLog(@"%@",responseObject[@"trans_result"][0][@"dst"]);
        [_tranArray addObject:responseObject[@"trans_result"][0][@"dst"]];
       _showLabel.text = _tranArray.lastObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _translateTextField) {
        [self downLoadFromURL];
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}
- (IBAction)tranButton:(UIButton *)sender {
//
    if (_translateTextField.text.length > 0) {
        [self downLoadFromURL];
    }else if (_translateTextField.text.length <= 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"请输入要翻译的文字啊！！"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *oAction = [UIAlertAction actionWithTitle:@"(⊙o⊙)哦" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:oAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
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
