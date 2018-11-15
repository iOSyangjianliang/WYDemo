//
//  LeftSlideViewController.h
//  QQ侧滑效果
//
//  Created by 杨建亮 on 2018/10/17.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftSlideViewController : UIViewController
/**
 初始化侧滑控制器

 @param leftVC 右视图控制器
 @param mainVC 中间主视图控制器
 @return 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC andMainView:(UIViewController *)mainVC NS_UNAVAILABLE;

//左侧窗控制器
@property (nonatomic, weak, readonly) UIViewController *leftVC;
//主控制器UIViewController或其子类
@property (nonatomic, weak, readonly) UIViewController *mainVC;

@property (nonatomic, assign) CGFloat leftVCWidth;


/**
 侧滑窗是否关闭,默认YES
 */
@property (nonatomic, assign) BOOL closed;

/**
 @param open 开启、关闭侧滑控制器
 @param animated 开启、关闭是否需要动画
 */
- (void)openLeftViewController:(BOOL)open animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
