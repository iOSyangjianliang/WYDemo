//
//  WYIntroduceViewController.h
//  YiShangbao
//
//  Created by 海狮 on 17/5/24.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  点击按钮类型枚举
 */
typedef NS_ENUM(NSInteger, WYIntroduceViewControllerButtonType){
    
    WYWYIntroduceViewControllerNowGoToBTN    = 0, //点击立即进入按钮
    
    WYWYIntroduceViewControllerLeftBTN       = 1, //点击左(上)边按钮
    
    WYWYIntroduceViewControllerRightBTN      = 2  //点击右(下)边按钮
};

@class WYIntroduceViewController;
@protocol WYIntroduceViewControllerDelegate <NSObject>
@optional
//立即进入，左边按钮，右边按钮协议
-(void)WYIntroduceViewController:(WYIntroduceViewController*)viewController didUIbutton:(WYIntroduceViewControllerButtonType)buttonType ;
@end
@interface WYIntroduceViewController : UIViewController
@property(nonatomic,weak)id<WYIntroduceViewControllerDelegate>delegate;
/**
  判断是否已经加载过引导页，即是否是第一次安装；
 */
+ (BOOL)hadLaunchedGuide;

+ (void)guideFigureWithImages:(NSArray *)images NowGotoImage:(NSString*)gotoBackgroundimage SelectIdentityImage:(NSString*)IdentitySelectBackgroundImage finishWithRootController:(UIViewController *)vc;

@end
