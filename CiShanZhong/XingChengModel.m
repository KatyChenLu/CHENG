//
//  XingChengModel.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/5.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "XingChengModel.h"

@implementation XingChengModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"XCid",@"description":@"XCdescription"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
