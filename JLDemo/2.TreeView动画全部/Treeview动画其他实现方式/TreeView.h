//
//  TreeView.h
//  test
//
//  Created by 海狮 on 17/5/13.
//  Copyright © 2017年 海狮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeItem.h"

typedef void(^ClickBackgroundViewBlock)(BOOL);

@protocol TreeViewDelegate <NSObject>
@optional
- (void)jl_TreeItems:(TreeItem*)treeItem treeItemsNSInteger:(NSInteger) integer;
@end

@interface TreeView : UIView
+ (instancetype)shareTreeView;

-(void)addSelfToTabbarController:(UITabBarController*)tabC WithArrayImages:(NSArray*)arrayimages;

-(void)autoShowWihtBo:(BOOL)sameClick ifOther:(BOOL)isother;//加载动画

-(void)clickUI; //处理当push时tabbar隐藏后左右遮挡view始终在tabbar上
-(void)removeFromSuperviewAll;

@property (nonatomic, copy)ClickBackgroundViewBlock clickbackgroundViewBlock;
//代理
@property (nonatomic,weak) id<TreeViewDelegate>delegate;



@end
