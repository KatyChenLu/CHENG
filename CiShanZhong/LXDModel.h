//
//  LXDModel.h
//  ChanYouJi
//
//  Created by 刘宁 on 15/12/15.
//  Copyright (c) 2015年 刘宁. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LXDModel : JSONModel
@property (nonatomic,copy) NSString * attraction_trips_count;
@property (nonatomic,copy) NSString<Optional> * description_Detail;
@property (nonatomic,copy) NSString * description_summary;
@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString * image_url;
@property (nonatomic,copy) NSString<Optional> * name;
@property (nonatomic,copy) NSString<Optional> * name_en;
@property (nonatomic,copy) NSString<Optional> * user_score;


@property (nonatomic) NSString<Optional> *  cellHight;
@end
