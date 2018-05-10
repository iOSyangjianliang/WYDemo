//
//  JLPageControl.m
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/1.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import "JLPageControl.h"
#import "UIView+FrameHelp.h"

#define dotW 15 //宽
#define dotH 2 //高

#define magrin 5 //间隙

@implementation JLPageControl


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.style == JLPageControlImageStyle) {
        [self changeSubviewPages];
    }
}
-(void)setStyle:(JLPageControlStyle)style
{
    _style = style;
    [self layoutSubviews];
}
//利用遍历子控件修改每一个Page的size及Page之间间隙
-(void)changeSubviewPages
{

    //计算圆点间距(宽+间隙)
    CGFloat marginX = dotW + magrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = self.subviews.count * marginX;
    
    //设置新frame
    self.frame = CGRectMake(self.jl_x, self.jl_y, newW-magrin, self.jl_height);
    
    //设置居中
    self.jl_centerX = self.superview.jl_width/2;
//    NSLog(@"%@-%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.superview.frame));
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
//        NSLog(@"%@",NSStringFromCGRect(dot.frame));

        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        }
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
