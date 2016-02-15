//
//  ZhuanTiTableViewCell.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/5.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "ZhuanTiTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface ZhuanTiTableViewCell   ()
@property (weak, nonatomic) IBOutlet UIImageView *zhuanTiImage;

@property (weak, nonatomic) IBOutlet UILabel *shangLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiaLabel;



@end

@implementation ZhuanTiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(ZhuanTiModel *)model {
    _model = model;
    [_zhuanTiImage sd_setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"IconDownloadLoading"]];
    _shangLabel.text = _model.name;
    _shangLabel.font = XIFONF;
    _xiaLabel.text = _model.title;
    _xiaLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
