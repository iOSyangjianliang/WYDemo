//
//  HotViewController.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.bounds.size.height
#define ONE SCR_W/414.000000
#import "HotViewController.h"
#import "YJLRequestData.h"
#import "UIImageView+WebCache.h"
#import "GuangGaoModel.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "HotTableViewCell.h"
#import "RGBColor.h"
#import "LiveViewController.h"

@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tableView;
    UIScrollView* _GuangGaoScrollerView;
    UIScrollView* _scrollerView;
    UIView* _HeaderView;
    NSMutableArray* _arrayIMGs;
    NSMutableArray* _arrayLiveList;
}
@property (nonatomic ,assign)NSInteger currentPage;
@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayLiveList = [NSMutableArray array];
    _currentPage = 1;
    [self requestGuangGaoData];
    [self requestTableViewData];
    [self creatScrollerView];
    [self buildTableView];
    self.view.backgroundColor = [UIColor yellowColor];
}
#pragma mark -请求数据
//广告轮播图
-(void)requestGuangGaoData
{
    [YJLRequestData getGuangGaoDataToComplention:^(NSArray *arrary) {
        _arrayIMGs = [NSMutableArray arrayWithArray:arrary];
        [self addGuangGaoScrollerViewToHeaderView];
    } error:^(NSError *error) {
        NSLog(@"广告请求出错");
    }];
}
//tableViewData
-(void)requestTableViewData
{
    [YJLRequestData getHotLivDataWithPath:_currentPage Complention:^(NSArray *array) {
        if (self.currentPage == 1) {
            _arrayLiveList  =[NSMutableArray arrayWithArray:array];
        }else{
            [_arrayLiveList addObjectsFromArray:array];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
        });

    } error:^(NSError *error) {
        NSLog(@"tableView数据失败>>%@",error);
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - 给tableview头视图加滚动视图
-(void)addGuangGaoScrollerViewToHeaderView
{
    _GuangGaoScrollerView = [[UIScrollView alloc] initWithFrame:_HeaderView.frame];
    _GuangGaoScrollerView.contentSize = CGSizeMake(SCR_W*_arrayIMGs.count, 100);
//    _GuangGaoScrollerView.backgroundColor = [UIColor redColor];
    _GuangGaoScrollerView.pagingEnabled = YES;
    _GuangGaoScrollerView.bounces = NO;
    //    _GuangGaoScrollerView.delegate =self;
    _GuangGaoScrollerView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i<_arrayIMGs.count; ++i) {
        CGFloat X = i*SCR_W;
        UIImageView* imV = [[UIImageView alloc] initWithFrame:CGRectMake(X, 0, SCR_W, 100)];
        GuangGaoModel* model = _arrayIMGs[i];
        [imV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        [_GuangGaoScrollerView addSubview:imV];
    }
    [_HeaderView addSubview:_GuangGaoScrollerView];
}
-(void)creatScrollerView
{
    _HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, 100)];
    _HeaderView.backgroundColor = [UIColor whiteColor];
}
-(void)buildTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H-64-44) style:UITableViewStylePlain];
    _tableView.rowHeight = SCR_W+56;;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = _HeaderView;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self requestGuangGaoData];
        [self requestTableViewData];
    }];
    //上拉加载
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        self.currentPage ++;
        [self requestTableViewData];
    }];
//    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_tableView];
    //约束加在tableview添加到主视图之后
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(0);
//        make.left.equalTo(self.view.mas_left).offset(0);
//        make.right.equalTo(self.view.mas_right).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//    } ];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayLiveList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FI"];
    if (cell == nil) {
        //loadNibNamed + xib文件的名字
        cell = [[NSBundle mainBundle] loadNibNamed:@"HotTableViewCell" owner:nil options:nil][0];
    }
    HotLiveModel* hoModel = _arrayLiveList[indexPath.row];
    [cell setHotModel:hoModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [RGBColor colorWithHexString:@"#FFFAFA"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveViewController* liveVC = [[LiveViewController alloc] init];
    HotLiveModel* hoModel = _arrayLiveList[indexPath.row];
    liveVC.hotModel = hoModel;
    liveVC.arrayData = _arrayLiveList;
    liveVC.index = indexPath.row;
    liveVC.num = 1;
    [self presentViewController:liveVC animated:YES completion:nil];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
////    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
//    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
//    if (translation.y>0) {
//        NSLog(@"xia ---%f",translation.y);
//        
//        CGRect frame = self.navigationController.navigationBar.frame;
//        frame.origin.y = -44+translation.y;
//        if (translation.y >= 64) {
//            frame.origin.y = 20;
//        }
//        self.navigationController.navigationBar.frame = frame;
////        _tableView.frame = CGRectMake(0, 0, SCR_W, SCR_H-64-44);
//    }else if(translation.y<0){
//        NSLog(@"shang --- %f",translation.y);
//        
//        CGRect frame = self.navigationController.navigationBar.frame;
//        frame.origin.y = translation.y;
//        if (translation.y <= -44) {
//            frame.origin.y = -44;
//        }
//        self.navigationController.navigationBar.frame = frame;
//        CGRect fra = _tableView.frame;
//        fra.origin.y = -20+translation.y;//CGRectGetMinY(self.navigationController.navigationBar.frame);
//        _tableView.frame = fra;;
//    }
//    
//
//}
//

//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
//状态栏动画
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}
//是否隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}






@end
