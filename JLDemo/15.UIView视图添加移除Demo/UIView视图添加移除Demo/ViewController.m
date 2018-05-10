//
//  ViewController.m
//  UIView视图添加移除Demo
//
//  Created by 杨建亮 on 2017/12/28.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "JLViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    JLViewController *view = [[JLViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
