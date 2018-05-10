//
//  DDViewController.m
//  push的demo
//
//  Created by 杨建亮 on 2018/1/19.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "DDViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"dd";

    self.view.backgroundColor = [UIColor redColor];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UINavigationController *navi = (UINavigationController*) [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *VC1 = navi.visibleViewController;
    UIViewController *VC2 = navi.topViewController;
    if ([VC1 isEqual:VC2]) {
        NSLog(@"same");
    }
    
    NSLog(@"%@-%@",self.navigationController.visibleViewController,self.navigationController.topViewController);
    
    NSLog(@"%@-%@",VC1,VC2);

//    po self.navigationController.childViewControllers
//    <__NSArrayI 0x6040004344c0>(
//                                <CCViewController: 0x7fa7e4d18760>,
//                                <DDViewController: 0x7fa7e4f03110>
//                                )
//
//    (lldb) po self.tabBarController.navigationController.childViewControllers
//    <__NSArrayI 0x60800004f2d0>(
//                                <AAViewController: 0x7fa7e4c02c10>,
//                                <BBViewController: 0x7fa7e4e058e0>,
//                                <MJTabBarcontroller: 0x7fa7e5830600>
//                                )

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
