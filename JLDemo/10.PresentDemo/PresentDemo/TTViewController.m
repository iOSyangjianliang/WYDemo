//
//  TTViewController.m
//  PresentSmallViewDemo
//
//  Created by 杨建亮 on 2017/9/27.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
//    self.view.alpha = 0.35;
}
/**
 *  设置位置宽高
 */
- (void)viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(100, 100, 250, 300);
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.868f];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
