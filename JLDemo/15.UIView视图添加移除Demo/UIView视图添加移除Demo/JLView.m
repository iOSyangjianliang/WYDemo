//
//  JLView.m
//  UIView视图添加移除Demo
//
//  Created by 杨建亮 on 2017/12/28.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "JLView.h"

@implementation JLView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)removeFromSuperview
{
    [super removeFromSuperview];
    NSLog(@"%s",__FUNCTION__);
}
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];
    NSLog(@"%s",__FUNCTION__);
}
- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2
{
    [super exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
    NSLog(@"%s",__FUNCTION__);
}
- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    NSLog(@"%s",__FUNCTION__);
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [super insertSubview:view belowSubview:siblingSubview];
    NSLog(@"%s",__FUNCTION__);
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [super insertSubview:view aboveSubview:siblingSubview];
    NSLog(@"%s",__FUNCTION__);
}

- (void)bringSubviewToFront:(UIView *)view
{
    [super bringSubviewToFront:view];
    NSLog(@"%s",__FUNCTION__);
}
- (void)sendSubviewToBack:(UIView *)view
{
    [super sendSubviewToBack:view];
    NSLog(@"%s",__FUNCTION__);
}
- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    NSLog(@"%s",__FUNCTION__);

}
- (void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];
    NSLog(@"%s",__FUNCTION__);

}
- (void)willMoveToSuperview:(nullable UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    NSString *str ;
    if (newSuperview) {
        str = @"存在";
//        NSLog(@"newSuperview=%@",newSuperview);
    }else{
        str = @"不存在";
    }
    NSLog(@"%s=>newSuperview%@",__FUNCTION__,str);

}
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    NSLog(@"%s",__FUNCTION__);

}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    NSString *str ;
    if (newWindow) {
        str = @"存在";
//        NSLog(@"newWindow=%@",newWindow);
    }else{
        str = @"不存在";
    }
    NSLog(@"%s=>newWindow%@",__FUNCTION__,str);
}
- (void)didMoveToWindow;
{
    [super didMoveToWindow];
    NSLog(@"%s",__FUNCTION__);
}

@end
