//
//  AAViewController.m
//  text
//
//  Created by 杨建亮 on 2018/2/2.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AAViewController.h"
@interface AAViewController ()

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *arr3 = [UIApplication sharedApplication].windows;
    NSLog(@"3.%@",arr3);
    
    UIViewController *VC=  [[UIViewController alloc] init];
    VC.view.backgroundColor = [UIColor purpleColor];
    
    //不能使用rootViewController去弹出演示(每格控制器只能弹一个控制器)、应该使用当前被弹出的去弹出演示
    UIViewController *V = [UIApplication sharedApplication].delegate.window.rootViewController;
    [V presentViewController:VC animated:YES completion:nil];
    
    NSArray *arr4 = [UIApplication sharedApplication].windows;
    NSLog(@"4.%@",arr4);
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
