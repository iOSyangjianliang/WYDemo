//
//  ViewController.m
//  cell宽高自适应的demo
//
//  Created by 杨建亮 on 2018/2/8.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "AACollectionViewCell.h"
#import "AACollectionReusableView.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_arrayM;
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_flowLayout;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 获取数据
    [self requestData];
    
    // 2. 搭建UI
    [self buildUI];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)buildUI
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    _flowLayout.itemSize = CGSizeMake(100, 100);
//        _flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
//        _flowLayout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
//    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    //自适应只支持10+
    _flowLayout.estimatedItemSize =  UICollectionViewFlowLayoutAutomaticSize ;//CGSizeMake(100, 300) ;//

    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_collectionView];
    
    // 注册cell
    [_collectionView registerClass:[AACollectionViewCell class] forCellWithReuseIdentifier:@"RID"];


    // 注册头尾视图
    [_collectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"QAQ"];
    [_collectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QAQ"];
}

- (void)requestData
{
    _arrayM = [NSMutableArray array];
    for (int i = 1; i <=6; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [_arrayM addObject:image];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  3;//_arrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@">>>>>>>%s",__FUNCTION__);

    AACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RID" forIndexPath:indexPath];
    cell.imageView.image = _arrayM[indexPath.row];
    
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - 返回item大小
- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>>>>>>%s",__FUNCTION__);
    return CGSizeMake(100, 100);
    
//    NSLog(@"%@",NSStringFromCGSize(UICollectionViewFlowLayoutAutomaticSize));
//    return UICollectionViewFlowLayoutAutomaticSize;
}

#pragma mark 设置头尾视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 50);

}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 50);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 0, 70, 0);
}
#pragma mark 返回头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    AACollectionViewCell *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"QAQ" forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionFooter) {
        UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        footLabel.text = @"下雨了，该买船了";
        [view addSubview:footLabel];
        view.backgroundColor = [UIColor greenColor];
        
    }else if (kind == UICollectionElementKindSectionHeader){
        UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        footLabel.text = @"几十米的海浪过来了";
        [view addSubview:footLabel];
        view.backgroundColor = [UIColor redColor];
    }
    
    return view;
}

#pragma mark 用户点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end







