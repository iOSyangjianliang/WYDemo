//
//  UIView+WYTheme.m
//  ThemeManager
//
//  Created by 杨建亮 on 2018/6/11.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "UIView+WYTheme.h"

static const char *key_updateHandler = (void *)@"key_updateHandler";
@implementation UIView (WYTheme)
- (void)setUpdateHandler:(UpdateHandler)updateHandler
{
    objc_setAssociatedObject(self, key_updateHandler, updateHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (UpdateHandler)updateHandler
{
    return objc_getAssociatedObject(self, key_updateHandler);
}


@end
