//
//  ViewController.m
//  CALayer动画01
//
//  Created by 杨建亮 on 2018/9/28.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "GreenLineLabel.h"

@interface ViewController ()
@property(nonatomic, strong)UIView *VVV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];


//    _VVV = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
//    _VVV.backgroundColor = [UIColor purpleColor];
//    _VVV.layer.masksToBounds = YES;
//    [self.view addSubview:_VVV];
    
   
    
    [self test];
   
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //在iOS11开始才有动画效果
//    [UIView animateWithDuration:2 animations:^{
//        self.VVV.layer.cornerRadius = 40;
//
//    } completion:^(BOOL finished) {
//
//    }];
    
    
}


@end
