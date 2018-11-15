//
//  ViewController.m
//  CALayer子类动画
//
//  Created by 杨建亮 on 2018/10/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>

#import "Demo1ViewController.h"
#import "Demo2ViewController.h"
#import "Demo3ViewController.h"
#import "Demo4ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc1 = [[NSClassFromString(@"Demo1ViewController") alloc] init];
    UIViewController *vc2 = [[NSClassFromString(@"Demo2ViewController") alloc] init];
    UIViewController *vc3 = [[NSClassFromString(@"Demo3ViewController") alloc] init];
    UIViewController *vc4 = [[NSClassFromString(@"Demo3ViewController") alloc] init];

    UIViewController *vc5 = [[NSClassFromString(@"AAViewController") alloc] init];
    UIViewController *vc6 = [[NSClassFromString(@"BBViewController") alloc] init];
    UIViewController *vc7 = [[NSClassFromString(@"CCViewController") alloc] init];
    UIViewController *vc8 = [[NSClassFromString(@"DDViewController") alloc] init];
    UIViewController *vc9 = [[NSClassFromString(@"EEViewController") alloc] init];
    UIViewController *vc10 = [[NSClassFromString(@"FFViewController") alloc] init];
    UIViewController *vc11 = [[NSClassFromString(@"GGViewController") alloc] init];


    
//    [self presentViewController:vc3 animated:YES completion:nil];
    
    [self.navigationController pushViewController:vc11 animated:YES];

}
- (NSArray *)allProperties {
    unsigned int count;
    
    // 获取类的所有属性
    // 如果没有属性，则count为0，properties为nil
    objc_property_t *properties = class_copyPropertyList([CALayer class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (NSUInteger i = 0; i < count; i++) {
        // 获取属性名称
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        NSLog(@"属性名称=(%@)  属性类型=(%@)",name,[name class]);
        [propertiesArray addObject:name];
    }
    
    // 注意，这里properties是一个数组指针，是C的语法，
    // 我们需要使用free函数来释放内存，否则会造成内存泄露
    free(properties);
    
    return propertiesArray;
}

@end
