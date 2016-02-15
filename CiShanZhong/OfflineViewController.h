//
//  OfflineViewController.h
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "ListViewController.h"
@class CBStoreHouseRefreshControl;
@interface OfflineViewController : ListViewController
{
    NSMutableArray *_dataArray;
    UITableView *_appTableView;
    
}
@property (nonatomic, strong) CBStoreHouseRefreshControl *storeHouseRefreshControl;

@end
