//
//  JLMJRefreshFooterPreload.m
//  MJRefresh预加载扩展
//
//  Created by 杨建亮 on 2018/9/13.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "JLMJRefreshFooterPreload.h"

@interface JLMJRefreshFooterPreload ()
@property(nonatomic,copy)MJRefreshComponentRefreshingBlock requestBlock;
@property(nonatomic,copy)MJRefreshComponentRefreshingBlock reloadBlock;
@property (nonatomic, assign ) JLPreloadState curryState;

@end

@implementation JLMJRefreshFooterPreload
- (instancetype)initWithScrollerView:(UIScrollView *)sV
{
    if (self = [super init]){
        //        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestNextPageData) ];
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestNextPageData];
        }];
        footer.stateLabel.font = [UIFont systemFontOfSize:12.5];
        
        sV.mj_footer = footer;
        _scrollerView = sV;
        
        _curryState = JLPreloadRequestState;
        self.requestDataHeight = 88;
        _reloadDataHeight  = -MJRefreshFooterHeight;
    }
    return self;
}
-(void)requestNextPageData
{
//    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.scrollerView.mj_footer;
//    NSLog(@"triggerAutomaticallyRefreshPercent=%f",footer.triggerAutomaticallyRefreshPercent);
    
    if (self.curryState == JLPreloadRequestState)
    {
        self.requestBlock();
    }
    else if (self.curryState == JLPreloadReloadState)
    {
        self.reloadBlock();
    }
    else
    {
        NSLog(@"network code 000");
        self.requestBlock();
    }
}
-(void)footerWithRequestBlock:(MJRefreshComponentRefreshingBlock)requestBlock reload:(MJRefreshComponentRefreshingBlock)reloadBlock
{
    self.requestBlock =  requestBlock;
    self.reloadBlock = reloadBlock;
}
-(void)setRequestDataHeight:(CGFloat)requestDataHeight
{
    _requestDataHeight = requestDataHeight;
    if (self.curryState == JLPreloadRequestState) {
        MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.scrollerView.mj_footer;
        //底部控件(默认高度44)出现百分比(0.0-1.0,默认1.0)来预加载，此处设置表示距离底部上拉控件顶部高度XXX即提前加载数据
        footer.triggerAutomaticallyRefreshPercent = -requestDataHeight/footer.mj_h ;
    }
}
-(void)setReloadDataHeight:(CGFloat)reloadDataHeight
{
    _reloadDataHeight = reloadDataHeight;
    if (self.curryState == JLPreloadReloadState) {
        MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.scrollerView.mj_footer;
        footer.triggerAutomaticallyRefreshPercent = -reloadDataHeight/footer.mj_h;
    }
}
#pragma mark - endRefreshing
-(void)endRefreshing_setReloadHeight
{
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.scrollerView.mj_footer;
    [footer endRefreshingWithCompletionBlock:^{
        footer.triggerAutomaticallyRefreshPercent = -self.reloadDataHeight/footer.mj_h;
        self.curryState = JLPreloadReloadState;
    }];
}
-(void)endRefreshing_setRequestHeight
{
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.scrollerView.mj_footer;
    [footer endRefreshingWithCompletionBlock:^{
        footer.triggerAutomaticallyRefreshPercent = -self.requestDataHeight/footer.mj_h;
        self.curryState = JLPreloadRequestState;
    }];
}
-(void)endRefreshing_setDefaultHeight
{
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.scrollerView.mj_footer;
    [footer endRefreshingWithCompletionBlock:^{
        footer.triggerAutomaticallyRefreshPercent = 1;
        self.curryState = JLPreloadDefaultState;
    }];
}

@end
