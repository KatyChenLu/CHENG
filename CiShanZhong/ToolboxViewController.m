//
//  ToolboxViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "ToolboxViewController.h"
#import "WeatherViewController.h"
#import "WeatherModel.h"
#import "HTTPManager.h"
#import "MJExtension.h"
#import "UIView+Common.h"
#import "TranslateViewController.h"
#import "MapViewController.h"
@interface ToolboxViewController ()
@property (nonatomic, strong)WeatherModel *weatherModel;
@end

@implementation ToolboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavgationTitle:@"工具箱"];
    [self createButton];
    [self createBarButtons];
}

- (void)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 50, 70);
    button.center = CGPointMake(screenWidth()/4, (screenHeight()-100)/4*3);
//    button.backgroundColor = BLUECOLOR;
    [button setBackgroundImage:[UIImage imageNamed:@"sunandcloud"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchesButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    label.center = CGPointMake(screenWidth()/4, (screenHeight()-100)/4*3+20);
    label.text = @"天气";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    label1.center = CGPointMake(screenWidth()/4*3, (screenHeight()-100)/4*3+20);
    label1.text = @"翻译";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    [self.view addSubview:label1];
    
    UIButton *translateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    translateButton.frame = CGRectMake(0, 0, 50, 50);
    translateButton.center =CGPointMake(screenWidth()/4*3, (screenHeight()-100)/4*3-20);
     [translateButton setBackgroundImage:[UIImage imageNamed:@"noun_987"] forState:UIControlStateNormal];
    
    [translateButton addTarget:self action:@selector(touchestranslateButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:translateButton];
    
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeSystem];
    mapButton.frame = CGRectMake(0, 0, 45, 45);
    mapButton.center =CGPointMake(screenWidth()/4*3, (screenHeight()-100)/4*2-10);
    [mapButton setBackgroundImage:[UIImage imageNamed:@"Detail_Map_Pressed"] forState:UIControlStateNormal];
    
    [mapButton addTarget:self action:@selector(touchesMapButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    label2.center = CGPointMake(screenWidth()/4*3, (screenHeight()-100)/4*2+40);
    label2.text = @"地图";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    [self.view addSubview:label2];
    
}
- (void)touchesMapButton {
    MapViewController * mvc = [MapViewController new];
    [self.navigationController pushViewController:mvc animated:YES];
    
}
- (void)touchestranslateButton {

    TranslateViewController *tvc = [[TranslateViewController alloc] initWithNibName:@"TranslateViewController" bundle:nil];
    [self.navigationController pushViewController:tvc animated:YES];
    
}
- (void)touchesButton {
    
    NSString *url = @"http://c.3g.163.com/nc/weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html";
//     NSString *url = @"http://c.m.163.com/nc/weather/5LiK5rW3fOS4iua1tw%3D%3D.html";
    [[HTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        WeatherModel *weatherModel = [[WeatherModel alloc] initWithDictionary:responseObject error:nil];
        
        WeatherViewController *vc = [[WeatherViewController alloc] initWithNibName:@"WeatherViewController" bundle:nil];
        vc.weatherModel = weatherModel;
        
        [self.navigationController pushViewController:vc animated:YES];
        [UIView animateWithDuration:0.1 animations:^{
       
        } completion:^(BOOL finished) {
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
 
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
