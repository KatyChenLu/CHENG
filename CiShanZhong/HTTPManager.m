//
//  HTTPManager.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/8.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "HTTPManager.h"

@implementation HTTPManager
+ (instancetype)manager
{
    HTTPManager *mgr = [super manager];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    
    [mgrSet addObject:@"text/html"];
    
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    return mgr;
}
@end
