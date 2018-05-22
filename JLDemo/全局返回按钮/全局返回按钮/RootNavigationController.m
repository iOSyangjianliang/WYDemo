//
//  RootNavigationController.m
//  全局返回按钮
//
//  Created by 杨建亮 on 2018/5/21.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"%@==%@",self.topViewController,viewController);

//    UIButton* LeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 27)];
//    [LeftBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [LeftBtn setImageEdgeInsets:UIEdgeInsetsMake(1, 10, 1, 45)];
//    LeftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [LeftBtn addTarget:self action:@selector(clickLeftBarbutton) forControlEvents:UIControlEventTouchUpInside];
//    //        LeftBtn.backgroundColor = [UIColor redColor];
//    UIBarButtonItem* LeftBtnBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:LeftBtn];
//    self.topViewController.navigationItem.backBarButtonItem  = LeftBtnBarButtonItem;
//
//
//    self.topViewController.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"😄" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarbutton)];


    UIImage *backImage = [UIImage imageNamed:@"ic_fanhui"];
    backImage= [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationBar setBackIndicatorImage:backImage];
    [self.navigationBar setBackIndicatorTransitionMaskImage:backImage];
    
    [super pushViewController:viewController animated:animated];
    
    NSLog(@"%@",self.topViewController);

    UIButton* LeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 28)];
    [LeftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [LeftBtn setImage:backImage forState:UIControlStateNormal];
    [LeftBtn setImageEdgeInsets:UIEdgeInsetsMake(1, 10, 1, 45)];
    LeftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [LeftBtn addTarget:self action:@selector(clickLeftBarbutton) forControlEvents:UIControlEventTouchUpInside];
    //        LeftBtn.backgroundColor = [UIColor redColor];
    UIBarButtonItem* LeftBtnBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:LeftBtn];
    self.topViewController.navigationItem.leftBarButtonItem  = LeftBtnBarButtonItem;
}
- (void)clickLeftBarbutton
{
    [self popViewControllerAnimated:YES];
    NSLog(@"888");
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
