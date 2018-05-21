//
//  FirstViewController.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.bounds.size.height
#define ONE SCR_W/414.000000
#import "FirstViewController.h"
#import "RGBColor.h"

@interface FirstViewController ()<UIScrollViewDelegate>
{
    UIScrollView* _scrollView;
    UIButton* _lastBtn;
    UILabel* _line;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%f,%f",self.view.frame.size.width,self.view.frame.size.height);
    [self creatNAVCTitleView];
    [self buildSrollerView];
    
}
-(void)creatNAVCTitleView
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_W*0.66, 32)];
    view.backgroundColor = [UIColor clearColor];
    NSArray* array = @[@"同城",@"最新",@"关注"];
    for (int i=0; i<3; ++i) {
        CGFloat X = i*SCR_W*0.22;
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(X, 0, SCR_W*0.22, 30)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.tag = 100+i;
        if (i==0) {
            btn.selected = YES;
            _lastBtn = btn;
        }
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    _line = [[UILabel alloc] initWithFrame:CGRectMake(9, 30, SCR_W*0.22-18, 2)];
    _line.backgroundColor = [RGBColor colorWithHexString:@"#F4A460"];
    [view addSubview:_line];

    self.navigationItem.titleView = view;
}
-(void)clickBtn:(UIButton*)sender
{
    if (_lastBtn == sender) {
        return;
    }
    sender.selected = YES;
    _lastBtn.selected= NO;
    _lastBtn = sender;
    [UIView animateWithDuration:0.3 animations:^{
        _line.frame = CGRectMake(9+SCR_W*0.22*(sender.tag-100), 30, SCR_W*0.22-18, 2);
    }];
    [_scrollView setContentOffset:CGPointMake(SCR_W*(sender.tag-100), 0) animated:YES];
}
#pragma mark 完成减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / SCR_W;
    UIButton* bto = [self.navigationItem.titleView viewWithTag:100+page];
    if (bto == _lastBtn) {
        return;
    }
    bto.selected = YES;
    _lastBtn.selected = NO;
    _lastBtn = bto;
    [UIView animateWithDuration:0.3 animations:^{
        _line.frame = CGRectMake(9+SCR_W*0.22*page, 30, SCR_W*0.22-18, 2);
    }];
}

-(void)buildSrollerView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.contentSize = CGSizeMake(SCR_W*3, 0);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate =self;
    // 隐藏水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [self addViewcontrollers];
}
-(void)addViewcontrollers
{
    NSArray* arrayCV = @[@"HotViewController",@"NewViewController",@"GuanZhuViewController"];
    for (int i=0; i<3; ++i) {
        Class cl = NSClassFromString(arrayCV[i]);
        UIViewController* viewController = [[cl alloc] init];
        viewController.view.frame = CGRectMake(SCR_W*i, 0, SCR_W, _scrollView.frame.size.height);
        [_scrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }
}






@end
