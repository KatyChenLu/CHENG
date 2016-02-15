//
//  HistoryTableViewCell.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/14.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *historyTextLabel;
+ (instancetype)historyCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath atNSMutableArr:(NSMutableArray *)datas;
@end
