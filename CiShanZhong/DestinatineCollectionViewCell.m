//
//  DestinatineCollectionViewCell.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/2.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "DestinatineCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface DestinatineCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *enNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;


@end

@implementation DestinatineCollectionViewCell
-(void)setModel:(DestinationsModel *)model {
    _model = model;
    NSURL *imageUrl = [NSURL URLWithString:_model.image_url];
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"IconDownloadLoading"]];
    self.nameLabel.text = _model.name_zh_cn;
    self.enNameLabel.text = _model.name_en;
    self.numLabel.text = [NSString stringWithFormat:@"%@旅行地",_model.poi_count];
    
}
-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
}
- (void)awakeFromNib {
    // Initialization code
}

@end
