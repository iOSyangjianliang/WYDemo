//
//  WYTabBarViewController.m
//  YiShangbao
//
//  Created by Lance on 16/12/7.
//  Copyright © 2016年 com.Microants. All rights reserved.
//

#import "WYTabBarViewController.h"

#import "AppDelegate.h"

#import "TreeView.h"

static BOOL boolSameClick;
@interface WYTabBarViewController ()<UITabBarControllerDelegate,TreeViewDelegate>
@property(nonatomic,strong)TreeView* treeView;
@end

@implementation WYTabBarViewController


+ (instancetype)getInstance
{
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([vc isKindOfClass:[WYTabBarViewController class]]) {
        return (WYTabBarViewController *)vc;
    }else{
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //tint color
//    self.tabBar.tintColor =WYUISTYLE.colorMred;
        
    UITabBarController *tb =[[self storyboard] instantiateInitialViewController];
    
    NSMutableArray *vcs=[NSMutableArray arrayWithCapacity:5];//创建一个数组来保存controller对象
    NSArray *sbNameArray = @[@"Main",sb_SecondStoryboard,@"Main",@"Main",@"Main"];
    NSArray *sbIdArray = @[SBID_FirstStoryboard,SBID_SecondStoryboard,SBID_ThirdStoryboard,SBID_FourthStroyboard,SBID_FiveStroyboard];
    for (int i =0; i<sbNameArray.count; i++)
    {
        UIStoryboard *sb=[UIStoryboard  storyboardWithName:sbNameArray[i] bundle:[NSBundle mainBundle]];
        UIViewController *vc=[sb instantiateViewControllerWithIdentifier:sbIdArray[i]];//根据storyboard和controller的storeId找到控制器
        vc.tabBarItem = [[tb.viewControllers objectAtIndex:i]tabBarItem];
        [vcs addObject:vc];
    }
    
    [self setViewControllers:vcs animated:NO];//用当前的viewController(UINavigationController)数组替换原本的tabbarControlle的 viewControllers(UINavigationController)数组
   
    self.delegate = self;

    [self initTabBar];
    [self setApperanceForController];
    
}

#pragma mark-
//设置基本数据
- (void)setApperanceForController
{
    [self zhNavigationBar_UIBarButtonItem_appearance_systemBack_noTitle];


    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
         [obj zhNavigationBar_Single_BackIndicatorImage:@"back" isOriginalImage:YES];
    }];
    
//    [[UIBarButtonItem appearance]setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];


    [self zhNavigationBar_appearance_backgroundImageName:nil ShadowImageName:nil orBackgroundColor:[UIColor whiteColor] titleColor:UIColorFromRGB_HexValue(0x222222) titleFont:[UIFont boldSystemFontOfSize:17.f] barItem_textFont:[UIFont systemFontOfSize:14.f] barItem_color:UIColorFromRGB_HexValue(0x222222)];
}


- (void)initTabBar
{
    NSArray *imgSelectArray = @[@"toolbar_jieshenyi-sel",@"toolbar_shangpu_sel",@"btn-+",@"toolbar_fuwu-sel",@"toolbar_myCenter_sel"];
    NSArray *imgArray = @[@"toolbar_jieshenyi-nor",@"toolbar_shangpu-nor",@"btn_tuiguang",@"toolbar_fuwu-nor",@"toolbar_myCenter_nor"];
    
    [self zhTabBarController_tabBarItem_ImageArray:imgArray selectImages:imgSelectArray slectedItemTintColor:nil unselectedItemTintColor:nil];
    self.tabBar.translucent = NO;
    UIImage *tabImage = [UIImage zh_imageWithColor:UIColorFromRGB_HexValue(0xFAFAFA) andSize:self.tabBar.frame.size];
    self.tabBar.backgroundImage = tabImage;
    UIImage *shadowImage = [UIImage zh_imageWithColor:UIColorFromRGB_HexValue(0xD8D8D8) andSize:CGSizeMake(self.tabBar.frame.size.width, 0.5)];
    self.tabBar.shadowImage = shadowImage;
}

#pragma  mark - tabBarController

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UINavigationController *secondNav = [tabBarController.viewControllers objectAtIndex:1];
    if ([secondNav isEqual:viewController] && ![UserInfoUDManager isOpenShop])
    {
        UINavigationController *nav =tabBarController.selectedViewController;
        [nav.topViewController pushStoryboardViewControllerWithStoryboardName:sb_SecondStoryboard identifier:SBID_OpenShopController withData:nil];
        return NO;
    }
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (viewController ==[tabBarController.viewControllers firstObject])
    {
        
        UITabBarItem *barItem = viewController.tabBarItem;
        UIImage *image= [[UIImage imageNamed:@"toolbar_jieshenyi-nor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage = [[UIImage imageNamed:@"toolbar_jieshenyi-sel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (![barItem.image isEqual:image])
        {
            barItem.image = image;
            [[NSNotificationCenter defaultCenter]postNotificationName:Noti_update_TradeMainController object:nil];
        }
        if (![barItem.selectedImage isEqual:selectImage])
        {
            barItem.selectedImage = selectImage;
            [[NSNotificationCenter defaultCenter]postNotificationName:Noti_update_TradeMainController object:nil];
        }
        [MobClick event:kUM_Builds];
    }
    else if (viewController ==[tabBarController.viewControllers objectAtIndex:1])
    {
        [MobClick event:kUM_Shops];
    }
    else if (viewController ==[tabBarController.viewControllers objectAtIndex:2])
    {        
    }

    else if (viewController ==[tabBarController.viewControllers objectAtIndex:3])
    {
    }
    else if (viewController ==[tabBarController.viewControllers objectAtIndex:4])
    {
        [MobClick event:kUM_Service];
    }
    
    
    //动画处理
    if (viewController ==[tabBarController.viewControllers objectAtIndex:2]) {
    
        if (!self.treeView) {
            self.treeView = [TreeView shareTreeView];
            [self.treeView addSelfToTabbarController:self WithArrayImages:[NSArray arrayWithObjects:@"toolbar_tuichanpin",@"toolbar_qingkucun",@"toolbar_tuishangpu",@"",nil]];
            self.treeView.delegate = self;
            
            self.treeView.clickbackgroundViewBlock = ^(BOOL bo){
                boolSameClick = !boolSameClick;
            };
        }
        [self.treeView clickUI];//校验层级
        if (boolSameClick) {
            [MobClick event:kUM_b_promotion];


            [self.treeView autoShowWihtBo:boolSameClick ifOther:YES];
        }else{
            [MobClick event:kUM_b_push];

            [self.treeView autoShowWihtBo:boolSameClick ifOther:NO];
            
        }
        boolSameClick = !boolSameClick;
    }else{

        boolSameClick = NO;
        [self.treeView autoShowWihtBo:boolSameClick ifOther:YES];
        
    }
    
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger selectIndex = [tabBar.items indexOfObject:item];
    if (selectIndex == 2) {
        
    }else{
        
    }
}
#pragma mark - TreeViewDelegate
-(void)jl_TreeItems:(TreeItem *)treeItem treeItemsNSInteger:(NSInteger)integer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Noti_pushWhat_ExtendViewController  object:[NSNumber numberWithInteger:integer]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
