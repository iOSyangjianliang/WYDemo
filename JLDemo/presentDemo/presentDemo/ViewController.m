//
//  ViewController.m
//  presentDemo
//
//  Created by 杨建亮 on 2018/10/30.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[NSClassFromString(@"AAViewController") alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [rootVC presentViewController:vc  animated:YES completion:nil];
}

@end
