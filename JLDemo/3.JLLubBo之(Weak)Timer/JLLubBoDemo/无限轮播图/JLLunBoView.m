//
//  JLLunBoView.m
//  YiShangbao
//
//  Created by 海狮 on 17/6/28.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

//#define SELF_H 120
#define Time 5.f

#import "JLLunBoView.h"
@interface JLLunBoView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,weak) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)UIPageControl* pageControl;
@property(nonatomic,strong)NSTimer *nstimer;
@property(nonatomic,strong)NSArray*arrayData;

@property(nonatomic,strong)UICollectionViewCell<JLLunboProtocol>*custonCollectioncell;
@property(nonatomic,assign)BOOL isCustomCell;


@end
static NSString* cellType = @"JLLunBoViewCellType";
@implementation JLLunBoView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
//        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setData:(NSArray *)data datasource:(id<JLLunBoViewDatasource>)datasource
{
    if (!data || data.count == 0) {
        return;
    }
    if (_nstimer.isValid) {
        [_nstimer invalidate];
        _nstimer=nil;
    }
    
    self.arrayData = [NSArray arrayWithArray:data];
    self.datasource = datasource;
    LunBoCollectionViewCell* cell = [[LunBoCollectionViewCell alloc] init];
    [self buildUIWithCollectionViewWithCell:cell isXibBuild:YES];

}
-(void)setData:(NSArray *)data WithCell:(UICollectionViewCell<JLLunboProtocol> *)cell isXibBuild:(BOOL)isxib
{
    if (!data || data.count == 0) {
        return;
    }
    if (![cell isKindOfClass:[UICollectionViewCell class]]) {
        return;
    }
   
    if (_nstimer.isValid) {
        [_nstimer invalidate];
        _nstimer=nil;
    }
    
    self.isCustomCell = YES;
    _arrayData = [NSArray arrayWithArray:data];
    //初始化子控件
    [self buildUIWithCollectionViewWithCell:cell isXibBuild:isxib];

}
#pragma mark - 自动翻页
-(void)AutoPage
{
    // 获取当前页数
    NSInteger page = _collectionView.contentOffset.x / self.jl_width;
    if (page<_arrayData.count ) {
        
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:page+1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    if (page == _arrayData.count) {

        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }


}
#pragma mark - 初始化UI控件
- (void)buildUIWithCollectionViewWithCell:(UICollectionViewCell<JLLunboProtocol>*)celll isXibBuild:(BOOL)isxib
{
    //1.
    [self.subviews  makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //布局
    [self layoutIfNeeded];
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout = flowLayout;
    
    UICollectionView*collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.jl_width,self.jl_height) collectionViewLayout:flowLayout];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    if (_arrayData.count>1) {
        [_collectionView setContentOffset:CGPointMake(self.jl_width, 0) animated:NO];
    }
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    self.collectionView = collectionView;

    NSString* ClassCell =  NSStringFromClass([celll class]);
    if (isxib) {
        [self.collectionView registerNib:[UINib nibWithNibName:ClassCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier:cellType];
    }else{
        [_collectionView registerClass:[NSClassFromString(ClassCell) class] forCellWithReuseIdentifier:cellType];
    }
    //2.
    if (_arrayData.count>1) {
        [self buildPageControlAndTimer];
    }

    
    NSLog(@"%@",NSStringFromCGRect(self.collectionView.frame));//高度为0collectionView不进xiang guan代理方法的
}
- (void)buildPageControlAndTimer
{
    _pageControl = [UIPageControl appearance];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.jl_height*0.85, self.jl_width, 10.f)];
    if (self.pageControl_botton ) {
        _pageControl.frame = CGRectMake(0, self.jl_height-10.f-_pageControl_botton, self.jl_width, 10.f);
    }
    _pageControl.hidesForSinglePage = YES;
    //设置pageControl的图片   
//    [self.pageControl setValue:[UIImage imageNamed:@"banner_orange"] forKeyPath:@"_currentPageImage"];
//    [self.pageControl setValue:[UIImage imageNamed:@"banner_grey"]  forKeyPath: @"_pageImage"];
            _pageControl.pageIndicatorTintColor = [UIColor purpleColor];
            _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
            _pageControl.backgroundColor = [UIColor redColor];
    [self addSubview:self.pageControl];
    _pageControl.numberOfPages = _arrayData.count;
   
    //
//    [self addNstimer];
}
#pragma mark - 添加计时器
-(void)addNstimer
{
    if (!self.nstimer) {
        self.nstimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(AutoPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:
         self.nstimer forMode:NSRunLoopCommonModes];
    }
    
}
-(void)setPageControl_botton:(CGFloat)pageControl_botton
{
    _pageControl_botton = pageControl_botton;
    if (_pageControl) {
        _pageControl.frame = CGRectMake(0, self.jl_height-10.f-_pageControl_botton, self.jl_width, 10.f);
    }
    

}

