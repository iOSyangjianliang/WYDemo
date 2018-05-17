//
//  ViewController.m
//  collectionView的cell自适应Demo
//
//  Created by 杨建亮 on 2018/5/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "AACollectionViewCell.h"

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
    
    [self buildUI];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(touchesBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)touchesBtn
{
    [self.view endEditing:YES];
}
- (void)buildUI
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.itemSize = CGSizeMake(100, 300);
    //        _flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
    //        _flowLayout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
    //    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //在iOS8.1-8.2中不能使用estimatedItemSize, bug:http://www.bubuko.com/infodetail-1686310.html
    _flowLayout.estimatedItemSize = CGSizeMake(100, 300);//  UICollectionViewFlowLayoutAutomaticSize只支持10+
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_collectionView];
    
    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"AACollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RID"];
    
    
    // 注册头尾视图
    [_collectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"QAQ"];
    [_collectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"QAQ"];
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
    cell.backgroundColor = [UIColor purpleColor];
    cell.flowLayout = _flowLayout;
    return cell;
}

#pragma mark - 返回item大小
//- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@">>>>>>>%s",__FUNCTION__);
//    return CGSizeMake(100, 100);
//
//    //    NSLog(@"%@",NSStringFromCGSize(UICollectionViewFlowLayoutAutomaticSize));
//    //    return UICollectionViewFlowLayoutAutomaticSize;
//}

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







