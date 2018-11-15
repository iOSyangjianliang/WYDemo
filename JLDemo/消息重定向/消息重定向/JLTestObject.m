//
//  JLTestObject.m
//  消息重定向
//
//  Created by 杨建亮 on 2018/11/2.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "JLTestObject.h"

@implementation JLTestObject
-(instancetype)init
{
    if (self = [super init]) {
//        forwardClass = []
    }
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"1.%s",__FUNCTION__);
   return [super forwardingTargetForSelector: aSelector];
}

//- (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    NSLog(@"%s",__FUNCTION__);
//    [super forwardInvocation:anInvocation];
//}
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    NSLog(@"2.%s",__FUNCTION__);
//    return [super methodSignatureForSelector:aSelector];
//}
+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"%s",__FUNCTION__);
    return  [super instanceMethodSignatureForSelector:aSelector];

}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSString *sel = NSStringFromSelector(selector);
    if ([sel rangeOfString:@"set"].location == 0)
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    else
    {
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *key = NSStringFromSelector([invocation selector]);
    if ([key rangeOfString:@"set"].location == 0)
    {
        key= [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
        NSString *obj;
        [invocation getArgument:&obj atIndex:2];
//        [_propertiesDict setObject:obj forKey:key];
    }
    else
    {
//        NSString *obj = [_propertiesDict objectForKey:key];
        [invocation setReturnValue:&obj];
    }
}

@end
