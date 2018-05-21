//
//  MJTabBarcontroller.m
//  RuoRou
//
//  Created by qianfeng on 16/7/26.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//
#define SCR_W     [UIScreen mainScreen].bounds.size.width
#define SCR_H     [UIScreen mainScreen].bounds.size.height
#import "TreeView.h"
#import "MJTabBarController.h"
#import "RGBColor.h"
#import "OpenLIVEViewController.h"

#import "TreeView.h"
@interface MJTabBarcontroller ()<UITabBarControllerDelegate>
{
    UIImageView *_imageView;
    NSInteger _selButtonTag;
    
    BOOL isbo;
    
    BOOL sameclick;
}
@property(nonatomic,strong)TreeView* treeView;
@end

@implementation MJTabBarcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setTintColor:[RGBColor colorWithHexString:@"#EE3A8C"]];
    self.tabBar.translucent = NO;
    //添加模块视图
    self.delegate =self;
    [self addViewcontrollers];
}
-(void)addViewcontrollers
{
    [self addViewControllerWithName:@"FirstViewController" title:@"首页" NorImageName:@"toolbar_home" SelImageName:@"toolbar_home_sel"];
    [self addViewControllerWithName:@"MiddleViewController" title:@"" NorImageName:@"toolbar_+" SelImageName:@"toolbar_+"];
    [self addViewControllerWithName:@"MineViewController" title:@"我的" NorImageName:@"toolbar_me" SelImageName:@"toolbar_me_sel"];
    
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
    naVC.navigationBar.barTintColor = [RGBColor colorWithHexString:@"#EE3A8C"];
//    naVC.navigationBar.translucent = NO;
    NSMutableArray* arrayM = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    [arrayM addObject:naVC];
    self.viewControllers = arrayM;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    if (viewController == tabBarController.viewControllers[1]) {
//        OpenLIVEViewController* opLive = [[OpenLIVEViewController alloc] init];
//        [tabBarController.viewControllers[1] presentViewController:opLive animated:YES completion:nil];
//        return NO;
//    }
    return YES;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger selectIndex = [tabBar.items indexOfObject:item];
    
//    CGFloat www = 1000;
//    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
//    for (UIControl *tabBarButton in self.tabBar.subviews){
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
//            CGFloat b  = tabBarButton.frame.origin.x;
//            CGFloat w = b>SCR_W/2?b-SCR_W/2:SCR_W/2-b;
//            if (w<www) {
//                www = w;
//                [tabbarbuttonArray addObject:tabBarButton];
//            }
//            
//        }
//    }
//    if (tabbarbuttonArray.lastObject) {
//        UIControl* tabBarButton = tabbarbuttonArray.lastObject;
//        NSLog(@"%f --->%f-%f- WH-%f-%f",SCR_W,tabBarButton.frame.origin.x,tabBarButton.frame.origin.y,tabBarButton.frame.size.width,tabBarButton.frame.size.height);
//
//        [tabbarbuttonArray.lastObject addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }

    
    if (selectIndex == 1) {
        
        TreeView * v = [[TreeView alloc] initWithFrame:CGRectMake(00, 0, SCR_W, SCR_H)];;
        [v addToTabbarController:self WithTreeItemsArrayImages:@[@"toolbar_+",@"toolbar_+",@"toolbar_+",@"toolbar_+"]];

        return;
        

    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    return;
    
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            // 之所以这么写是因为UITabBarButton是苹果私有API
//            NSLog(@"%@",tabBarButton.superclass);
//        }
//    }
    
    
    
    
//    for (UIControl *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            
//            
//            NSLog(@"%f-%f- WH-%f-%f",tabBarButton.frame.origin.x,tabBarButton.frame.origin.y,tabBarButton.frame.size.width,tabBarButton.frame.size.height);
//            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//            
////            NSLog(@"%@",tabBarButton.frame);
//        }
//    }
}


- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    return;
    isbo = !isbo;
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            
//            
//            [UIView animateWithDuration:3 animations:^{
//                imageView.transform = CGAffineTransformMakeRotation(M_PI*);
//                
//            } completion:^(BOOL finished) {
//                imageView.transform = CGAffineTransformIdentity;
//            }];
//            NSLog(@"%@--%f",imageView,self.tabBar.frame.size.width/2);
//            UIImageView* imV =  (UIImageView*)imageView;
//            UIImage* img = imV.image;
//            [imageView setValue:[UIImage imageNamed:@""] forKey:@"image"]
//            if ([imV.image isEqual:[UIImage imageNamed:@"toolbar_+"] ]) {
           
            //1.创建动画并指定动画属性
                CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                
//                basicAnimation.delegate = self;
                //2.设置动画属性初始值、结束值
                if (isbo) {
                    basicAnimation.fromValue=[NSNumber numberWithInt:0];
                    
                    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_4];
                }else{
                    basicAnimation.toValue=[NSNumber numberWithInt:0];
                    
                    basicAnimation.fromValue=[NSNumber numberWithFloat:M_PI_4];
                }
                
                //设置其他动画属性
                basicAnimation.duration= 0.35;
                //                basicAnimation.autoreverses= YES;//旋转后再旋转到原来的位置
                basicAnimation.removedOnCompletion = NO;
                basicAnimation.fillMode = kCAFillModeForwards;
                
                //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
                [imageView.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
                

//            }
            
            
            
////            需要实现的帧动画,这里根据需求自定义
//            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//
////            animation.keyPath = @"transform.scale";
//            animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
//            animation.duration = 1;
//            animation.calculationMode = kCAAnimationCubic;
//            //把动画添加上去就OK了
//            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}
@end

