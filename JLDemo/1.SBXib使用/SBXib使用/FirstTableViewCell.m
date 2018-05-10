//
//  FirstTableViewCell.m
//  SBXib使用
//
//  Created by 海狮 on 17/5/28.
//  Copyright © 2017年 海狮. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(CGFloat)getCellHeightWithData:(id)data
{

    return arc4random()%200+200;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
