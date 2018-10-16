
//
//  DDViewController.m
//  CALayer子类动画
//
//  Created by 杨建亮 on 2018/10/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#define UIColorFromRGB_HexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.f]


#import "DDViewController.h"

@interface DDViewController ()
{
    CATextLayer *textLayer;
    CAGradientLayer *gradientLayer;
    UIView* bgView;
}
@end
@implementation DDViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
    [btn setTitle:@"开始动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.width)];
    bgView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:bgView];
    
    textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake((bgView.frame.size.width - 200)/2, (bgView.frame.size.width - 200)/2, 200, 200);
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode =kCAAlignmentJustified;
    textLayer.wrapped =YES;
    UIFont *font = [UIFont systemFontOfSize:30];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef =CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    NSString *text =@"习惯不曾习惯的习惯会习惯 舍得不曾舍得的舍得会舍得";
    textLayer.string = text;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [bgView.layer addSublayer:textLayer];
    //创建背景图层
    gradientLayer =  [CAGradientLayer layer];
    [gradientLayer setColors:[NSArray arrayWithObjects:
                              (id)[UIColorFromRGB_HexValue(0x000000) CGColor],
                              (id)[UIColorFromRGB_HexValue(0xFFD700) CGColor],
                              (id)[UIColorFromRGB_HexValue(0x000000) CGColor],
                              (id)[UIColorFromRGB_HexValue(0xFFD700) CGColor],
                              (id)[UIColorFromRGB_HexValue(0x000000) CGColor],
                              (id)[UIColorFromRGB_HexValue(0xFFD700) CGColor],
                              (id)[UIColorFromRGB_HexValue(0x000000) CGColor],
                              (id)[UIColorFromRGB_HexValue(0xFFD700) CGColor],
                              (id)[UIColorFromRGB_HexValue(0x000000) CGColor],
                              (id)[UIColorFromRGB_HexValue(0xFFD700) CGColor],
                              (id)[UIColorFromRGB_HexValue(0x000000) CGColor],
                              (id)[[UIColor clearColor] CGColor],
                              nil]];
    gradientLayer.frame = bgView.bounds;
    [gradientLayer setLocations:[NSArray arrayWithObjects:
                                 [NSNumber numberWithFloat:0.0],
                                 [NSNumber numberWithFloat:0.1],
                                 [NSNumber numberWithFloat:0.2],
                                 [NSNumber numberWithFloat:0.3],
                                 [NSNumber numberWithFloat:0.4],
                                 [NSNumber numberWithFloat:0.5],
                                 [NSNumber numberWithFloat:0.6],
                                 [NSNumber numberWithFloat:0.7],
                                 [NSNumber numberWithFloat:0.8],
                                 [NSNumber numberWithFloat:0.9],
                                 [NSNumber numberWithFloat:1.0],
                                 nil]];
    
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 1)];
    [gradientLayer setMask:textLayer]; //用progressLayer来截取渐变层
    [bgView.layer addSublayer:gradientLayer];
}
- (void)clickBtn{
    //动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint fromPoint = textLayer.position;
    CGPoint toPoint = CGPointMake(fromPoint.x + (bgView.frame.size.width - 200)/2, fromPoint.y);
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.autoreverses = YES;
    [textLayer addAnimation:animation forKey:nil];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint fromPoint2 = gradientLayer.position;
    CGPoint toPoint2 = CGPointMake(fromPoint.x - (bgView.frame.size.width - 200)/2, fromPoint.y);
    animation2.duration = 1;
    animation2.fromValue = [NSValue valueWithCGPoint:fromPoint2];
    animation2.toValue = [NSValue valueWithCGPoint:toPoint2];
    animation2.autoreverses = YES;
    [gradientLayer addAnimation:animation2 forKey:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
