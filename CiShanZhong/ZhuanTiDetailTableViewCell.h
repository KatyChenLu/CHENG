//
//  ZhuanTiDetailTableViewCell.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/7.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuanTiDetailModel.h"

typedef void(^ZhuanTiDetailBlock)(NSString *ID);

@interface ZhuanTiDetailTableViewCell : UITableViewCell
@property (nonatomic, strong)ArticleSectionsModel *model;
@property (nonatomic, copy) ZhuanTiDetailBlock block;
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier block:(ZhuanTiDetailBlock)block;
@end
