//
//  AACollectionReusableView.m
//  cell宽高自适应的demo
//
//  Created by 杨建亮 on 2018/2/8.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AACollectionReusableView.h"

@implementation AACollectionReusableView



-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    NSLog(@"%s",__FUNCTION__);
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    CGRect frame = attributes.frame;
    frame.size.height = 150;
    attributes.frame = frame;
    return attributes;
}
@end
