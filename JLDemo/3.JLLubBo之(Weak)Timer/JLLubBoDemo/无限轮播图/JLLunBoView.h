//
//  JLLunBoView.h
//  YiShangbao
//
//  Created by 海狮 on 17/6/28.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLLunboProtocol.h"
#import "LunBoModel.h"
#import "LunBoCollectionViewCell.h"
#import "UIView+FrameHelp.h"

NS_ASSUME_NONNULL_BEGIN
@class JLLunBoView;
@protocol JLLunBoViewDatasource <NSObject>
@required
//使用默认的cell创建轮播图需要执行次方法赋值需要转成轮播模型model
-(LunBoModel*)jl_LunBoCollectionViewCell:(LunBoCollectionViewCell*)lunboCollectionViewCell cellForItemAtInteger:(NSInteger ) integer;
@end

@protocol JLLunBoViewDelegate <NSObject>
@optional
-(void)jl_JLLunBoView:(JLLunBoView*)jlLunBoView collectionView:(UICollectionView *)collectionView didSelectItemAtInteger:(NSInteger )integer sourceArray:(NSArray*)sourceArray;
@end

@interface JLLunBoView : UIView
@property(nonatomic,weak,nullable)id<JLLunBoViewDelegate>delegate;
@property(nonatomic,weak,nullable)id<JLLunBoViewDatasource>datasource;//使用默认cell创建需要设置此代理

/**
 1.若要使用默认的cell创建轮播图则必须设置datasource,默认cell只有imageview视图
 可storyboard直接创建，或[alloc init］方式创建再调用此方法赋值
 @param data 数据源数组,仅用于创建cell个数，cell赋值需要掉dataSource代理方法传入轮播模型model
 @param datasource 数据源代理
 */
-(void)setData:(NSArray*)data datasource:(id<JLLunBoViewDatasource>)datasource;

/**
 2.使用自定义的cell创建轮播图,cell上子控件可高度自定义
 可storyboard直接创建，或[alloc init］方式创建再调用此方法赋值
 @param data 自定义数据源数组，可以是自定义模型数组
 @param cell 自定义cell必须遵循JLLunboProtocol协议，cell执行协议方法给cell赋值
 @param isxib cell是否以xib方式创建
 eg:
 JLLunBoCollectionViewCell* cell = [[JLLunBoCollectionViewCell alloc] init];
 [self.JLlunbotuView setData:arrayModel WithCell:cell isXibBuild:YES];
 */

-(void)setData:(NSArray*)data WithCell:(UICollectionViewCell<JLLunboProtocol>*)cell isXibBuild:(BOOL)isxib;


//---------NStimer-------
/**多少秒后启动，eg:viewwillapper调用 */
-(void)resumeTimerAfterDuration:(NSTimeInterval)duration;

/**暂停,eg:viewwilldisapper调用*/
-(void) pauseTimer;

/**销毁,eg:delloc调用*/
-(void) stopTimer;
//**-------------UI设置---------/
@property(nonatomic,assign)CGFloat pageControl_botton;//UIpageControl控件距离底部间距
@end
NS_ASSUME_NONNULL_END
