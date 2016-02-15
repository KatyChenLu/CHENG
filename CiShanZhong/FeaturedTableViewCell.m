//
//  FeaturedTableViewCell.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/26.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "FeaturedTableViewCell.h"
#import "UIView+Common.h"
#import <UIImageView+WebCache.h>

@implementation FeaturedTableViewCell {
    UILabel *_titleLabel;
    UILabel *_daysLabel;
    UIImageView *_image;
    UIImageView *_bestImageView;
    UIImageView *_bsImageView;
    UIImageView *_iconImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customViews];
    }
    return self;
}
- (void)customViews {
    _titleLabel = [UILabel new];
    _daysLabel = [UILabel new];
    _image = [UIImageView new];
    _bestImageView = [UIImageView new];
    _bsImageView = [UIImageView new];
    _iconImageView = [UIImageView new]
    ;
    
    
    _titleLabel.textColor = WHITECOLOR;
    _titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:23];
    [_titleLabel setNumberOfLines:0];
    
    _daysLabel.textColor = WHITECOLOR;
    _daysLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:20];
    
    
    
    _image.contentMode = UIViewContentModeScaleAspectFill;
 
    
    
    _bsImageView.image = [UIImage imageNamed:@"CustomBarBackground"];//20*128
    _iconImageView.layer.borderWidth = 2;
    _iconImageView.layer.borderColor = [WHITECOLOR CGColor];
    _iconImageView.layer.cornerRadius = 15;
    _iconImageView.layer.masksToBounds = YES;
    
    [_bsImageView addSubview:_titleLabel];
    [_bsImageView addSubview:_daysLabel];
    [_image addSubview:_bsImageView];
    [_image addSubview:_iconImageView];
    [self.contentView addSubview:_image];
    [_bsImageView addSubview:_bestImageView];
}

-(void)setModel:(FeaturedModel *)model {
    _model = model;
    
    _titleLabel.text = _model.name;
    if (_model.start_date != NULL) {
         _daysLabel.text = [NSString stringWithFormat:@"%@/%@天,%@图",_model.start_date,_model.days,_model.photos_count];
    } else {
         _daysLabel.text = [NSString stringWithFormat:@"%@天,%@图",_model.days,_model.photos_count];
    }
   
    [_image sd_setImageWithURL:[NSURL URLWithString:_model.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"IconDownloadLoading"]];
    if (_model.featured == true) {
         _bestImageView.image = [UIImage imageNamed:@"FlagBest"];//66*26
    }
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.userImage]];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftPadding = 10;
    CGFloat topPadding = 10;
    _image.frame = CGRectMake(leftPadding/2, 0, screenWidth()-leftPadding, screenWidth()*0.58);//640*370
    _titleLabel.frame = CGRectMake(leftPadding, topPadding, screenWidth(), 40);
    _daysLabel.frame = CGRectMake(leftPadding, maxY(_titleLabel), screenWidth(), 30);
    _bsImageView.frame = CGRectMake(0, 0, screenWidth()-leftPadding, 128);
    _bestImageView.frame = CGRectMake(screenWidth()-leftPadding/2-2-66, topPadding, 66, 26);
    _iconImageView.frame = CGRectMake(leftPadding, screenWidth()*0.58-topPadding-40, 40, 40);
       _image.clipsToBounds = YES;
    
    
    
    self.transform = CGAffineTransformMakeScale(0.9, 0.9);
        self.alpha = 0.5;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            weakSelf.transform = CGAffineTransformMakeScale(1, 1);
            weakSelf.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
