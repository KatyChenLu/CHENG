//
//  FeaturedModel.h
//  CiShanZhong
//
//  Created by KatyChn on 15/12/26.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FeaturedModel : JSONModel
@property (nonatomic, copy)NSString *Mid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *photos_count;
@property (nonatomic, copy)NSString *start_date;
@property (nonatomic, copy)NSString *end_date;
@property (nonatomic, copy)NSString *days;
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSString *views_count;
@property (nonatomic, copy)NSString *comments_count;
@property (nonatomic, copy)NSString *likes_count;
@property (nonatomic, copy)NSString *source;
@property (nonatomic, copy)NSString *front_cover_photo_url;
@property (nonatomic, assign)BOOL featured;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *userImage;
@end
