//
//  HotTableViewCell.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/15.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "HotTableViewCell.h"

// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
// 这个头文件一定要放在上面两个宏的后面
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#import <Masonry/Masonry.h>
#import "UIView+Common.h"
#import "HotTableViewCell.h"
#import "SearchHeadView.h"
@interface HotTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *hotButton1;
@property (weak, nonatomic) IBOutlet UIButton *hotButton2;
@property (weak, nonatomic) IBOutlet UIButton *hotButton3;
@property (weak, nonatomic) IBOutlet UIButton *hotButton4;

@end

@implementation HotTableViewCell


- (void)awakeFromNib {
    [self setUpBtn:self.hotButton1];
    [self setUpBtn:self.hotButton2];
    self.hotButton2.backgroundColor = self.hotButton1.backgroundColor;
    [self setUpBtn:self.hotButton3];
    self.hotButton3.backgroundColor = self.hotButton1.backgroundColor;
    [self setUpBtn:self.hotButton4];
    self.hotButton4.backgroundColor = self.hotButton1.backgroundColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUpBtn:(UIButton *)button
{
    button.layer.masksToBounds = YES;
    CGFloat cor = (button.bounds.size.height / 2 ) * 0.95;
    button.layer.cornerRadius = cor;
}

- (void)setHotDatas:(NSMutableArray *)hotDatas
{
    _hotDatas = hotDatas;
    
    //判断是长度是否是4,开发中可以这样写 应该服务器返回几条数据就赋值多少,而不是固定的写死数据,万一服务器返回的数据有错误,会造成用户直接闪退的,有时在某些不是很重要的东西无法确定返回的是否正确,建议用 @try    @catch来处理,
    //即便返回的数据有误,也可以让用户继续别的操作，而不会在无关紧要的小细节上造成闪退
    if (hotDatas.count == 4) {
        [self.hotButton1 setTitle:hotDatas[1] forState:UIControlStateNormal];
        [self.hotButton2 setTitle:hotDatas[0] forState:UIControlStateNormal];
        [self.hotButton3 setTitle:hotDatas[2] forState:UIControlStateNormal];
        [self.hotButton4 setTitle:hotDatas[3] forState:UIControlStateNormal];
    }
    [self layoutIfNeeded];
    
    //算出间距
    CGFloat margin = (screenWidth()*0.6 - 40 - self.hotButton1.bounds.size.width - self.hotButton2.bounds.size.width - self.hotButton3.bounds.size.width - self.hotButton3.bounds.size.width) / 3;
   
    //更新约束
    [self.hotButton2 updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotButton1.right).offset(margin);
    }];
    
    [self.hotButton3 updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotButton2.right).offset(margin);
    }];
    
    [self.hotButton4 updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotButton3.right).offset(margin);
    }];
}

+ (instancetype)hotCellWithHotDatas:(NSArray *)hotDatas
{
    HotTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    cell.hotDatas = hotDatas;
    
    return cell;
}
- (IBAction)touchButton1:(UIButton *)sender {
    
}
- (IBAction)touchButton2:(id)sender {
}
- (IBAction)touchButton3:(id)sender {
}
- (IBAction)touchButton4:(UIButton *)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
