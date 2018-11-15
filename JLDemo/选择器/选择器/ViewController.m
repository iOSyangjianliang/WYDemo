//
//  ViewController.m
//  选择器
//
//  Created by 杨建亮 on 2018/11/2.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

#import "Dog.h"
#import "Cat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //1.@selector
//    [self useSelector];

    //2.NSInvocation
    [self useInvocation];



}

-(void)useInvocation
{
    
    //方法签名类
    //方法签名中保存了方法的名称/参数/返回值，协同NSInvocation来进行消息的转发
    // 方法签名一般是用来设置参数和获取返回值的, 和方法的调用没有太大的关系
    //1、根据方法来初始化NSMethodSignature
//    NSMethodSignature *signature = [Cat instanceMethodSignatureForSelector:@selector(run:run:run:)];
    
    Cat *obj = [Cat new];
    NSMethodSignature *signature = [obj methodSignatureForSelector:@selector(run:run:run:)];

    
    // NSInvocation中保存了方法所属的对象/方法名称/参数/返回值
    //其实NSInvocation就是将一个方法变成一个对象
    //2、创建NSInvocation对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //设置方法调用者
    invocation.target = obj;
    //注意：这里的方法名一定要与方法签名类中的方法一致
    invocation.selector = @selector(run:run:run:);
    NSString *way = @"byCar";
    //这里的Index要从2开始，因为0跟1已经被占据了，分别是self（target）,selector(_cmd)
    [invocation setArgument:&way atIndex:2];
    
    NSString *way2 = @"byCar2";
    NSString *way3 = @"byCar3";
    [invocation setArgument:&way2 atIndex:3];
    [invocation setArgument:&way3 atIndex:4];

    //3、调用invoke方法
    [invocation invoke];
    //target去实现run:run:run:方法

   
}


//============================================================
-(void)useSelector
{
    Dog* dog = [[Dog alloc] init];
    dog.name = @"旺财";
    dog.age = 2;
    [dog run];
    
    
    
    SEL sel = @selector(run);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    /*调用方法写这里*/
    // SEL 类型无参的使用方式
    [dog performSelector:sel];
    
    // 一个参数的使用
    SEL selSleep = @selector(sleepWithTime:);
    [dog performSelector:selSleep withObject:@"1000"];
    
    // 两个参数的使用（最多支持两个参数）
    SEL selPlay = @selector(playWithPerson:tool:);
    [dog performSelector:selPlay withObject:@"班主任" withObject:@"骨头"];
    
    // 可以把方法转成字符串
    NSString *str = NSStringFromSelector(sel);
    // 把字符串转成方法
//    SEL ss = NSSelectorFromString(str);
    
    // 延时执行
    [dog performSelector:selSleep withObject:@"666" afterDelay:1.5];
    
#pragma clang diagnostic pop
    
}
@end
