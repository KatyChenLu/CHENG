//
//  LXDImageView.m
//  ChanYouJi
//
//  Created by 刘宁 on 15/12/15.
//  Copyright (c) 2015年 刘宁. All rights reserved.
//

#import "LXDImageView.h"
#import <UIImageView+WebCache.h>
@implementation LXDImageView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI
{
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    view.alpha = 0.5;
    [self addSubview:view];
    
    UILabel * label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.frame = view.bounds;
    label.tag = 11;
    [view addSubview:label];
}

-(void)setNumber:(NSString *)number
{
    _number = number;
    NSString * title = [NSString stringWithFormat:@"%@ 篇游记",number];
    UILabel * lable = (id)[self viewWithTag:11];
    lable.text = title;
}


-(void)setImage_ur:(NSString *)image_ur
{
    _image_ur = image_ur;
    [self sd_setImageWithURL:[NSURL URLWithString:image_ur]];
}


@end
