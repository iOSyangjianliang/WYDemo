//
//  ViewController.m
//  JLMoveTitleButtonDemo
//
//  Created by 杨建亮 on 2017/8/4.
//  Copyright © 2017年 杨建亮. All rights reserved.
//

#import "ViewController.h"
#import "JLMoveTitleButton.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet JLMoveTitleButton *movebutton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.movebutton.moveString = @"撒打算打算打算打算打算打算放假啊快点发你的负担那发呆发发发的会计法啊";
   
    self.movebutton.moveString = @"66666666666666";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_movebutton.superview) {
        [_movebutton removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
