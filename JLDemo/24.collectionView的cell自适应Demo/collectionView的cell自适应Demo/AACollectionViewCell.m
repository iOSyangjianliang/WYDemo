//
//  AACollectionViewCell.m
//  collectionView的cell自适应Demo
//
//  Created by 杨建亮 on 2018/5/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AACollectionViewCell.h"

@interface AACollectionViewCell ()
@property(nonatomic, assign) CGFloat textH;
@end

@implementation AACollectionViewCell

- (void)awakeFromNib {
    NSLog(@"%s——1",__FUNCTION__);
    [super awakeFromNib];
    // Initialization code
    NSLog(@"%s——2",__FUNCTION__);

    self.jltextView.text = @"dadb大师大师大师大师大师大师大师的啊大师大师大师大师的撒大是大非克拉发发发发";
    
    self.jltextView.sizeToFitHight = YES;
    self.jltextView.minNumberOfLines  = 2;
    self.jltextView.maxNumberOfLines  = 4;
    self.textH = self.jltextView.minTextHeight;
    [self.jltextView addTextHeightDidChangeHandler:^(JLTextView *view, CGFloat textHeight) {
        self.textH = textHeight;
        [self.flowLayout invalidateLayout];
    }];
}

//在实例从重用队列返回之前，由集合视图调用。
-(void)prepareForReuse
{
//    NSLog(@"%s——1",__FUNCTION__);
    [super prepareForReuse];
//    NSLog(@"%s——2",__FUNCTION__);
}
//根据LayoutAttributes来布局当前View，在view被添加到collectionView上但是还没有被复用队列返回的时候调用
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
//    NSLog(@"%s",__FUNCTION__);
    [super applyLayoutAttributes:layoutAttributes];
//    NSLog(@"%s",__FUNCTION__);
}
-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    NSLog(@"%s",__FUNCTION__);
    
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
   
    CGRect frame = attributes.frame;
    frame.size.width = 250;
    CGFloat h = self.textH;
    frame.size.height = h+20+30.f;
    attributes.frame = frame;
   
    return attributes;
}
@end
