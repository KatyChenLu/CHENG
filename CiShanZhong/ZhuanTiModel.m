//
//  ZhuanTiModel.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/5.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "ZhuanTiModel.h"

@implementation ZhuanTiModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ZTid"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
