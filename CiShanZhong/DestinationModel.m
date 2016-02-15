//
//  DestinationModel.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/31.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "DestinationModel.h"

@implementation DestinationsModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Did"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation DestinationModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
