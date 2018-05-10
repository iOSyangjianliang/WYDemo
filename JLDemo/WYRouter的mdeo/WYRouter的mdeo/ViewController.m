//
//  ViewController.m
//  WYRouter的mdeo
//
//  Created by 杨建亮 on 2018/1/19.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIStoryboard *SB ;
    [SB instantiateViewControllerWithIdentifier:@""];
    
    id obj =[[NSClassFromString(@"AAViewController") alloc] init];
    
    id obj_W =[[NSClassFromString(@"AAViewController") alloc] init];

    if ([obj isKindOfClass:[UIViewController class]]) {
        NSLog(@"%@",obj);
    }
    
    if (obj) {
        NSLog(@"%@",obj);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
