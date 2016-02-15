//
//  ImageViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/5.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "ImageViewController.h"
#import "UIView+Common.h"
#import "XSportLight.h"
@interface ImageViewController ()<UIAlertViewDelegate,XSportLightDelegate,UIGestureRecognizerDelegate>{
    
    UIImage *_image;
    
    UIImageView *_imageview;
    
    UIView  *_navView;
    UIButton *_backButton;
    
}



@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMyNavigation];
    
    self.view.backgroundColor = [UIColor blackColor] ;
    
    _image = [UIImage new];
    
    [self createGesture];
    
}
- (void)createMyNavigation {
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
//    _navView.backgroundColor = [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:0.5];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _backButton.frame = CGRectMake(5, 30, 30, 30);
    [_backButton setImage:[[UIImage imageNamed:@"ic_nav_left_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(touchBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backButton];
    
    [self.view addSubview:_navView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    static NSInteger num = 0;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"] && num == 0) {
        
        NSLog(@"*********");
        
        [self createSportLight];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        num++;
    }
    
    
    
}

- (void)createSportLight {
    
    
    SportLight = [[XSportLight alloc]init];
    
    SportLight.messageArray = @[
                                
                                @"试试长按屏幕保存图片吧~",
                                @"还可以放大哦~"
                                ];
    
    SportLight.rectArray = @[
                             
                             [NSValue valueWithCGRect:CGRectMake(screenWidth()/2,screenHeight()/2,100,100)],
                                [NSValue valueWithCGRect:CGRectMake(screenWidth()/3*2,screenHeight()/3*2+20,100,100)]
                             ];
    
    
    
    SportLight.delegate = self;
    
    [self presentViewController:SportLight animated:false completion:^{
        
        
        
    }];
    
}

-(void)touchBackButton:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
    
}

-(void)setImage:(UIImage *)image

{
    
    _image = image;
    
    _imageview = [UIImageView new];
    
    _imageview.image = _image;
    
    CGFloat biLi = _image.size.width/_image.size.height;
    
    
    
    _imageview.frame = CGRectMake(0, 0,screenWidth() , screenWidth()/biLi);
    
    
    
    _imageview.center = self.view.center;
    
    
    
    [self.view addSubview:_imageview];
    
}

- (void)createGesture {
    //单击
    UITapGestureRecognizer *gestureOnce = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureChange:)];
    
    [self.view addGestureRecognizer:gestureOnce];
    
    
    //双击
    UITapGestureRecognizer *gestureTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTwoAction:)];
    
    gestureTwo.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:gestureTwo];
    
    
    
    [gestureOnce requireGestureRecognizerToFail:gestureTwo];
    
    
    //长恩
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    
    [self.view addGestureRecognizer:longPress];
    
    //旋转手势
    UIRotationGestureRecognizer *rgr = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureHandle:)];
    //设置代理，用于干涉手势识别
    rgr.delegate = self;
    [self.view addGestureRecognizer:rgr ];
    //捏合手势
    UIPinchGestureRecognizer *pgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureHandle:)];
    [self.view addGestureRecognizer:pgr];

    
}
- (void)rotationGestureHandle:(UIRotationGestureRecognizer *)rgr
{
    //NSLog(@"旋转");
    _imageview.transform = CGAffineTransformRotate(_imageview.transform, rgr.rotation);
    //旋转效果会累加，因此每次处理后需要清零
    rgr.rotation = 0;
}
- (void)pinchGestureHandle:(UIPinchGestureRecognizer *)pgr
{
    _imageview.transform = CGAffineTransformScale(_imageview.transform, pgr.scale, pgr.scale);
    pgr.scale = 1.0;
}
- (void)longPressAction:(UIGestureRecognizer *)gesture {
   
    UIAlertController *alertController = [[UIAlertController alloc] init];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
 
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     
        UIImageWriteToSavedPhotosAlbum(_imageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }];
    
    [alertController addAction:cancelAction];

    [alertController addAction:archiveAction];
 
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (!error) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"已经保存到相册"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *oAction = [UIAlertAction actionWithTitle:@"(⊙o⊙)哦" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:oAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)gestureTwoAction:(UIGestureRecognizer *)gesture {
    NSLog(@"two");
//    CGPoint location = [gesture locationInView:self];
//    if (self.zoomScale != 1.0) {
//        [self setZoomScale:1 animated:YES];
//    } else {
//        [self zoomToRect:CGRectMake(location.x-10, location.y-50, 20, 100) animated:YES];
//    }
    
}
- (void)gestureChange:(UITapGestureRecognizer *)gesture {
//    NSLog(@"one");
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)XSportLightClicked:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.view == otherGestureRecognizer.view) {
        return YES;
    }
    return NO;
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
