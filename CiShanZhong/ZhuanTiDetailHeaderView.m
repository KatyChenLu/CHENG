//
//  ZhuanTiDetailHeaderView.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/9.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "ZhuanTiDetailHeaderView.h"
#import <UIImageView+WebCache.h>

@interface ZhuanTiDetailHeaderView ()
@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
@property (strong, nonatomic) IBOutlet UILabel *shangLAbel;
@property (strong, nonatomic) IBOutlet UILabel *xiaLAbel;

@end


@implementation ZhuanTiDetailHeaderView

+(instancetype)headerView
{
    ZhuanTiDetailHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZhuanTiDetailHeaderView" owner:nil options:nil] lastObject];
    return view;
}
- (void)awakeFromNib {
    // Initialization code
    
}
-(void)setModel:(ZhuanTiDetailModel *)model
{
    _model = model;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"IconDownloadLoading"]];
    _shangLAbel.text = _model.name;
    _xiaLAbel.text = _model.title;
}
@end
