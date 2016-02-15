//
//  DestinationModel.h
//  CiShanZhong
//
//  Created by KatyChn on 15/12/31.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol DestinationsModel
@end

@interface DestinationsModel : JSONModel
@property (nonatomic, copy)NSString *Did;
@property (nonatomic, copy)NSString *name_zh_cn;
@property (nonatomic, copy)NSString *name_en;
@property (nonatomic, copy)NSString *poi_count;
@property (nonatomic, copy)NSString *lat;
@property (nonatomic, copy)NSString *lng;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *updated_at;

@end


@interface DestinationModel : JSONModel
@property (nonatomic, copy)NSString *category;
@property (nonatomic, strong)NSMutableArray <DestinationsModel>*destinations;
@end
