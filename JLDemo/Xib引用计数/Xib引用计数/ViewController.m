//
//  ViewController.m
//  Xib引用计数
//
//  Created by 杨建亮 on 2018/11/5.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //.m  -fno-objc-arc
    
    
    NSLog(@"=%ld",[_lab retainCount]);
    NSLog(@"=%ld",[_lab2 retainCount]);
    
    //要用__bridge来转换，如果用__bridge_retained 来转换的话，实际上生成了一个CoreFoundation 对象，并且retain了一次原来的Objective-C对象，使得引用计数比真实值大一；
    NSLog(@"retain  count = %ld\n",CFGetRetainCount((__bridge  CFTypeRef)(_lab)));
    
    NSLog(@"retain  count = %ld\n",CFGetRetainCount((__bridge  CFTypeRef)(_lab2)));
    
    NSLog(@"__bridge_retained = %ld\n",CFGetRetainCount((__bridge_retained  CFTypeRef)(_lab2)));
    
    

    
}


@end
