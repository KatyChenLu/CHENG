//
//  FeaturedModel.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/26.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "FeaturedModel.h"

@implementation FeaturedModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Mid",@"user.id":@"userId",@"user.name":@"userName",@"user.image":@"userImage"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
