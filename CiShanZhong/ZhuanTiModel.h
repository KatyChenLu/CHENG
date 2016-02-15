//
//  ZhuanTiModel.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/5.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZhuanTiModel : JSONModel
@property (nonatomic, copy)NSString *ZTid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *destination_id;
@end
