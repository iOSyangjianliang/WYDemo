//
//  ViewController.m
//  CALayer02文字渐变
//
//  Created by 杨建亮 on 2018/9/29.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 300, 200, 25);
    [gradientLayer setStartPoint:CGPointMake(0.0, 0.0)];
    [gradientLayer setEndPoint:CGPointMake(0.0, 1.0)];
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor purpleColor].CGColor,(id)[UIColor blueColor].CGColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:gradientLayer.bounds];
    label.text = @"红紫蓝垂直渐变~~";
    label.font = [UIFont boldSystemFontOfSize:25];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.mask = label.layer;
    
    
//    这里label的layer是mask，有对象的地方就是文字的部分，有文字的地方是透明的，就可以看见被其遮罩的渐变层gradientLayer的内容，而没有对象的部门是不透明的，所以文字外面就看不到其遮罩的渐变层gradientLayer的内容。
}

@end
