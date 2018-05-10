//
//  JLLunBoPageControl.m
//  YiShangbao
//
//  Created by 杨建亮 on 2017/7/27.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import "JLLunBoPageControl.h"

@implementation JLLunBoPageControl
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self buildUI];
    }
    return self;
}
-(CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    return CGSizeMake(1, 1);
}
-(void)buildUI
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