//- (void)setupTimer
//{
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
//    _timer = timer;
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//}
//
//- (void)invalidateTimer
//{
//    [_timer invalidate];
//    _timer = nil;
//}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_arrayData.count == 1) {
        return 1;
    }else if (_arrayData.count>1) {
        return _arrayData.count+2; //无限轮播，头尾多一张
    }else{
        return 0;
    }
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCustomCell) {
        self.custonCollectioncell = [collectionView dequeueReusableCellWithReuseIdentifier:cellType forIndexPath:indexPath];
        if (_arrayData.count == 1) {
            [self.custonCollectioncell setLunBoCellData:_arrayData.firstObject];
        }else{
            if (indexPath.row == 0) {//第一张
                [self.custonCollectioncell setLunBoCellData:_arrayData[_arrayData.count-1]];
            }else if (indexPath.row == _arrayData.count+1){//最后一张
                [self.custonCollectioncell setLunBoCellData:_arrayData[0]];
            }else{
                [self.custonCollectioncell setLunBoCellData:_arrayData[indexPath.row-1]];
            }
        }
        return (UICollectionViewCell*)self.custonCollectioncell;
    }else{
        LunBoCollectionViewCell* celldefault = [collectionView dequeueReusableCellWithReuseIdentifier:cellType forIndexPath:indexPath];
        if (self.datasource && [self.datasource respondsToSelector:@selector(jl_LunBoCollectionViewCell:cellForItemAtInteger:)]) {
            
            if (_arrayData.count == 1) {
                LunBoModel* model = [self.datasource jl_LunBoCollectionViewCell:celldefault cellForItemAtInteger:indexPath.row];
                [celldefault setLunBoCellData:model];
            }else{
                if (indexPath.row == 0) {//第一张
                    NSIndexPath *IndexPath_Last = [NSIndexPath indexPathForItem:_arrayData.count-1 inSection:0];
                    LunBoModel* model = [self.datasource jl_LunBoCollectionViewCell:celldefault cellForItemAtInteger:IndexPath_Last.row];
                    [celldefault setLunBoCellData:model];

                }else if (indexPath.row == _arrayData.count+1){//最后一张
                    NSIndexPath *IndexPath_first = [NSIndexPath indexPathForItem:0 inSection:0];
                    LunBoModel* model = [self.datasource jl_LunBoCollectionViewCell:celldefault cellForItemAtInteger:IndexPath_first.row];
                    [celldefault setLunBoCellData:model];

                }else{
                    NSIndexPath *IndexPath_middle = [NSIndexPath indexPathForItem:indexPath.row-1 inSection:0];
                    LunBoModel* model = [self.datasource jl_LunBoCollectionViewCell:celldefault cellForItemAtInteger:IndexPath_middle.row];
                    [celldefault setLunBoCellData:model];

                }
            }
        }
        return celldefault;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(self.jl_width, self.jl_height);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jl_JLLunBoView:collectionView:didSelectItemAtInteger:sourceArray:)]) {
        NSInteger integer = 0;
        if (_arrayData.count ==1) {//无限轮播会多两张
            integer = 0;
        }else if (indexPath.row == 0){
            integer = _arrayData.count-1;
        }else if (indexPath.row == _arrayData.count+1){
            integer = 0;
        }else{
            integer = indexPath.row-1;
        }
        [self.delegate jl_JLLunBoView:self collectionView:collectionView didSelectItemAtInteger:integer sourceArray:_arrayData];
    }
}
#pragma mark 只要ScrollerView视图滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / self.jl_width;
    NSLog(@"page =%ld",page);
    _pageControl.currentPage = page-1;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self resumeTimerAfterDuration:Time];
}
#pragma mark 结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取当前页数
    NSInteger page = scrollView.contentOffset.x / self.jl_width;
    if (page == _arrayData.count+1) {//最后一张
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    if (page == 0) {
        
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:_arrayData.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}
//＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊--NSTimer---＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
-(void)pauseTimer{
    
    if (![self.nstimer isValid]) {
        return ;
    }
    
    if(_nstimer){
        //暂停定时器
        [self.nstimer setFireDate:[NSDate distantFuture]];
    }
    
}
-(void)resumeTimerAfterDuration:(NSTimeInterval)duration
{
    
    if (![self.nstimer isValid]) {
        return ;
    }
    
    if(_nstimer){
        //开启定时器
        [self.nstimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:duration]];

    }
    
}
-(void)stopTimer
{
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
    if (_nstimer.isValid) {
        [_nstimer invalidate];
        _nstimer=nil;
    }
    
}
-(void)dealloc
{
    NSLog(@">>%s",__FUNCTION__);
}
////解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
//- (void)willMoveToSuperview:(UIView *)newSuperview
//{
//    if (!newSuperview) {
////        [self invalidateTimer];
//    }
//}
//-(void)willRemoveSubview:(UIView *)subview
//{
//    
//}
////解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
