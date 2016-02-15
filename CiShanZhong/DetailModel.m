//
//  DetailModel.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/28.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "DetailModel.h"

//@implementation NotesLikeCommentsModel
//
//@end

@implementation NotesModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"Ddescription",@"photo.url":@"photoUrl"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation NodesModel

+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"Ddescription"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation TripDaysModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"destination.id":@"destinationId",@"destination.name_zh_cn":@"destinationNameZhCn"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


@implementation DetailModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Did",@"user.id":@"userID",@"user.name":@"userName",@"user.image":@"userImage"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
