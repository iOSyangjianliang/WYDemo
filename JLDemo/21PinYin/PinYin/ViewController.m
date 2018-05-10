//
//  ViewController.m
//  PinYin
//
//  Created by 杨建亮 on 2018/1/11.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "WYPinYin.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    NSString *strRRR1 = @"1adsa";
    NSString *ccc1 = [WYFirstLetter firstLetters:strRRR1];
    
    
    NSString *strRRR2 = @"&^";
    NSString *ccc2 = [WYFirstLetter firstLetters:strRRR2];
    
    NSString *strRRR = @"wq大大啊b大地";
    NSString *ccc = [WYFirstLetter firstLetters:strRRR];
    
    NSLog(@"%@",ccc);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
