//
//  JLLunBoView.m
//  YiShangbao
//
//  Created by 海狮 on 17/6/28.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

//#define SELF_H 120
#define TIMEDURATION 2.5

#import "JLLunBoView.h"

#import "Masonry.h"
@interface JLLunBoView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,weak) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,weak)JLPageControl* pageControl;
@property(nonatomic,weak)NSTimer *timer;

@property(nonatomic,strong)NSArray*arrayData;
@property(nonatomic,assign)BOOL isFirstWillDisplayCell;

@property(nonatomic,strong)UICollectionViewCell<JLLunboProtocol>*custonCollectioncell;
@property(nonatomic,assign)BOOL isCustomCell;


@end
static NSString* cellType = @"JLLunBoViewCellType";
@implementation JLLunBoView

#pragma mark ------初始化JLLunBoView------
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {

        self.arrayData = [NSArray array];
        JLLunBoCollectionViewCell* cell = [[JLLunBoCollectionViewCell alloc] init];
        [self buildUIWithCollectionViewWithCell:cell isXibBuild:YES];
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.arrayData = [NSArray array];
        JLLunBoCollectionViewCell* cell = [[JLLunBoCollectionViewCell alloc] init];
        [self buildUIWithCollectionViewWithCell:cell isXibBuild:YES];
    }
    return self;
}
-(void)setData:(NSArray *)data datasource:(id<JLLunBoViewDatasource>)datasource
{
    self.arrayData = [NSArray arrayWithArray:data];
    self.datasource = datasource;
    JLLunBoCollectionViewCell* cell = [[JLLunBoCollectionViewCell alloc] init];
    [self buildUIWithCollectionViewWithCell:cell isXibBuild:YES];

}
-(void)setData:(NSArray *)data WithCell:(UICollectionViewCell<JLLunboProtocol> *)cell isXibBuild:(BOOL)isxib
{
    if (![cell isKindOfClass:[UICollectionViewCell class]]) {
        NSLog(@"方法:%sCell参数传入错误",__FUNCTION__);
        return;
    }
    self.isCustomCell = YES;
    self.arrayData = [NSArray arrayWithArray:data];
    [self buildUIWithCollectionViewWithCell:cell isXibBuild:isxib];

}
-(void)setTwoData:(NSArray *)data WithCell:(UICollectionViewCell<JLLunboProtocol> *)cell isXibBuild:(BOOL)isxib
{
    if (![cell isKindOfClass:[UICollectionViewCell class]]) {
        NSLog(@"方法:%sCell参数传入错误",__FUNCTION__);
        return;
    }
    self.isCustomCell = YES;
    self.arrayData = [NSArray arrayWithArray:data];
    [self buildUIWithCollectionViewWithCell:cell isXibBuild:isxib];
}
-(void)reloadDataWithArray:(NSArray *)array
{
    [self deallocTimer];
    _isFirstWillDisplayCell = YES;
    self.arrayData = [NSArray arrayWithArray:array];
    [self.collectionView reloadData];
    _pageControl.numberOfPages = self.arrayData.count;
    [self setupTimer];

}

#pragma mark - 初始化UI控件
- (void)buildUIWithCollectionViewWithCell:(UICollectionViewCell<JLLunboProtocol>*)celll isXibBuild:(BOOL)isxib
{
    [self.subviews  makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //布局
    _isFirstWillDisplayCell = YES;
    [self layoutIfNeeded];
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout = flowLayout;
    
    UICollectionView*collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.jl_width,self.jl_height) collectionViewLayout:flowLayout];
    collectionView.pagingEnabled = YES;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    collectionView.showsVerticalScrollIndicator = NO;

    collectionView.scrollsToTop = NO;
   
