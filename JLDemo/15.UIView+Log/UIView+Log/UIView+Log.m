//
//  UIView+Log.m
//  UIView+Log
//
//  Created by 杨建亮 on 2017/12/5.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//


#import "UIView+Log.h"

@implementation UIView (Log)

+ (void)zhNSLogSubviewsFromView:(UIView *)view andLevel:(NSInteger)level
{
    NSArray *subviews = [view subviews];
    // 如果没有子视图就直接返回
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        
        // 根据层级决定前面空格个数，来缩进显示
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        // 打印子视图类名,不能用这个函数宏，无法打包
        NSLitLog(@"%@%ld: %@", blank, level, subview.class);
        // 递归获取此视图的子视图
        [self zhNSLogSubviewsFromView:subview andLevel:(level+1)];
        
    }
}

@end
