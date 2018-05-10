//
//  FirstViewController.m
//  SBXib使用
//
//  Created by 杨建亮 on 2017/8/15.
//  Copyright © 2017年 海狮. All rights reserved.
// -------功能引导控制器------


#import "FirstViewController.h"
#import "SencondViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];

//    self.view.backgroundColor = [UIColor redColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UIStoryboard* extendSottrbord = [UIStoryboard storyboardWithName:@"text" bundle:[NSBundle mainBundle]];
    
    SencondViewController* kaipinguanggaoVC =  [extendSottrbord instantiateViewControllerWithIdentifier:@"GuanggaoViewControllerID"];
    
//    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:kaipinguanggaoVC];
    
    [UIApplication sharedApplication].delegate.window.rootViewController =  kaipinguanggaoVC;
}

@end
