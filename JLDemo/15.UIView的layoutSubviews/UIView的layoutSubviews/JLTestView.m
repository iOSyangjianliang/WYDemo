//
//  JLTestView.m
//  UIView的layoutSubviews
//
//  Created by 杨建亮 on 2018/4/25.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "JLTestView.h"

@implementation JLTestView

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"%ld==layoutSubviews调用了",self.tag);
}

@end
