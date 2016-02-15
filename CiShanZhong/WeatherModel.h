//
//  WeatherModel.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/8.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//#import "WeatherBgM.h"

@protocol CLWeatherDetailM
@end

@interface  CLWeatherDetailM : JSONModel
/** 什么风*/
@property(nonatomic,copy)NSString *wind;
/** 农历*/
@property(nonatomic,copy)NSString *nongli;
/** 日期*/
@property(nonatomic,copy)NSString *date;
/** 天气*/
@property(nonatomic,copy)NSString *climate;
/** 温度*/
@property(nonatomic,copy)NSString *temperature;
/** 星期几*/
@property(nonatomic,copy)NSString *week;

@end

@interface WeatherBgM : JSONModel

@property(nonatomic,copy)NSString *nbg1;

/** 这个是真正的背景图*/
@property(nonatomic,copy)NSString *nbg2;

@property(nonatomic,copy)NSString *aqi;

@property(nonatomic,copy)NSString *pm2_5;

@end


@interface WeatherModel : JSONModel
@property(nonatomic,strong)NSMutableArray <CLWeatherDetailM>*detailArray;
@property(nonatomic,strong)WeatherBgM *pm2d5;
@property(nonatomic,copy)NSString *dt;
@property(nonatomic,assign)int rt_temperature;
@end