//    collectionView.scrollEnabled = NO;

    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.contentInset = UIEdgeInsetsMake(0,0, 0, 0);
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;

    NSString* ClassCell =  NSStringFromClass([celll class]);
    if (isxib) {
        [self.collectionView registerNib:[UINib nibWithNibName:ClassCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier:cellType];
    }else{
        [self.collectionView registerClass:[NSClassFromString(ClassCell) class] forCellWithReuseIdentifier:cellType];
    }
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bRight = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *bBottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *bLeft = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *bTop = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];

    [self addConstraints:@[bRight, bBottom, bLeft, bTop]];
    
    //
    [self buildPageControl];
    [self setupTimer];

    //
    
    NSLog(@"%@",NSStringFromCGRect(self.collectionView.frame));//高度为0collectionView不进xiang guan代理方法的
}
- (void)buildPageControl
{
   JLPageControl* pageControl = [[JLPageControl alloc] initWithFrame:CGRectMake(0, self.jl_height-10-10, self.jl_width, 10.f)];
    
    
    pageControl.numberOfPages = _arrayData.count;
    pageControl.hidesForSinglePage = YES;
    if (_pageControl) {
        _pageControl.hidden = _pageControlHidden;
    }
    if (self.pageControl_botton ) {
        pageControl.jl_y = self.jl_height-10.f-_pageControl_botton;
    }
    if (self.pageControlStyle == JLPageControlSystemStyle){
        pageControl.pageIndicatorTintColor = [UIColor purpleColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }else{
        pageControl.style = JLPageControlImageStyle;
        [pageControl setValue:[UIImage imageNamed:@"banner_orange"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"banner_grey"]  forKeyPath: @"_pageImage"];
    }
//    pageControl.backgroundColor = [UIColor blackColor];    
    self.pageControl = pageControl;
    [self addSubview:self.pageControl];
}
//＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊--UIStyle自定义设置--＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
#pragma mark ------UIStyle自定义设置------
-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    if (self.flowLayout) {
        self.flowLayout.scrollDirection = _scrollDirection;
        [self.collectionView reloadData];
    }
}
-(void)setPageControlHidden:(BOOL)pageControlHidden
{
    _pageControlHidden = pageControlHidden;
    if (_pageControl) {
        _pageControl.hidden = _pageControlHidden;
    }
}
-(void)setPageControl_botton:(CGFloat)pageControl_botton
{
    _pageControl_botton = pageControl_botton;
    if (_pageControl) {
        _pageControl.jl_y = self.jl_height-10.f-_pageControl_botton;
    }
}
-(void)setPageControlStyle:(JLPageControlStyle)pageControlStyle
{
    _pageControlStyle = pageControlStyle;
    if (self.pageControl) {
        self.pageControl.style = pageControlStyle;
    }
}
//＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊--UICollectionViewDelegate---＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
#pragma mark ------UICollectionViewDelegate------
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
        JLLunBoCollectionViewCell* celldefault = [collectionView dequeueReusableCellWithReuseIdentifier:cellType forIndexPath:indexPath];
        if (self.datasource && [self.datasource respondsToSelector:@selector(jl_LunBoCollectionViewCell:cellForItemAtInteger:sourceArray:)]) {
            
            if (_arrayData.count == 1) {
                [celldefault setLunBoCellData:[self.datasource jl_LunBoCollectionViewCell:celldefault cellForItemAtInteger:indexPath.row sourceArray:_arrayData]];
            }else{
                if (indexPath.row == 0) {//第一张
                    NSIndexPath *IndexPath_Last = [NSIndexPath indexPathForItem:_arrayData.count-1 inSection:0];
                    [celldefault setLunBoCellData:[self.datasource jl_LunBoCollectionViewCell:celldefault cellForItemAtInteger:IndexPath_Last.row sourceArray:_arrayData]];

                }else if (indexPath.row == _arrayData.count+1){//最后一张
                    NSIndexPath *IndexPath_first = [NSIndexPath indexPathForItem:0 inSection:0];
                    [celldefault setLunBoCellData:[self.datasource jl_LunBoCollectionViewCell:celldefault cellForItemAtInteger:IndexPath_first.row sourceArray:_arrayData]];

                }else{
                    NSIndexPath *IndexPath_middle = [NSIndexPath indexPathForItem:indexPath.row-1 inSection:0];
                    [celldefault setLunBoCellData:[self.datasource jl_LunBoCollectionViewCell:celldefault cellForItemAtInteger:IndexPath_middle.row sourceArray:_arrayData]];
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
        }else if (indexPath.row == 0){ //无限轮播如果超过一张，则会有n+2张，则点击第一张的integer == 最后那张integer
            integer = _arrayData.count-1;
        }else if (indexPath.row == _arrayData.count+1){
            integer = 0;
        }else{
            integer = indexPath.row-1;
        }
        [self.delegate jl_JLLunBoView:self collectionView:collectionView didSelectItemAtInteger:integer sourceArray:_arrayData];
    }
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_arrayData.count>1 && _isFirstWillDisplayCell) {
//        [_collectionView setContentOffset:CGPointMake(self.jl_width, 0) animated:NO];
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        _isFirstWillDisplayCell = NO;
    }
}
//* 只要ScrollerView视图滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%s",__FUNCTION__);

    NSInteger page;
    
    
    NSLog(@"滚动方向是:%ld",self.scrollDirection);
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) { //垂直
        page = scrollView.contentOffset.y / self.jl_height;
    }else{
        page = scrollView.contentOffset.x / self.jl_width;
    }

    _pageControl.currentPage = page -1;
    
    if (page == _arrayData.count+1 || page == 0) {
        [self scrollViewDidEndDecelerating:self.collectionView];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"%s",__FUNCTION__);

    [self pauseTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%s",__FUNCTION__);

    [self resumeTimerAfterDuration:TIMEDURATION];
}
//* 滚动完毕就会调用（如果是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"BBBB_____%s",__FUNCTION__);
//    return;
    // 获取当前页数
    NSInteger page;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        page = scrollView.contentOffset.y / self.jl_height;
    }else{
        page = scrollView.contentOffset.x / self.jl_width;
    }
    
    if (page == _arrayData.count+1 && _arrayData.count>1) {//最后一张跳转第一张
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    if (page == 0 && _arrayData.count>1) { //第一张跳转最后一张
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:_arrayData.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}
//* 滚动完毕调用（如果不是人为拖拽scrollView导致滚动完毕，且animated=YES才会调用这个方法）-scrollToItemAtIndexPath:atScrollPosition:animated:(BOOL)animated;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    NSLog(@"AAAA_____%s",__FUNCTION__);
//    return;
//    NSLog(@"%f>%f",scrollView.contentOffset.x,self.jl_width);
    // 获取当前页数
    NSInteger page;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        page = scrollView.contentOffset.y / self.jl_height;
    }else{
        page = scrollView.contentOffset.x / self.jl_width;
    }
    
    if (page == _arrayData.count+1 && _arrayData.count>1) {//最后一张跳转第一张
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    if (page == 0 && _arrayData.count>1) { //第一张跳转最后一张
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:_arrayData.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }

}
#pragma mark - 自动翻页
-(void)automaticScrollPage
{

    if (!_arrayData || _arrayData.count <= 1)return;
    // 获取当前页数
    
    NSInteger page;
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        page = _collectionView.contentOffset.y / self.jl_height;
    }else{
        page = _collectionView.contentOffset.x / self.jl_width;
    }
    
    if (page<_arrayData.count+1 ) {
        
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:page+1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    if (page == _arrayData.count+1) {
        
        NSIndexPath *IndexPathDefault = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:IndexPathDefault atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    
}
//＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊--NSTimer---＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
#pragma mark ------NSTimer------
- (void)setupTimer
{
    [self deallocTimer];
    if (!_arrayData || _arrayData.count <= 1)return;
    NSTimeInterval timeduration = self.timeDuration?self.timeDuration:TIMEDURATION;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeduration target:self selector:@selector(automaticScrollPage) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)setTimeDuration:(NSTimeInterval)timeDuration
{
    _timeDuration = timeDuration;
    [self deallocTimer];
    [self setupTimer];
}
//暂停定时器
-(void)pauseTimer
{
    if(self.timer&&[self.timer isValid]){ //是否在运行
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
//开启定时器
-(void)resumeTimerAfterDuration:(NSTimeInterval)duration
{
    if(self.timer&&[self.timer isValid]){
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:duration]];
    }
}
//销毁定时器
-(void)deallocTimer
{
    if (self.timer && self.timer.isValid) {
        [_timer invalidate];
        _timer=nil;
    }
}
//在视图移除时销毁定时器
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self deallocTimer];
    }
}






-(void)dealloc
{
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
    NSLog(@"%s",__FUNCTION__);
}

//-(void)willRemoveSubview:(UIView *)subview
//{
//    
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
