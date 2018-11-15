//
//  MainTabBarController.m
//  QQ侧滑效果
//
//  Created by 杨建亮 on 2018/10/17.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSArray* array = @[@"AAViewController",@"BBViewController"];
    
    NSMutableArray * arrayM =[NSMutableArray array];
    
    for (NSString*str in array) {
        Class cla = NSClassFromString(str);
        UIViewController* viewC = [[cla alloc] init];
        
        UINavigationController* navC = [[UINavigationController alloc] initWithRootViewController:viewC];
        [arrayM addObject:navC];
    }
    
    self.viewControllers = arrayM;
    
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
