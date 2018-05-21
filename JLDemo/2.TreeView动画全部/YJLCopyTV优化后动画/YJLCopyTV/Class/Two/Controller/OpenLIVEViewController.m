
//
//  OpenLIVEViewController.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import "OpenLIVEViewController.h"

@interface OpenLIVEViewController ()

@end

@implementation OpenLIVEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
