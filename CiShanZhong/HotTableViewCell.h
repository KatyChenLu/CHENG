//
//  HotTableViewCell.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/15.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotTableViewCell : UITableViewCell
/** 热门BTN的titles */
@property (nonatomic, strong) NSArray *hotDatas;

+ (instancetype)hotCellWithHotDatas:(NSArray *)hotDatas;

@end
