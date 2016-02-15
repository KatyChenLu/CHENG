//
//  HistoryTableViewCell.m
//  CiShanZhong
//
//  Created by KatyChn on 16/1/14.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import "HistoryTableViewCell.h"
#define SearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hisDatas.data"]
@interface HistoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;
/** 记录自己是哪个数据 */
@property (nonatomic, weak) NSIndexPath *indexPath;
/** 记录模型数据 */
@property (nonatomic, weak) NSMutableArray *hisDatas;
/** 记录tableView */
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (IBAction)buttonAction:(UIButton *)sender {
    
    [self.hisDatas removeObjectAtIndex:self.indexPath.row];
    
    [self.hisDatas writeToFile:SearchHistoryPath atomically:YES];
    
    [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

}
+ (instancetype)historyCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath atNSMutableArr:(NSMutableArray *)datas
{
    static NSString *identifier = @"HistoryTableViewCell";
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    cell.tableView = tableView;
    cell.hisDatas = datas;
    cell.indexPath = indexPath;
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
