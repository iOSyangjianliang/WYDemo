//
//  UIView+FrameHelp.h
//  YiShangbao
//
//  Created by 杨建亮 on 2017/7/27.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameHelp)

/**自定义了x，y，w，h,可快速set／get属性值*/
@property (nonatomic, assign) CGFloat jl_height;
@property (nonatomic, assign) CGFloat jl_width;
@property (nonatomic, assign) CGFloat jl_y;
@property (nonatomic, assign) CGFloat jl_x;
@end
