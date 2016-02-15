//
//  DestinationDetailTableViewCell.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/3.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeatinatneDetailModel.h"

typedef void(^BlockButton)(NSInteger tag);

@interface DestinationDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)DeatinatneDetailModel *model;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIButton *gonglueButton;

@property (weak, nonatomic) IBOutlet UIButton *xingchengButton;
@property (weak, nonatomic) IBOutlet UIButton *lvxingButton;

@property (weak, nonatomic) IBOutlet UIButton *zhuantiButton;
@property (weak, nonatomic) IBOutlet UILabel *gonglueLabel;
@property (weak, nonatomic) IBOutlet UILabel *xingchengLabel;
@property (weak, nonatomic) IBOutlet UILabel *lvXingLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuanTiLabel;
@property (nonatomic, copy) BlockButton button;
//自定义block方法
//- (void)handlerButtonAction:(BlockButton)block;








@end
