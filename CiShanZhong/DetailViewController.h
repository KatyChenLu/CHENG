//
//  DetailViewController.h
//  CiShanZhong
//
//  Created by KatyChn on 15/12/28.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSportLight.h"
#import "FeaturedModel.h"

@interface DetailViewController : UIViewController
{
    XSportLight *SportLight ;
}
@property (nonatomic, copy)NSString *Id;
@property (nonatomic, strong)NSMutableArray *CtextArray;
@property (nonatomic, copy)FeaturedModel *fModel;
@property (nonatomic, copy)NSString *ShareTitle;


@end
