//
//  AAViewController.m
//  push的demo
//
//  Created by 杨建亮 on 2018/1/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AAViewController.h"
#import "BBViewController.h"

@interface AAViewController ()

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AA";

    self.view.backgroundColor = [UIColor purpleColor];
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];

    self.view.alpha = 0.4;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    BBViewController *bb = [[BBViewController alloc] init];
    [self.navigationController pushViewController:bb animated:YES];
}
- (void)didReceiveMemoryWarning {
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
