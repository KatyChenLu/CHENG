
#import <Foundation/Foundation.h>
/*
 数据管理
 按照单例设计模式 进行 设计
 存储 收藏/下载/浏览记录
 //增删改查数据
 */

#import "FMDatabase.h"
#import "FeaturedModel.h"
@interface DBManager : NSObject
//非标准单例
+ (DBManager *)sharedManager;
//增加 数据 收藏/浏览/下载记录


//存储类型 favorites downloads browses
- (void)insertModel:(FeaturedModel *)model;
//删除指定的应用数据
- (void)deleteModelForMid:(NSString *)Mid;

//查找所有的记录
- (NSArray *)readModels;

//返回 这条记录在数据库中是否存在
- (BOOL)isExistAppForMid:(NSString *)Mid;


@end


