//
//  MineDetailTableViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MineDetailTableViewCell.h"

@implementation MineDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _comentLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:20];
    
    _detailLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:20];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
