//
//  WWViewController.m
//  Windows的demo
//
//  Created by 杨建亮 on 2017/10/28.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "WWViewController.h"

@interface WWViewController ()

@end

@implementation WWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(touchesevent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSArray* v =  [UIApplication sharedApplication].windows;
    NSLog(@"2\n%@",v);
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray* v =  [UIApplication sharedApplication].windows;
    NSLog(@"3\n%@",v);
    
    UIViewController *A = [[UIViewController alloc] init];
    A.view.backgroundColor = [UIColor redColor];
    [UIApplication sharedApplication].keyWindow.rootViewController = A;

    NSArray* v2 =  [UIApplication sharedApplication].windows;
    NSLog(@"33\n%@",v2);

}
-(void)touchesevent
{
    NSArray* v =  [UIApplication sharedApplication].windows;
    NSLog(@"4\n%@",v);
    
    UIViewController *C = [[UIViewController alloc] init];
    C.view.backgroundColor = [UIColor purpleColor];
    [UIApplication sharedApplication].delegate.window.rootViewController = C;
    
    NSArray* v2 =  [UIApplication sharedApplication].windows;
    NSLog(@"44\n%@",v2);
    
    
    if ([UIApplication sharedApplication].delegate.window.superview) {
        NSLog(@"%@>>>>>>>>>>");
    }
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
