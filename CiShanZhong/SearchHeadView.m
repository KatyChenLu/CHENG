//
//  SearchHeadView.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/15.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "SearchHeadView.h"

@implementation SearchHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = BLUECOLOR;
        
        //添加顶部文字label
        self.headTextLabel = [[UILabel alloc] init];
        self.headTextLabel.textColor = BLUECOLOR;
        self.headTextLabel.font = [UIFont systemFontOfSize:20];
        self.headTextLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.headTextLabel];
    }
    
    return self;
}

+ (instancetype)headView
{
  SearchHeadView *head = [[self alloc] init];
    
    return head;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //重新布局headView的子控件
    self.headTextLabel.frame = CGRectMake(20, 0, self.bounds.size.width - 20, self.bounds.size.height);
}


@end
