//
//  WeatherModel.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/8.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherBgM

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation CLWeatherDetailM
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WeatherModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"北京|北京":@"detailArray"}];
}
@end
