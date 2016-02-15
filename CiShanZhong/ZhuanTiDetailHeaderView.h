//
//  ZhuanTiDetailHeaderView.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/9.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuanTiDetailModel.h"
@interface ZhuanTiDetailHeaderView : UIView
@property (nonatomic, strong)ZhuanTiDetailModel *model;
+ (instancetype)headerView;
@end
