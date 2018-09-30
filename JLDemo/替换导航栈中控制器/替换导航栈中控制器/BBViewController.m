//
//  BBViewController.m
//  替换导航栈中控制器
//
//  Created by 杨建亮 on 2018/9/6.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "BBViewController.h"

@interface BBViewController ()

@end

@implementation BBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"BBBBBBBB";

    self.view.backgroundColor = [UIColor purpleColor];

    
    NSLog(@"BBBB.arrayM=%@",self.navigationController.childViewControllers);

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *VC = [[NSClassFromString(@"AViewController") alloc] init ];
    [self.navigationController pushViewController:VC animated:YES];
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
