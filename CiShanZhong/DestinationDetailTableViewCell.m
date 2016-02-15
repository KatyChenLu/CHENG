//
//  DestinationDetailTableViewCell.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/3.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "DestinationDetailTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "GongLueViewController.h"
#import "UIView+Common.h"

@implementation DestinationDetailTableViewCell

- (void)awakeFromNib {

}

-(void)setModel:(DeatinatneDetailModel *)model {
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",_model.name_zh_cn,_model.name_en];
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:_model.image_url]];
    _gonglueButton.layer.borderWidth = 3;
    _gonglueButton.layer.borderColor = [BLUECOLOR CGColor];
    _xingchengButton.layer.borderWidth = 3;
    _xingchengButton.layer.borderColor = [BLUECOLOR CGColor];
    _lvxingButton.layer.borderWidth = 3;
    _lvxingButton.layer.borderColor = [BLUECOLOR CGColor];
    _zhuantiButton.layer.borderWidth = 3;
    _zhuantiButton.layer.borderColor = [BLUECOLOR CGColor];
    
}
- (IBAction)gonglueButtonAction:(id)sender {
//    self.gonglueLabel.textColor = [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:0.5];
//    UIView *gonglueView = [UIView new];
//        UIView *backgroundView = [UIView new];
//        backgroundView.frame = CGRectMake(0, 0, screenWidth(), screenHeight());
//        backgroundView.backgroundColor = [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:0.5];
//        gonglueView.frame = CGRectMake(10, 10, screenWidth()-20, screenHeight()-20);
//        backgroundView.center = CGPointMake(screenWidth()/2, screenHeight()/2*3);
//    
//        gonglueView.backgroundColor = [UIColor redColor];
//        [backgroundView addSubview:gonglueView];
//    
//    
//        [self.superview addSubview:backgroundView];
//        [UIView animateWithDuration:0.7 animations:^{
//            backgroundView.center = CGPointMake(screenWidth()/2, screenHeight()/2-20);
//        } completion:^(BOOL finished) {
//          [UIView animateWithDuration:0.3 animations:^{
//               backgroundView.center = CGPointMake(screenWidth()/2, screenHeight()/2);
//          }];
//        }];
    UIButton *button = (UIButton *)sender;
    _button(button.tag);
}
- (IBAction)xingchengAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    _button(button.tag);
}
- (IBAction)lvxingAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    _button(button.tag);
}
- (IBAction)zhuantiAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    _button(button.tag);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    NSLog(@"666");
}

@end
