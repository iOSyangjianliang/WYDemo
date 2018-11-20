//
//  OpenGLView.m
//  OpenGL基本使用
//
//  Created by 杨建亮 on 2018/11/14.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "OpenGLView.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface OpenGLView ()

@end
@implementation OpenGLView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupLayer];
        [self setupContext];
    }
    return self;
}
-(void)setupLayer
{
    _glesLayer = (CAEAGLLayer *)self.layer;
    _glesLayer.opaque = YES;//设置不透明
}
-(void)setupContext
{
    _glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (![EAGLContext setCurrentContext:_glContext]) {
        NSLog(@"error");
    }
    
//    ToyGLFrameBuffer::sharedFrameBuffer()->setGLcolorBuffer();
//    [toyContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:toyLayer];
//    ToyGLFrameBuffer::sharedFrameBuffer()->setGLdepthBuffer();
//    ToyGLFrameBuffer::sharedFrameBuffer()->setGLframeBuffer();
//    
//    ToyGLFrameBuffer::sharedFrameBuffer()->setGLBuffer();
//    
//    ToyGLFrameBuffer::sharedFrameBuffer()->setViewport(0, 0, self.frame.size.width, self.frame.size.height);
//    ToyGLFrameBuffer::sharedFrameBuffer()->setScissor(0, 0, self.frame.size.width, self.frame.size.height);
//    
//    ToyDirector::sharedDirector()->setFrameSize(self.frame.size.width, self.frame.size.height);
    
 }
- (void)presentGLview {
    [_glContext presentRenderbuffer:GL_RENDERBUFFER];
}



+(Class)layerClass
{
    return [CAEAGLLayer class];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
