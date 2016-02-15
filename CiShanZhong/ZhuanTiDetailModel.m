//
//  ZhuanTiDetailModel.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/6.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "ZhuanTiDetailModel.h"

@implementation ArticleSectionsModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"ZTDdescription",@"note.trip_id":@"NoteTripId",@"note.trip_name":@"NoteTripName",@"note.user_name":@"NoteUserName",@"attraction.name":@"AttractionName"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}


@end

@implementation ZhuanTiDetailModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ZTDid"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
