//
//  WeatherViewController.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/8.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModel;
@interface WeatherViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;
@property (nonatomic, strong)WeatherModel *weatherModel;
@end
