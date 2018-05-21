//
//  NewViewController.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.bounds.size.height
#import "NewViewController.h"
#import "NewCollectionViewCell.h"
#import "YJLRequestData.h"
#import "MJRefresh.h"
#import "LiveViewController.h"
#import "HotLiveModel.h"

@interface NewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView* _collectionView;
    UICollectionViewFlowLayout* _flowLayout;
    NSMutableArray* _arrayData;
    NSInteger _currentPage;
}
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _currentPage = 1;
    _arrayData = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self requestData];
    [self buildCollectionView];
}
-(void)requestData
{
    [YJLRequestData getNewLivDataWithPath:_currentPage Complention:^(NSArray *array) {
        if (_currentPage == 1) {
            _arrayData  =[NSMutableArray arrayWithArray:array];
        }else{
            [_arrayData addObjectsFromArray:array];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
            [_collectionView.mj_footer endRefreshing];
            [_collectionView.mj_header endRefreshing];
        });
    } error:^(NSError *error) {
        NSLog(@"最新数据请求失败%@",error);
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];

    }];
}
-(void)buildCollectionView
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake((SCR_W-2)/3, (SCR_W-2)/3);
    _flowLayout.minimumInteritemSpacing= 1.0;
    _flowLayout.minimumLineSpacing = 1.0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H-64-44) collectionViewLayout:_flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate =self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //下拉刷新
    NSMutableArray *headerImages = [NSMutableArray array];
    NSArray* imgArray = @[@"reflesh1_60x55",@"reflesh2_60x55",@"reflesh3_60x55"];
    for (int i = 0; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:imgArray[i]];
        [headerImages addObject:image];
    }
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        _currentPage = 1;
        [self requestData];
    }];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [gifHeader setImages:@[headerImages[0]] forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStateRefreshing];
    _collectionView.mj_header = gifHeader;
    

    //上拉加载
    MJRefreshAutoGifFooter *gifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        _currentPage ++;
        [self requestData];
    }];
    _collectionView.mj_footer = gifFooter;

    [self.view addSubview:_collectionView];
    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"NewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NEW"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrayData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NEW" forIndexPath:indexPath];
    HotLiveModel* model = _arrayData[indexPath.row];
    [cell setHotModel:model];
    return cell;
    
}
#pragma mark - cell 将要显示的时候动画
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.layer.transform = CATransform3DMakeRotation(M_PI, 0.5, 0.5, 0.2);
   cell.layer.transform= CATransform3DMakeScale(0.5,0.5,0.5);
    // 恢复
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DIdentity;
    }];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LiveViewController* liveVC = [[LiveViewController alloc] init];
    HotLiveModel* hoModel = _arrayData[indexPath.row];
    liveVC.hotModel = hoModel;
    liveVC.arrayData = _arrayData;
    liveVC.index = indexPath.row;
    liveVC.num = 2;
    [self presentViewController:liveVC animated:YES completion:nil];

}
@end
