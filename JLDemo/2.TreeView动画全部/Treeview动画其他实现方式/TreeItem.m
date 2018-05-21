//
//  TreeItem.m
//  test
//
//  Created by 海狮 on 17/5/13.
//  Copyright © 2017年 海狮. All rights reserved.
//

#import "TreeItem.h"

@implementation TreeItem
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2.f;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
