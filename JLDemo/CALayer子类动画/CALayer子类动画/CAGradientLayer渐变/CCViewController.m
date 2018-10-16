//
//  CCViewController.m
//  CALayer子类动画
//
//  Created by 杨建亮 on 2018/10/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "CCViewController.h"

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.
    //    [self addGradientLayer];
    
    //2.
    //    [self addGradientLayer_1];
    
    //3.
    //        [self addGradientLayer_2];
    
    //4.
    [self test_music];
    
}
-(void)addGradientLayer
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 300, 200, 25);
    [gradientLayer setStartPoint:CGPointMake(0.0, 0.0)];
    [gradientLayer setEndPoint:CGPointMake(0.0, 1.0)];
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor purpleColor].CGColor,(id)[UIColor blueColor].CGColor];
    [self.view.layer addSublayer:gradientLayer];
    
    UILabel *label = [[UILabel alloc] initWithFrame:gradientLayer.bounds];
    label.text = @"红紫蓝垂直渐变~~";
    label.font = [UIFont boldSystemFontOfSize:25];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    gradientLayer.mask = label.layer; //把文字label的layer作为渐变背景色的蒙层，也就是两layer合成
    
    //    这里label的layer是mask，有对象的地方就是文字的部分，有文字的地方是透明的，就可以看见被其遮罩的渐变层gradientLayer的内容，而没有对象的部门是不透明的，所以文字外面就看不到其遮罩的渐变层gradientLayer的内容。
}

-(void)addGradientLayer_1
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(50, 300, 300, 300);
    
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor,(id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0.1, @0.2, @1];
    
    [gradientLayer setStartPoint:CGPointMake(0.0, 0.5)];
    [gradientLayer setEndPoint:CGPointMake(1.0, 0.5)];
    
    
    [self.view.layer addSublayer:gradientLayer];
}


- (void)addGradientLayer_2
{
    
    //创建圆弧路径
    UIBezierPath * path      = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:45 startAngle:- 7.0 / 6 * M_PI endAngle:M_PI / 6 clockwise:YES];
    
    //添加圆弧Layer
    [self.view.layer addSublayer:[self createShapeLayerWithPath:path]];
    
    //配置左色块CAGradientLayer
    CAGradientLayer * leftL  = [self createGradientLayerWithColors:@[(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor]];
    leftL.position           = CGPointMake(25, 40);
    
    //配置右色块CAGradientLayer
    CAGradientLayer * rightL = [self createGradientLayerWithColors:@[(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor]];
    rightL.position          = CGPointMake(75, 40);
    
    //将两个色块拼接到同一个layer并添加到self.view
    CALayer * layer          = [CALayer layer];
    layer.bounds             = CGRectMake(0, 0, 100, 80);
    layer.position           = self.view.center;
    [layer addSublayer:leftL];
    [layer addSublayer:rightL];
    [self.view.layer addSublayer:layer];
    
    //创建一个ShapeLayer作为mask
    CAShapeLayer * mask = [self createShapeLayerWithPath:path];
    mask.position       = CGPointMake(50, 40);
    layer.mask          = mask;
    //mask.strokeEnd = 1;
}

//依照路径创建并返回一个CAShapeLayer
-(CAShapeLayer *)createShapeLayerWithPath:(UIBezierPath *)path {
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path           = path.CGPath;
    layer.bounds         = CGRectMake(0, 0, 100, 75);
    layer.position       = self.view.center;
    layer.fillColor      = [UIColor clearColor].CGColor;
    layer.strokeColor    = [UIColor colorWithRed:33 / 255.0 green:192 / 255.0 blue:250 / 255.0 alpha:1].CGColor;
    layer.lineCap        = @"round";
    layer.lineWidth      = 10;
    
    return layer;
}

//依照给定的颜色数组创建并返回一个CAGradientLayer
-(CAGradientLayer *)createGradientLayerWithColors:(NSArray *)colors {
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors            = colors;
    gradientLayer.locations         = @[@0,@0.8];
    gradientLayer.startPoint        = CGPointMake(0, 1);
    gradientLayer.endPoint          = CGPointMake(0, 0);
    gradientLayer.bounds            = CGRectMake(0, 0, 50, 80);
    
    return gradientLayer;
}

-(void)test_music
{
    //参照、或最底层图层
    UILabel *lab_1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 300, 40)];
    lab_1.textColor = [UIColor whiteColor];
    lab_1.backgroundColor = [UIColor blueColor];
    lab_1.text = @"我有一只小毛驴，从来都不起";
    [self.view addSubview:lab_1];
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 300, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"我有一只小毛驴，从来都不起";
    [self.view addSubview:lab];
    
    
    //普通图层
    //    CALayer *maskLayer = [CALayer layer];
    //    maskLayer.backgroundColor = [[UIColor purpleColor] CGColor];
    //    maskLayer.anchorPoint = CGPointZero;
    //    maskLayer.frame = CGRectMake( 50, 200, 0, 40);
    //    [self.view.layer addSublayer: maskLayer];;
    
    //渐变图层
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    maskLayer.frame = CGRectMake( 50, 200, 0, 40);
    [maskLayer setStartPoint:CGPointMake(0.0, 0.0)];
    [maskLayer setEndPoint:CGPointMake(0.0, 1.0)];
    maskLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor purpleColor].CGColor,(id)[UIColor blueColor].CGColor];
    [self.view.layer addSublayer:maskLayer];
    
    
    maskLayer.mask = lab.layer;
    //
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CATransaction setValue:[NSNumber numberWithFloat:10.0f] forKey:kCATransactionAnimationDuration];
        maskLayer.frame = CGRectMake( 50, 200, 300, 40);
    });
    
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
