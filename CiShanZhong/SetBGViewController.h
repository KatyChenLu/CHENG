//
//  SetBGViewController.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/12.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PassValueHandler)(NSString *bgName);

@interface SetBGViewController : UIViewController

@property (nonatomic, copy)NSString *selectedImageName;
@property (nonatomic, copy)PassValueHandler passValueHandler;
- (void)setPassValueHandler:(PassValueHandler)passValueHandler;

@end
