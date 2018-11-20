//
//  Cat.m
//  选择器
//
//  Created by 杨建亮 on 2018/11/2.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "Cat.h"

@implementation Cat

//- (void)run:(NSString *)method run:(NSString *)method2 run:(NSString *)method3
//{
//    NSLog(@"三个参数处理%@=%@=%@",method,method2,method3);
//}



- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"1.%s",__FUNCTION__);
    return [super forwardingTargetForSelector: aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"%s",__FUNCTION__);
    [super forwardInvocation:anInvocation];

    
}

+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"%s",__FUNCTION__);
    return  [super instanceMethodSignatureForSelector:aSelector];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSLog(@"2.%s",__FUNCTION__);
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        
//        此时我们应该判断方法是否存在，如果不存在这抛出异常
        NSString *info = [NSString stringWithFormat:@"%@方法找不到", NSStringFromSelector(selector)];
        [NSException raise:@"\n============\n方法调用出现异常\n=============\n" format:info, nil];
        
//        for (id target in self.t) {
//            if ((signature = [target methodSignatureForSelector:aSelector])) {
//                break;
//            }
//        }
    }
    return signature;
}


//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(foo)) {
//        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "V@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//- (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    for (id target in self.allDelegates) {
//        if ([target respondsToSelector:anInvocation.selector]) {
//            [anInvocation invokeWithTarget:target];
//        }
//    }
//}

//- (BOOL)respondsToSelector:(SEL)aSelector
//{
//    if ([super respondsToSelector:aSelector]) {
//        return YES;
//    }
//
//    for (id target in self.allDelegates) {
//        if ([target respondsToSelector:aSelector]) {
//            return YES;
//        }
//    }
//    return NO;
//}


@end
