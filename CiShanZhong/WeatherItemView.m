
//
//  WeatherItemView.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/8.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "WeatherItemView.h"

@implementation WeatherItemView

+(instancetype)view {
     return [[NSBundle mainBundle]loadNibNamed:@"WeatherItemView" owner:nil options:nil][0];
}
-(void)setWeather:(NSString *)weather {
    _weather = weather;
    self.weatherLbl.text = weather;
    if ([weather isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder"];
    }else if ([weather isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun"];
    }else if ([weather isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sunandcloud"];
    }else if ([weather isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"cloud"];
    }else if ([weather hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain"];
    }else if ([weather hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sandfloat"];
    }

}
@end
