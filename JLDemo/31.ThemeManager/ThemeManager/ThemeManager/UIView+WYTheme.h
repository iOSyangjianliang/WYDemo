//
//  UIView+WYTheme.h
//  ThemeManager
//
//  Created by 杨建亮 on 2018/6/11.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "ThemeManager.h"

typedef void(^UpdateHandler)(ThemeManager *manage);
@interface UIView (WYTheme)
@property (nonatomic, copy) UpdateHandler updateHandler;

@end
