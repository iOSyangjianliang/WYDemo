//
//  UILabel+TextCopy.h
//  Label分类byRunTime
//
//  Created by 杨建亮 on 2018/6/4.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextDidCopyHandler)(UILabel *label);
@interface UILabel (TextCopy)
@property (nonatomic, assign) BOOL isNeedCopy;
@property (nonatomic, strong, nullable) UILongPressGestureRecognizer * longCopyPressGesture;
@property (nonatomic, copy) TextDidCopyHandler textDidCopyHandler;
@end
