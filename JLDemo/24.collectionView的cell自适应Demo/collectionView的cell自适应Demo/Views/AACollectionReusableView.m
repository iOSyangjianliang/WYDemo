//
//  AACollectionReusableView.m
//  collectionView的cell自适应Demo
//
//  Created by 杨建亮 on 2018/5/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AACollectionReusableView.h"

@implementation AACollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//卧槽，并不会调用
-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    NSLog(@"%s",__FUNCTION__);
    
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    CGRect frame = attributes.frame;
    frame.size.width = 320;
    frame.size.height = 100;
    attributes.frame = frame;
    
    return attributes;
}
@end
