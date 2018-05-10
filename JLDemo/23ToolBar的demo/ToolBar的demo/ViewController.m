//
//  ViewController.m
//  ToolBar的demo
//
//  Created by 杨建亮 on 2018/1/12.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "JLViewController.h"
#import "JLTabBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"第一个";
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.navigationController pushViewController:[JLViewController new] animated:YES];
    
    [self.navigationController pushViewController:[JLTabBarViewController new] animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
