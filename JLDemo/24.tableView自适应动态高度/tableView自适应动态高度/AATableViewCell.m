//
//  AATableViewCell.m
//  tableView自适应动态高度
//
//  Created by 杨建亮 on 2018/5/7.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AATableViewCell.h"

@implementation AATableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(BOOL)canResignFirstResponder
{
    return NO;// !self.jltextView.isFirstResponder;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
