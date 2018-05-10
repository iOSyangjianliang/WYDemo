//
//  JLLunBoView.h
//  YiShangbao
//
//  Created by 海狮 on 17/6/28.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLLunboProtocol.h"
#import "JLLunBoCollectionViewCell.h"
#import "UIView+FrameHelp.h"
#import "JLPageControl.h"

NS_ASSUME_NONNULL_BEGIN
@class JLLunBoView;
@protocol JLLunBoViewDatasource <NSObject>
@required
/**
 使用默认的cell创建轮播图需要执行Datasource方法
 @param lunboCollectionViewCell lunboCollectionViewCell(你可以直接设置lunboCollectionViewCell属性)
 @param integer 点击的indexPath.row
 @param sourceArray 传入的原始数据
 @return 推荐返回数据类型(NSString,NSURL,UIImage),你也可以返回nil在DataSource直接根据代理返回的lunboCollectionViewCell进行Cell设置eg：[lunboCollectionViewCell.lunboImageView sd_setImageWithURL: placeholderImage: options:];
 */
-(nullable id)jl_LunBoCollectionViewCell:(JLLunBoCollectionViewCell*)lunboCollectionViewCell cellForItemAtInteger:(NSInteger) integer sourceArray:(NSArray*)sourceArray;
@end
@protocol JLLunBoViewDelegate <NSObject>
@optional
/**
 点击轮播Cell代理

 @param jlLunBoView jlLunBoView
 @param collectionView collectionView
 @param integer 点击的indexPath.row
 @param sourceArray 传入的原始数据
 */
-(void)jl_JLLunBoView:(JLLunBoView*)jlLunBoView collectionView:(UICollectionView *)collectionView didSelectItemAtInteger:(NSInteger)integer sourceArray:(NSArray*)sourceArray;
@end

@interface JLLunBoView : UIView
@property(nonatomic,weak,nullable)id<JLLunBoViewDelegate>delegate;
@property(nonatomic,weak,nullable)id<JLLunBoViewDatasource>datasource;//使用默认cell创建需要设置此代理
/**------初始化添加子控件(也可用于刷新数据->子控件重新创建)--------*/
/**
 1.若要使用默认的cell创建轮播图则必须设置datasource,默认cell只有imageview视图
 可storyboard直接创建，或[alloc init］方式创建再调用此方法赋值
 @param data 数据源数组,仅用于创建cell个数，cell赋值需要掉dataSource代理方法传入轮播模型model
 @param datasource 数据源代理
 */
-(void)setData:(nullable NSArray*)data datasource:(id<JLLunBoViewDatasource>)datasource;
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
-(void)setData:(nullable NSArray*)data WithCell:(UICollectionViewCell<JLLunboProtocol>*)cell isXibBuild:(BOOL)isxib;
//**-------------刷新数据---------/
-(void)reloadDataWithArray:(NSArray*)array;


//**-------------NStimer---------/
/**定时器时间间隔(默认2.5s)*/
@property(nonatomic,assign)NSTimeInterval timeDuration;
/**多少秒后启动，eg:viewWillapper调用*/
-(void)resumeTimerAfterDuration:(NSTimeInterval)duration;
/**暂停,eg:viewwilldisapper调用*/
-(void)pauseTimer;


//**-------------UI设置----------/待扩展
@property(nonatomic,assign)BOOL pageControlHidden; //默认NO
@property(nonatomic,assign)JLPageControlStyle pageControlStyle;
//在UIpageControl默认位置基础上调整X，Y(默认居中，距离底部10间距,高度10)
@property(nonatomic,assign)CGFloat pageControl_botton;

//@property(nonatomic,assign)CGFloat pageControl_top;
//@property(nonatomic,assign)CGFloat pageControl_left;
//@property(nonatomic,assign)CGFloat pageControl_right;


@end
NS_ASSUME_NONNULL_END
