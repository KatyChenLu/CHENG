//
//  LXDCell.m
//  ChanYouJi
//
//  Created by 刘宁 on 15/12/15.
//  Copyright (c) 2015年 刘宁. All rights reserved.
//
#define ImageView_width 100
#define Gap 10

#import "LXDCell.h"
#import "LXDModel.h"
#import "LXDImageView.h"
#import "StarsView.h"
#import "UIView+Common.h"
@implementation LXDCell
{
    LXDImageView * _imageView;
    StarsView * _stars;
    UILabel * _name;
    UILabel * _subName;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加UI
        [self addUI];
    }
    return self;
}

-(void)addUI
{
    //图片
    _imageView = [[LXDImageView alloc]init];
    _imageView.frame = CGRectMake(Gap, Gap, ImageView_width, 80);
    [self.contentView addSubview:_imageView];
    
    //姓名
    _name = [[UILabel alloc]init];
    _name.textAlignment = NSTextAlignmentLeft;
    _name.font = [UIFont systemFontOfSize:16];
    _name.textColor = [UIColor blackColor];
    [self.contentView addSubview:_name];
    
    //星级
    _stars = [[StarsView alloc]init];
    [self.contentView addSubview:_stars];
    
    //其他信息
    _subName = [[UILabel alloc]init];
    _subName.numberOfLines = 0;
    _subName.lineBreakMode = NSLineBreakByWordWrapping;
    _subName.textAlignment = NSTextAlignmentLeft;
    _subName.font = [UIFont systemFontOfSize:14];
    _subName.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_subName];
    
}


-(void)setModel:(LXDModel *)model
{
    _model = model;
    
    //name
    NSString * name = model.name;
    NSDictionary * nameAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize nameSize = [name sizeWithAttributes:nameAttribute];
    _name.frame = CGRectMake(ImageView_width+2*Gap, Gap*3, nameSize.width, nameSize.height);
    _name.text = name;
    
    
    //星级
    UIImage * image = [UIImage imageNamed:@"StarsBackground"];
    _stars.frame = CGRectMake(_name.frame.origin.x, CGRectGetMaxY(_name.frame)+10, image.size.width, image.size.height);
    _stars.statrs = [model.user_score floatValue];
    [self.contentView addSubview:_stars];
    
    
    //subName
    NSString * subName = [NSString stringWithFormat:@"%@\n%@",model.description_summary,model.description_Detail];
    NSDictionary * subNameAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize maxSize = CGSizeMake(screenWidth() - 2*Gap, CGFLOAT_MAX);
    
    
    CGSize subNameSize = [subName boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:subNameAttribute context:nil].size;
    _subName.frame = CGRectMake(Gap, CGRectGetMaxY(_imageView.frame)+10, subNameSize.width, subNameSize.height);
    _subName.text = subName;
    
    
   
    _imageView.image_ur = model.image_url;
    _imageView.number = model.attraction_trips_count;
    
    model.cellHight = [NSString stringWithFormat:@"%f",CGRectGetMaxY(_subName.frame)+Gap];
}


@end
