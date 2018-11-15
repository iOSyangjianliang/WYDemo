//
//  OpenGLView.h
//  OpenGL基本使用
//
//  Created by 杨建亮 on 2018/11/14.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenGLView : UIView
{
    CAEAGLLayer *_glesLayer;
    EAGLContext *_glContext;
}

@end

NS_ASSUME_NONNULL_END
