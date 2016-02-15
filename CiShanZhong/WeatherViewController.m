//
//  WeatherViewController.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/8.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "WeatherViewController.h"
#import "UIView+Frame.h"
#import "UIView+Common.h"
#import "WeatherItemView.h"
#import "WeatherModel.h"
#import <UIImageView+WebCache.h>

@interface WeatherViewController ()
@property(nonatomic,strong)UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *tempLbl;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImg;
@property (strong, nonatomic) IBOutlet UILabel *dateWeekLbl;
@property (strong, nonatomic) IBOutlet UILabel *airPMLbl;
@property (strong, nonatomic) IBOutlet UILabel *climateLbl;
@property (strong, nonatomic) IBOutlet UILabel *windLbl;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *placeLabel;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bottomView = [[UIView alloc]init];
   
    self.bottomView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_bottomView];
    self.bottomView.frame = CGRectMake(0, screenHeight()-250, screenWidth(), 250);

    _bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self addWeather];
    for (int i = 1 ; i < 4 ; i++) {
        CLWeatherDetailM *weatherDetail = self.weatherModel.detailArray[i];
        [self addItemWithTitle:weatherDetail.week weather:weatherDetail.climate wind:weatherDetail.wind T:weatherDetail.temperature index:i-1];
    }
}

- (void)addItemWithTitle:(NSString *)title weather:(NSString *)weather wind:(NSString *)wind T:(NSString *)T index:(int)index
{
    WeatherItemView *itemView = [WeatherItemView view];

    itemView.frame = CGRectMake(index * screenWidth()/3, 0, screenWidth()/3, 200);
    itemView.weather = weather;
    itemView.titleLbl.text = title;
    
    NSMutableString *temp = [T mutableCopy];
    [temp replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
    
    itemView.tLbl.text = temp;
    itemView.windLbl.text = wind;
    [self.bottomView addSubview:itemView];

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)addWeather {
    CLWeatherDetailM *weatherDetail = self.weatherModel.detailArray[0];
    
    NSMutableString *temp = [weatherDetail.temperature mutableCopy];
    [temp replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
    
    self.tempLbl.text = temp;
    
    self.dateWeekLbl.text = [NSString stringWithFormat:@"%@  %@",self.weatherModel.dt,weatherDetail.week];
    
    NSString *desc;
    int pm = self.weatherModel.pm2d5.pm2_5.intValue;
    if (pm < 50) {
        desc = @"优";
    }else if (pm < 100){
        desc = @"良";
    }else{
        desc = @"差";
    }
    
    self.airPMLbl.text = [NSString stringWithFormat:@"PM2.5 %d %@",pm,desc];
    //    self.localLbl.text = @"北京";
    self.climateLbl.text = weatherDetail.climate;
    self.windLbl.text = weatherDetail.wind;
    
    if ([weatherDetail.climate isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder"];
    }else if ([weatherDetail.climate isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun"];
    }else if ([weatherDetail.climate isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sunandcloud"];
    }else if ([weatherDetail.climate isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"cloud"];
    }else if ([weatherDetail.climate hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain"];
    }else if ([weatherDetail.climate hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sandfloat"];
    }
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:self.weatherModel.pm2d5.nbg2] placeholderImage:[UIImage imageNamed:@"QingTian"]];
}
- (IBAction)backBtnAction:(UIButton *)sender {
     [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
