//
//  ZhuanTiDetailModel.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/6.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol  ArticleSectionsModel
@end
@interface ArticleSectionsModel : JSONModel
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *ZTDdescription;
@property (nonatomic, copy)NSString *NoteTripId;
@property (nonatomic, copy)NSString *NoteTripName;
@property (nonatomic, copy)NSString *NoteUserName;

@property (nonatomic, copy)NSString *AttractionName; 


@end


@interface ZhuanTiDetailModel : JSONModel
@property (nonatomic, copy)NSString *ZTDid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSMutableArray <ArticleSectionsModel>*article_sections;
@end
