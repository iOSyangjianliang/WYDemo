//
//  UIView+Log.h
//  UIView+Log
//
//  Created by 杨建亮 on 2017/12/5.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

//不能用，一旦用了，会无法打包
#ifndef __OPTIMIZE__
#define NSLitLog(format, ...) printf(" %s\n", [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#endif

#import <UIKit/UIKit.h>

@interface UIView (Log)

/**
 按层级打印某个view所有子视图

 @param view 要打印的view
 @param level 从第几级开始打印查看
 */
+ (void)zhNSLogSubviewsFromView:(UIView *)view andLevel:(NSInteger)level;
@end
