//
//  Dog.h
//  选择器
//
//  Created by qianfeng on 16/5/9.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject
@property int age;
@property NSString* name;
-(void)run;
-(void)eat;

-(void)sleepWithTime:(NSString*)time;
-(void)playWithPerson:(NSString*)personname tool:(NSString*)tool;

@end
