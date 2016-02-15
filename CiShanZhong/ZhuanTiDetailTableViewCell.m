//
//  ZhuanTiDetailTableViewCell.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/7.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "ZhuanTiDetailTableViewCell.h"
#import <UIButton+WebCache.h>
#import "UIView+Common.h"
#import "DetailViewController.h"

@interface ZhuanTiDetailTableViewCell () {
    NSString *_imageId;
}
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageButtonHeight;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titilLabelheight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *kuaiViewHeight;
@property (strong, nonatomic) IBOutlet UIImageView *ArticleImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ArticleHeight;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userHeight;

@end

@implementation ZhuanTiDetailTableViewCell
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier block:(ZhuanTiDetailBlock)block
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        _block = block;
//    }
//    return self;
//}
- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(ArticleSectionsModel *)model {
    _model = model;
    
    if (_model.image_url.length > 0) {
        [_imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.image_url] forState:UIControlStateNormal];
        [_imageButton addTarget:self action:@selector(touchesImagButton) forControlEvents:UIControlEventTouchUpInside];
        if (_model.NoteTripName||_model.NoteUserName) {
                 _userLabel.text = [NSString stringWithFormat:@"%@\n%@",_model.NoteTripName,_model.NoteUserName];
        }
  
        _imageId = _model.NoteTripId;
        
        _ArticleHeight.constant = 70;
        _userHeight.constant = 50;
         _imageButtonHeight.constant = 300;
        _titilLabelheight.constant = 0;
        _kuaiViewHeight.constant = 0;
        _descLabel.text = _model.ZTDdescription;
        _descLabel.font = XIFONF;
        
        
    }else if (_model.title.length > 0) {
        _titleLabel.font = XIFONF;
        _titilLabelheight.constant = 20;
        _kuaiViewHeight.constant = 20;
        _ArticleHeight.constant = 0;
        _userHeight.constant = 0;
        _imageButtonHeight.constant = 0;
        _titleLabel.text = _model.title;
        _titleLabel.backgroundColor = BLUECOLOR;

        _descLabel.font = XIXIAOFONF;
        _descLabel.text = _model.ZTDdescription;
        
    }else if ([_model.title isEqualToString:@""]&&[_model.title isEqualToString:@""] ){
        
        _ArticleHeight.constant = 0;
        _userHeight.constant = 0;
        _imageButtonHeight.constant = 0;
        _titilLabelheight.constant = 0;
        _kuaiViewHeight.constant = 0;
        _descLabel.font = XIFONF;
        _descLabel.text = _model.ZTDdescription;
        
    }

    
}
- (void)touchesImagButton {
    _block(_model.NoteTripId);
}
- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
