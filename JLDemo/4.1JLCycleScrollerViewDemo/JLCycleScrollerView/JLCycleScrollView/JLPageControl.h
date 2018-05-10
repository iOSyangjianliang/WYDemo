//
//  JLPageControl.h
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/1.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JLPageControlStyle) {
    JLPageControlImageStyle    = 0,    //图片“- - -”样式(居中)
    JLPageControlSystemStyle   = 1,    //默认“.....”样式

};

@interface JLPageControl : UIPageControl
@property(nonatomic,assign)JLPageControlStyle style;
@end
