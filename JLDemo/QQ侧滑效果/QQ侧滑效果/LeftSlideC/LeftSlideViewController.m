//
//  LeftSlideViewController.m
//  QQ侧滑效果
//
//  Created by 杨建亮 on 2018/10/17.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "LeftSlideViewController.h"

@interface LeftSlideViewController ()

@end

@implementation LeftSlideViewController

- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC
{
    if(self = [super init]){
        
        self.closed = YES;//初始时侧滑窗关闭

        _leftVC = leftVC;
        _mainVC = mainVC;
        
        _leftVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height);

        
        self.leftVC.view.hidden = YES;
        [self.view addSubview:self.leftVC.view];
        

        

        self.leftTableview.backgroundColor = [UIColor clearColor];
        self.leftTableview.frame = CGRectMake(0, 0, kScreenWidth - kMainPageDistance, kScreenHeight);
        
        //设置左侧tableview的初始位置和缩放系数
        self.leftTableview.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        self.leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        
        [self.view addSubview:self.mainVC.view];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
