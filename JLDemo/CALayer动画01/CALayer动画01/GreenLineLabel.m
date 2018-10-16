//
//  GreenLineLabel.m
//  CALayer动画01
//
//  Created by 杨建亮 on 2018/10/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "GreenLineLabel.h"

@interface GreenLineLabel ()
@end

@implementation GreenLineLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maskLayer = [CALayer layer];
        _maskLayer.backgroundColor = [[UIColor whiteColor] CGColor];    // Any color, only alpha channel matters
        _maskLayer.anchorPoint = CGPointZero;
        _maskLayer.frame = CGRectOffset(self.frame, -CGRectGetWidth(self.frame), 0);
//        self.layer.mask = _maskLayer;
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)startAnimation {
    // Assume we calculated keyTimes and values
    NSMutableArray *keyTimes;
    NSMutableArray *values;
    CGFloat duration;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.keyTimes = keyTimes;
    animation.values = values;
    animation.duration = duration;
    animation.calculationMode = kCAAnimationLinear;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_maskLayer addAnimation:animation forKey:@"MaskAnimation"];
}

@end
