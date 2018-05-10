//
//  TimerViewController.m
//  JLLubBoDemo
//
//  Created by 杨建亮 on 2017/7/28.
//  Copyright © 2017年 杨建亮. All rights reserved.
//  测试NSTimer Strong／Weak内存释放处理

#import "TimerViewController.h"

#import "TimeView.h"

@interface TimerViewController ()
@property(nonatomic,weak)TimeView* timeView;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addTimeView:(UIButton *)sender {
  TimeView*timeView   = [[TimeView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];

    [self.view addSubview:timeView];
    self.timeView = timeView;
}

- (IBAction)yichutimeView:(id)sender {
    [self.timeView removeFromSuperview];
}

- (IBAction)btnTree:(id)sender {
    [self.timeView buildTimer];
}

-(void)dealloc
{
    NSLog(@"VC-%s",__FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
