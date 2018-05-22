//
//  BaseViewController.h
//  PDF
//
//  Created by wu on 2018/5/18.
//  Copyright © 2018年 MMC. All rights reserved.
//

#define IOS_VERSION               [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH              ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT             ([UIScreen mainScreen].bounds.size.height)
#define kScaleH  SCREEN_HEIGHT / 667.0    // 4.7屏幕高度尺寸比例
#define kScaleW  SCREEN_WIDTH / 375.0     // 4.7屏幕宽度尺寸比例
#define WeakSelf __weak typeof(self) weakSelf = self;
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kUIColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kPDFURL @"http://101.37.2.101/oss/%E5%80%9F%E6%AC%BE%E6%9C%8D%E5%8A%A1%E5%8D%8F%E8%AE%AE2845638816a6420db5da26069fdef0f9.pdf?Expires=4680169941&OSSAccessKeyId=LTAIVte00lkdPULh&Signature=HPCE2w3pXECSyHTkUSjnHfC/CbA%3D"
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController

@property (nonatomic,   weak) MBProgressHUD *progressHUB;

/**
 创建白色导航栏【本导航栏是加阴影的导航栏】

 @param title 导航栏标题
 */
- (void)createWhiteNavBarWithTitle:(NSString *)title;

/**
 移除白色导航栏【目的把阴影设置给重置】
 */
- (void)hideNavBarWhiteShadowOpacity;


/**
 导航栏返回按钮
 */
- (void)clickBackNav;


/**
 白色状态栏
 */
- (void)defineUIStatusBarStyleLightContent;


/**
 黑色状态栏
 */
- (void)defineUIStatusBarStyleDefault;

/**
 背景色转图片

 @param color 颜色
 */
- (UIImage *)createImageWithColor:(UIColor *)color;

- (void)showException:(id)obj; // 显示异常信息
- (void)startLoadIng:(NSString *)text; // 菊花+文字
- (void)hideLoadIng; // 移除菊花+文字

@end
