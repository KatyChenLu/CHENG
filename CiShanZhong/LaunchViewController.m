//
//  LaunchViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/21.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "LaunchViewController.h"
#import "UIView+Common.h"
#import "RQShineLabel.h"
#import "AppDelegate.h"
@interface LaunchViewController ()
@property (strong, nonatomic) RQShineLabel *shineLabel;
@property (strong, nonatomic) NSArray *textArray;
@property (assign, nonatomic) NSUInteger textIndex;
@property (strong, nonatomic) UIImageView *wallpaper1;
@property (strong, nonatomic) UIImageView *wallpaper2;
@end

@implementation LaunchViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        _textArray = @[
                       @"睁眼,\n因为你心有所动 \n\n闭目,\n难掩喜悦与期待",
                       @"启程,\n只因追寻你所爱 \n\n我们,\n做最了解你的人"
                       ];
        _textIndex  = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    NSInteger imageNub = ARCNUM;
    self.wallpaper1 = ({
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"5-%ld",(long)imageNub]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(0, 0, screenWidth(), screenHeight());
        imageView.alpha = 0.8;
        imageView;
    });
    [self.view addSubview:self.wallpaper1];
    
    self.wallpaper2 = ({
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"5-%ld",imageNub+1]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(0, 0, screenWidth(), screenHeight());
        imageView.alpha = 0;
        imageView;
    });
    [self.view addSubview:self.wallpaper2];
    
//    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight())];
//    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//    [self.view addSubview:blackView];
    
    self.shineLabel = ({
        RQShineLabel *label = [[RQShineLabel alloc] initWithFrame:CGRectMake(16, 16, 320 - 32, CGRectGetHeight(self.view.bounds) - 16)];
        label.numberOfLines = 0;
        label.text = [self.textArray objectAtIndex:self.textIndex];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        label.center = self.view.center;
        label;
    });
    [self.view addSubview:self.shineLabel];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.currentIndex+=1;
    if (delegate.currentIndex==2) {
        [UIView animateWithDuration:1 animations:^{
            self.wallpaper2.alpha = 0;
        } completion:^(BOOL finished) {
            [delegate setupRootViewController:delegate.sideMenuViewController];
        }];
       
        return;
    }
    [super touchesBegan:touches withEvent:event];
    if (self.shineLabel.isVisible) {
        [self.shineLabel fadeOutWithCompletion:^{
            [self changeText];
            
            [UIView animateWithDuration:1.5 animations:^{
                if (self.wallpaper1.alpha > 0.1) {
                    self.wallpaper1.alpha = 0;
                     self.wallpaper2.alpha = 0.8;
                    self.wallpaper1.transform = CGAffineTransformMakeScale(1.5, 1.5);
                   
                }
                else if (self.wallpaper2.alpha > 0.1){
                    self.wallpaper2.alpha = 0;
//                    self.wallpaper3.alpha = 1;
                    self.wallpaper2.transform = CGAffineTransformMakeScale(1.5, 1.5);
                }
//                else if (self.wallpaper3.alpha > 0.1){
//                    self.wallpaper3.alpha = 0;
//                    self.wallpaper4.alpha = 1;
//                    self.wallpaper3.transform = CGAffineTransformMakeScale(1.5, 1.5);
//                }
//                else if (self.wallpaper4.alpha > 0.1){
//                   
//                    self.wallpaper4.alpha = 0;
//                    self.wallpaper4.transform = CGAffineTransformMakeScale(1.5, 1.5);
//                }
//                
            }];
            [self.shineLabel shine];
        }];
    }
    else {
        [self.shineLabel shine];
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.shineLabel shine];
}
- (void)changeText
{
    self.shineLabel.text = self.textArray[(++self.textIndex) % self.textArray.count];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
