//
//  CCViewController.m
//  push的demo
//
//  Created by 杨建亮 on 2018/1/19.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "CCViewController.h"
#import "DDViewController.h"

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"cc";
    self.view.backgroundColor = [UIColor whiteColor];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UINavigationController *navi = (UINavigationController*) [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *VC1 = navi.visibleViewController;
    UIViewController *VC2 = navi.topViewController;

    NSLog(@"%@-%@",VC1,VC2);

    DDViewController *aa = [[DDViewController alloc] init];
    [self.navigationController pushViewController:aa animated:YES];
    
    
  
    
  
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
