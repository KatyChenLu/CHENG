//
//  FavourtTableViewCell.m
//  FreeWeekend
//
//  Created by KatyChn on 15/12/21.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "FavourtTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+Common.h"
@interface FavourtTableViewCell (){
    UIImageView *_favourtImageView;
    UIImageView *_imageView;
    UILabel *_title;
}



@end



@implementation FavourtTableViewCell
-(void)setModel:(DetailModel *)model{
    
    _model = model;
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(0.05*screenWidth(), 0, 2, 0.5*screenWidth());
    label.layer.borderColor = [[UIColor colorWithRed:169/255.0  green:173/255.0 blue:177/255.0  alpha:1.0] CGColor];
    label.layer.borderWidth = 1;
    [_favourtImageView addSubview:label];
    UIImageView *imageh = [UIImageView new];
    imageh.image = [[UIImage imageNamed:@"ic_nav_black_heart_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imageh.frame = CGRectMake(0, 0, 20, 20);
    imageh.center = CGPointMake(label.center.x, 0.28*0.2*screenWidth());
    [_favourtImageView addSubview:imageh];

    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"loading_image"]];

    _title.text = model.name;
    _title.font = [UIFont fontWithName:@"Gotham-Light" size:15];
    _title.numberOfLines = 0;

}
- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self contentViews];
    }
    
    return  self;
}
- (void)contentViews {
    _favourtImageView = [UIImageView new];
    _imageView =[UIImageView new];
    _title  = [UILabel new];
    _title.textColor = [UIColor whiteColor];

    [self.contentView addSubview:_favourtImageView];
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_title];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat padding = 10;
    _favourtImageView.frame = CGRectMake(0, 0, 0.1*screenWidth(), 0.5*screenWidth());
    _title.frame = CGRectMake(maxX(_favourtImageView), 0,screenWidth() - maxX(_favourtImageView)-2*padding , 0.2*screenWidth());
    _imageView.frame = CGRectMake(maxX(_favourtImageView), maxY(_title), 0.5*screenWidth(), 0.3*screenWidth());
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
