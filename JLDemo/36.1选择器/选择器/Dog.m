
//
//  Dog.m
//  选择器
//
//  Created by qianfeng on 16/5/9.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "Dog.h"

@implementation Dog
-(void)run
{
    NSLog(@"🐶看见小偷，吓跑了");
}
-(void)eat
{
    NSLog(@"🐶吧坏人吃了");
}
-(void)sleepWithTime:(NSString*)time
{
    NSLog(@"睡了%@",time);
}
-(void)playWithPerson:(NSString*)personname tool:(NSString*)tool
{
    NSLog(@"传入playWithPerson:%@ tool:%@",personname ,tool);
}

@end
