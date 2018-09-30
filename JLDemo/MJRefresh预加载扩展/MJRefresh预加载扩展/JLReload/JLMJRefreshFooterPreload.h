//
//  JLMJRefreshFooterPreload.h
//  MJRefresh预加载扩展
//
//  Created by 杨建亮 on 2018/9/13.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MJRefresh.h"

typedef NS_ENUM(NSInteger,JLPreloadState){
    
    JLPreloadRequestState         = 0,  //
    
    JLPreloadReloadState          = 1,  //
    
    JLPreloadDefaultState         = 2,  //
    
};
@interface JLMJRefreshFooterPreload : NSObject

- (instancetype)initWithScrollerView:(UIScrollView *)sV;
@property (nonatomic, weak, readonly) UIScrollView *scrollerView;

@property(nonatomic, assign)CGFloat requestDataHeight;
@property(nonatomic, assign)CGFloat reloadDataHeight;

-(void)footerWithRequestBlock:(MJRefreshComponentRefreshingBlock)requestBlock reload:(MJRefreshComponentRefreshingBlock)reloadBlock;


-(void)endRefreshing_setDefaultHeight;
-(void)endRefreshing_setRequestHeight;
-(void)endRefreshing_setReloadHeight;

@end
