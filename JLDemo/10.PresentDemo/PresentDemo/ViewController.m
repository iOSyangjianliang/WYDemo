//
//  ViewController.m
//  PresentSmallViewDemo
//
//  Created by 杨建亮 on 2017/9/27.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "TTViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TTViewController *tView = [[TTViewController alloc] init];
    //设置模式展示风格
    [tView setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    //必要配置
    self.modalPresentationStyle = UIModalPresentationCurrentContext; 
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [self presentViewController:tView animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

