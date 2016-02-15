//
//  SearchHeadView.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/15.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHeadView : UITableViewHeaderFooterView

/** headView的文字lable */
@property (nonatomic, strong) UILabel *headTextLabel;

+ (instancetype)headView;
@end
