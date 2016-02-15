//
//  XingChengModel.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/5.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface XingChengModel : JSONModel
@property (nonatomic, copy)NSString *XCid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *XCdescription;
@property (nonatomic, copy)NSString *plan_days_count;
@property (nonatomic, copy)NSString *plan_nodes_count;
@property (nonatomic, copy)NSString *image_url;

@end
