//
//  WeatherItemView.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/8.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherItemView : UIView
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UILabel *tLbl;
@property (strong, nonatomic) IBOutlet UILabel *weatherLbl;
@property (strong, nonatomic) IBOutlet UILabel *windLbl;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImg;
@property(nonatomic,copy)NSString *weather;
+ (instancetype)view;
@end
