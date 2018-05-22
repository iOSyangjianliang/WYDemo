//
//  AAViewController.m
//  全局返回按钮
//
//  Created by 杨建亮 on 2018/5/21.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AAViewController.h"
#import "BBViewController.h"

@interface AAViewController ()

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页标题";
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.
//    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"😄" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBarItem)];

    
    BBViewController *VC = [[BBViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

    //2.都是可以设置的，但事件无效
//    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"😄" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBarItem)];

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
