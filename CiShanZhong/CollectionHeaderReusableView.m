//
//  CollectionHeaderReusableView.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/2.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "CollectionHeaderReusableView.h"

@interface CollectionHeaderReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CollectionHeaderReusableView
-(void)updateTitle:(NSInteger)number {
    
    switch (number) {
        case 1:
            self.titleLabel.text = @"亚洲";
            break;
        case 2:
            self.titleLabel.text = @"欧洲";
            break;
        case 3:
            self.titleLabel.text = @"美洲、大洋洲、非洲与南极洲";
            break;
        case 99:
            self.titleLabel.text = @"港澳台";
            break;
        case 999:
            self.titleLabel.text = @"大陆";
            break;
        default:
            break;
    }

}
- (void)awakeFromNib {
    // Initialization code
}

@end
