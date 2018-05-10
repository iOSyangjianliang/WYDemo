//
//  TabViewController.m
//  push的demo
//
//  Created by 杨建亮 on 2018/1/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "TabViewController.h"
#import "AAViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    AAViewController *aa = [[AAViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:aa];

//    [self addChildViewController:navi];
//    [self.view addSubview:navi.view];
    //设置模式展示风格
    [navi setModalPresentationStyle:UIModalPresentationOverCurrentContext];
  
    [self.navigationController presentViewController:navi animated:NO completion:nil];
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
