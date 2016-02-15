//
//  XingChengTableViewCell.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/5.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "XingChengTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface XingChengTableViewCell () {
    
}
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *jieShaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *shangLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiaLabel;

@end

@implementation XingChengTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(XingChengModel *)model {
    _model = model;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"IconDownloadLoading"]];
    self.jieShaoLabel.text = _model.XCdescription;
    self.jieShaoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
    self.shangLabel.backgroundColor = [UIColor clearColor];
    
    self.shangLabel.text = _model.name;
    self.shangLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    self.xiaLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
    self.xiaLabel.text = [NSString stringWithFormat:@"%@天/%@个旅行地",_model.plan_days_count,_model.plan_nodes_count];
    
}
@end
