//
//  ImageCellOfFriends.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "ImageCellOfFriends.h"

@implementation ImageCellOfFriends

- (void)awakeFromNib {
    
    self.sendImageOfFriends.userInteractionEnabled = YES;
    
    //双击放大
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired=2;
    tap.numberOfTouchesRequired=1;
    [self.sendImageOfFriends addGestureRecognizer:tap];
    
    //长按缩小
    UILongPressGestureRecognizer *longP=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPAction:)];
    longP.numberOfTapsRequired=0;
    longP.numberOfTouchesRequired=1;
    longP.minimumPressDuration=1;//设置长按时间为1S
    [self.sendImageOfFriends addGestureRecognizer:longP];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)tapAction:(UITapGestureRecognizer *)sender{
    
    self.sendImageOfFriends.frame = CGRectMake(0, 50, self.contentView.frame.size.width, 300);
    
}

-(void)longPAction:(UITapGestureRecognizer *)sender{
    
    self.sendImageOfFriends.bounds = CGRectMake(75, 13, 118, 144);
    
}




@end
