//
//  UILabel+TextCopy.m
//  Label分类byRunTime
//
//  Created by 杨建亮 on 2018/6/4.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "UILabel+TextCopy.h"
#import <objc/runtime.h>

@implementation UILabel (TextCopy)

//+(void)initialize(当类第一次被调用的时候就会调用该方法,整个程序运行中只会调用一次)
//+ (void)load(当程序启动的时候就会调用该方法,换句话说,只要程序一启动就会调用load方法,整个程序运行中只会调用一次)

+ (void)load
{

//    Class class =   objc_getClass("UILabel");
//
//    // 交换方法实现,方法都是定义在类里面
//    // class_getMethodImplementation:获取类方法实现
//    // class_getInstanceMethod:获取对象方法
//    // class_getClassMethod:获取类方法
//    // IMP:方法实现
//
//    // imageNamed
//    // Class:获取哪个类方法
//    // SEL:获取方法编号,根据SEL就能去对应的类找方法
//    // +类方法
//    Method fromMethod = class_getClassMethod(class, @selector(setText:));
//    // xmg_imageNamed
//    Method toMethod = class_getClassMethod(class, @selector(jl_TextNamed:));
//    // 交换方法实现
//    method_exchangeImplementations(fromMethod, toMethod);
    
    

    Class clLabel = [self class];
    
    SEL originSelector_BFR = @selector(canBecomeFirstResponder);
    SEL swizzleSelector_BFR = @selector(jl_canBecomeFirstResponder);
    // 实例-方法
    Method originMethod_BFR = class_getInstanceMethod(clLabel, originSelector_BFR);
    Method swizzleMethod_BFR = class_getInstanceMethod(clLabel, swizzleSelector_BFR);
    // 动态添加方法 实现是被交换的方法  还回值表示添加成功还是失败
    BOOL addMethod_BFR = class_addMethod(clLabel, originSelector_BFR, method_getImplementation(swizzleMethod_BFR), method_getTypeEncoding(swizzleMethod_BFR));

    if (addMethod_BFR) {
        //如果成功 说明类中不存在这个方法的实现
        //将被交换方法的实现替换到这个并不存在的实现
        class_replaceMethod(clLabel, swizzleSelector_BFR, method_getImplementation(originMethod_BFR), method_getTypeEncoding(originMethod_BFR));
    }else {
        //否则交换两个方法的实现
        method_exchangeImplementations(originMethod_BFR, swizzleMethod_BFR);
    }

    SEL originSelector_RFR = @selector(resignFirstResponder);
    SEL swizzleSelector_RFR = @selector(jl_resignFirstResponder);
    Method originMethod_RFR = class_getInstanceMethod(clLabel, originSelector_RFR);
    Method swizzleMethod_RFR = class_getInstanceMethod(clLabel, swizzleSelector_RFR);
    BOOL addMethod_RFR  = class_addMethod(clLabel, originSelector_RFR, method_getImplementation(swizzleMethod_RFR), method_getTypeEncoding(swizzleMethod_RFR));
    if (addMethod_RFR) {
        class_replaceMethod(clLabel, swizzleSelector_RFR, method_getImplementation(originMethod_RFR), method_getTypeEncoding(originMethod_RFR));
    }else {
        method_exchangeImplementations(originMethod_RFR, swizzleMethod_RFR);
    }
    
    SEL originSelector_CPF = @selector(canPerformAction:withSender:);
    SEL swizzleSelector_CPF = @selector(jl_canPerformAction:withSender:);
    Method originMethod_CPF  = class_getInstanceMethod(clLabel, originSelector_CPF );
    Method swizzleMethod_CPF  = class_getInstanceMethod(clLabel, swizzleSelector_CPF );
    BOOL addMethod = class_addMethod(clLabel, originSelector_CPF, method_getImplementation(swizzleMethod_CPF), method_getTypeEncoding(swizzleMethod_CPF));
    if (addMethod) {
        class_replaceMethod(clLabel, swizzleSelector_CPF, method_getImplementation(originMethod_CPF), method_getTypeEncoding(originMethod_CPF));
    }else {
        method_exchangeImplementations(originMethod_CPF, swizzleMethod_CPF);
    }
}
-(BOOL)jl_canBecomeFirstResponder
{
    if (self.isNeedCopy) {
        return YES;
    }
    return [self jl_canBecomeFirstResponder];
}
-(BOOL)jl_resignFirstResponder
{
    if (self.isNeedCopy) {
        //重置为系统默认
        [[UIMenuController sharedMenuController] setMenuItems:nil];
    }
    return [self jl_resignFirstResponder];

}
-(BOOL)jl_canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(jl_customCopyAction:)) {
        return YES;
    }
    return [self jl_canPerformAction:action withSender:sender];
}
- (void)jl_customCopyAction:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    if (self.text) {
        [pboard setString:self.text];
        if (self.textDidCopyHandler) {
            self.textDidCopyHandler(self);
        }
    }
}
-(void)setTextDidCopyHandler:(TextDidCopyHandler)textDidCopyHandler
{
    objc_setAssociatedObject(self, @"textDidCopyHandler", textDidCopyHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(TextDidCopyHandler)textDidCopyHandler
{
    return objc_getAssociatedObject(self, @"textDidCopyHandler");
}
- (void)setIsNeedCopy:(BOOL)isNeedCopy
{
    
    [self needCopyingLongPressGestureRecognizer:isNeedCopy];
    // 设置标记为"isNeedCopy"(可以根据该标记来获取引用的对象isNeedCopy，标记可以为任意字符，只要setter和getter中的标记一致就可以)
    /**
     *  为某个类关联某个对象
     *
     *  @param object#> 要关联的对象
     *  @param key#>    要关联的属性key (因为可能要添加很多属性)
     *  @param value#>  你要关联的属性
     *  @param policy#> 添加的成员变量的修饰符
     */
    objc_setAssociatedObject(self, @"isNeedCopy", @(isNeedCopy), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isNeedCopy
{
    // 根据“isNeedCopy”标识取对象(self)强引用的isNeedCopy对象
    // 参数1：源对象
    // 参数2：关联时用来标记属性的key(因为可能要添加很多属性)
    return [objc_getAssociatedObject(self, @"isNeedCopy") boolValue];
}
-(void)setLongCopyPressGesture:(UILongPressGestureRecognizer *)longCopyPressGesture
{
    objc_setAssociatedObject(self, @"longCopyPressGesture", longCopyPressGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UILongPressGestureRecognizer *)longCopyPressGesture
{
    return (objc_getAssociatedObject(self, @"longCopyPressGesture"));
}
-(void)needCopyingLongPressGestureRecognizer:(BOOL)need
{
    if (need) {
        if (!self.longCopyPressGesture) {
            UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
            longPressGr.minimumPressDuration = 0.3;
            [self addGestureRecognizer:longPressGr];
            self.longCopyPressGesture = longPressGr;
        }
        self.userInteractionEnabled = YES;
        [self becomeFirstResponder];//偶现不加的话第一次出现又立即消失
    }else{
        [self removeGestureRecognizer:self.longCopyPressGesture];
        self.longCopyPressGesture = nil;
    }
}
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self];
        [self addMenuControllerWithPoint:point];
    }
}
#pragma mark 菜单选项
-(void)addMenuControllerWithPoint:(CGPoint)point
{
    NSLog(@"addMenuControllerWithPoint");
    [self becomeFirstResponder];
    
    UIMenuItem *copyMenuItem = [[UIMenuItem alloc]initWithTitle:NSLocalizedString(@"复制", nil) action:@selector(jl_customCopyAction:)];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    [menuController setMenuItems:[NSArray arrayWithObjects:copyMenuItem,nil]];
    [menuController setTargetRect:CGRectMake(point.x, point.y-10, 0, 0) inView:self];
    [menuController setMenuVisible:YES animated: YES];
}
@end
