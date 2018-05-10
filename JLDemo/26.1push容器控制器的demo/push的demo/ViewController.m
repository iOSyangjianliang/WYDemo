//
//  ViewController.m
//  push的demo
//
//  Created by 杨建亮 on 2018/1/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "AAViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self];
    AAViewController *aa = [[AAViewController alloc] init];
    [navi pushViewController:aa animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
