//
//  TreeView.h
//  YJLCopyTV
//
//  Created by 海狮 on 17/6/16.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeItem.h"
@protocol TreeViewDelegate <NSObject>
@optional
- (void)jl_TreeItems:(TreeItem*)treeItem treeItemClickNSInteger:(NSInteger) integer;
@end

@interface TreeView : UIView
+ (instancetype)shareTreeView;
-(void)addToTabbarController:(UITabBarController*)tabC WithTreeItemsArrayImages:(NSArray*)arrayimages;

@property (nonatomic,weak) id<TreeViewDelegate>delegate;

//是否缩放
//@property (nonatomic) BOOL scale;

@end
