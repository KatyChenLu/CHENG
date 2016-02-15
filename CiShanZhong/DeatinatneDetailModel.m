//
//  DeatinatneDetailModel.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/3.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "DeatinatneDetailModel.h"

@implementation ContentsModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
@implementation NoteModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"intro.notes":@"notesArray",@"description":@"Ndescription"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation DeatinatneDetailModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Did"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
