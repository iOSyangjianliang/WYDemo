//
//  ViewController.m
//  collectionView的cell自适应Demo
//
//  Created by 杨建亮 on 2018/5/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "AACollectionViewCell.h"
#import "AACollectionReusableView.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITextViewDelegate>
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_flowLayout;
    
    NSString *_textFiledStr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textFiledStr = @"";
    
    [self buildUI];
    
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-90,20, 90, 40)];
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"收起键盘" forState:UIControlStateNormal];
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
    //        _flowLayout.itemSize = CGSizeMake(100, 300);
    //        _flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
    //        _flowLayout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
    //        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //自适应cell调整不能使用组头，不然会有组头尾布局问题
    //在iOS8.1-8.2中不能使用estimatedItemSize, bug:http://www.bubuko.com/infodetail-1686310.html
    //NSLog(@"%@",NSStringFromCGSize(UICollectionViewFlowLayoutAutomaticSize)); //=CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
    
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
    return 1;//20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;// 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
//    if (indexPath.section==0&& indexPath.row==0) {
//        cell.jltextView.text = _textFiledStr;
//    }else{
//        cell.jltextView.text = @"";
//    }
    
    cell.flowLayout = _flowLayout;
    cell.jltextView.delegate = self;
    return cell;
}
//#pragma mark 设置头尾视图的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(self.view.frame.size.width, 50);
//}
//- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return  CGSizeMake(self.view.frame.size.width, 50);
//}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(40, 0, 40, 0);
}
#pragma mark 返回头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    AACollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"QAQ" forIndexPath:indexPath];
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

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _textFiledStr = [NSString stringWithFormat:@"%@", textView.text];
    NSLog(@"_textFiledStr=%@",_textFiledStr);
}
-(void)textViewDidChange:(UITextView *)textView
{
    JLTextView *textV = (JLTextView *)textView;
    NSLog(@"%ld",textV.curryLines);
}
@end







