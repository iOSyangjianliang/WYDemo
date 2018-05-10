//
//  MJTabBarcontroller.m
//  RuoRou
//
//  Created by qianfeng on 16/7/26.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import "MJTabBarcontroller.h"
#import "CCViewController.h"

@interface MJTabBarcontroller ()<UITabBarControllerDelegate>
{
    UIImageView *_imageView;
    NSInteger _selButtonTag;
}
@end

@implementation MJTabBarcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setTintColor:[UIColor purpleColor]];
    self.tabBar.translucent = NO;
    //添加模块视图
    self.delegate =self;
    [self addViewcontrollers];
}
-(void)addViewcontrollers
{
    [self addViewControllerWithName:@"CCViewController" title:@"首页" NorImageName:@"toolbar_home" SelImageName:@"toolbar_home_sel"];
    [self addViewControllerWithName:@"CCViewController" title:@"直播" NorImageName:@"toolbar_live" SelImageName:@"toolbar_live"];
    [self addViewControllerWithName:@"CCViewController" title:@"我的" NorImageName:@"toolbar_me" SelImageName:@"toolbar_me_sel"];
    
}
-(void)addViewControllerWithName:(NSString*)VCname title:(NSString*)title NorImageName:(NSString*)Norname SelImageName:(NSString*)SelName
{
    Class clas = NSClassFromString(VCname);
    UIViewController*  viewC = [[clas alloc] init ];
    viewC.tabBarItem.image = [[UIImage imageNamed:Norname] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    viewC.tabBarItem.selectedImage = [[UIImage imageNamed:SelName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewC.tabBarItem.title = title;
    UINavigationController* naVC = [[UINavigationController alloc] initWithRootViewController:viewC];
    //导航栏颜色
    naVC.navigationBar.barTintColor = [UIColor purpleColor];
//    naVC.navigationBar.translucent = NO;
    NSMutableArray* arrayM = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    [arrayM addObject:naVC];
    self.viewControllers = arrayM;
}
@end

