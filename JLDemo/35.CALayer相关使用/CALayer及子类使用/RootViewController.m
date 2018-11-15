
//
//  RootViewController.m
//  CALayer及子类使用
//
//  Created by 杨建亮 on 2018/10/12.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property(nonatomic ,strong) CALayer *layer;

@property(nonatomic ,strong) UIView *testView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    //4.
//    [self test_fillMode];
   
    [self initTestLayer];
}

-(void)initTestLayer
{
    _layer=[CALayer layer];
    _layer.bounds = CGRectMake(0, 0, 200, 200);
    _layer.position = CGPointMake(160, 250);
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.borderColor = [UIColor blackColor].CGColor;
    _layer.opacity = 1.0f;
    [self.view.layer addSublayer:_layer];
    
    _testView = [[UIView alloc] init];
    _testView.frame           = CGRectMake(60, 400, 200, 200);
    _testView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_testView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //5.动画曲线
//        [self test_CAMediaTimingFunction];
    
    //6.事务处理-隐士动画
//    [self test_CATransaction];
    
    //6.1事务处理-显示事务
//    [self test_CATransaction_1];

    //7.
    UIViewController *vc = [[NSClassFromString(@"AAAViewController") alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)test_CATransaction_1
{
    //显示事务 通过明确的调用begin,commit来提交动画
     
    //修改执行时间
    [CATransaction begin];
    //显式事务默认开启动画效果,kCFBooleanTrue关闭
//    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [CATransaction setDisableActions:NO];//这种方法控制区直到函数的结束

    //动画执行时间-暂时改变响应改变图层属性的动画的时间,通过设置事务的kCATransactionAnimationDuration 键的值为新的时间。事务范围内所产生的任何动画都会使用该新设置的时间值而不是他们原有的值。
    [CATransaction setValue:[NSNumber numberWithFloat:5.0f] forKey:kCATransactionAnimationDuration];
    //[CATransaction setAnimationDuration:[NSNumber numberWithFloat:5.0f]];
    
    _layer.cornerRadius = (_layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
    _layer.opacity = (_layer.opacity == 1.0f) ? 0.5f : 1.0f;
    
    //显示动画对于UI控件(根图层)无效果
    _testView.layer.cornerRadius = 30.f;
    
    [CATransaction commit];
  
    
    /**
     
    // 事务嵌套
    [CATransaction begin];
    //可以在修改图层属性值的时候通过设置事务的 kCATransactionDisableActions值为 YES 来暂时禁用图层的行为。
    //在事务范围所作的任何更改也不会因此而发生的动画。
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
//    [CATransaction setDisableActions:YES];//这种方法控制区直到函数的结束

    _layer.cornerRadius = (_layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
    [CATransaction commit];
    //上面的动画并不会立即执行，需要等最外层的commit
    [NSThread sleepForTimeInterval:10];
    //显式事务默认开启动画效果,kCFBooleanTrue关闭
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    //动画执行时间
    [CATransaction setValue:[NSNumber numberWithFloat:10.0f] forKey:kCATransactionAnimationDuration];
    //[CATransaction setAnimationDuration:[NSNumber numberWithFloat:5.0f]];
    _layer.cornerRadius = (_layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
    [CATransaction commit];
   
    */
}
-(void)test_CATransaction
{
    /**
    隐式动画
    1.简单说明
    每一个UIView内部都默认关联着一个CALayer，我们可用称这个Layer为Root Layer（根图层）
    所有的非Root Layer，也就是手动创建的CALayer对象，都存在着隐式动画
    
     什么是隐式动画？
    当对非Root Layer的部分属性进行修改时，默认会自动产生一些动画效果,而这些属性称为Animatable Properties(可动画属性)
    */
    
    //暂时改变响应改变图层属性的动画的时间
    [CATransaction setValue:[NSNumber numberWithFloat:5.0f] forKey:kCATransactionAnimationDuration];

    //设置圆角
    _layer.cornerRadius = (_layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
    //设置透明度
    _layer.opacity = (_layer.opacity == 1.0f) ? 0.5f : 1.0f;
    
   
    
    //根涂层参照
    UIView *vvv  = [[UIView alloc] init];
    vvv.frame = CGRectMake(50, 350, 200, 200);
    vvv.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:vvv];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        vvv.layer.cornerRadius = 50.0f; //没有动画效果
    });
    

}

- (void)test_CAMediaTimingFunction
{
    
    //参照背景
    UIView *vvv  = [[UIView alloc] init];
    vvv.frame           = CGRectMake(50, 50, 200, 200);
    vvv.backgroundColor = [UIColor redColor];
    [self.view addSubview:vvv];

    
    // 初始化layer
    CALayer *layer        = [CALayer layer];
    layer.frame           = CGRectMake(50, 50, 200, 2);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    
    // 终点位置
    CGPoint endPosition = CGPointMake(layer.position.x, layer.position.y + 200);
    
    // 动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue         = [NSValue valueWithCGPoint:layer.position];
    animation.toValue           = [NSValue valueWithCGPoint:endPosition];
    //定义以三次贝塞尔曲线为模型的定时功能。 默认为nil表示线性。可设置动画曲线、
    animation.timingFunction    = [CAMediaTimingFunction functionWithControlPoints:0.0 :0.03 :0.13 :1.00];
    layer.position              = endPosition;
    animation.duration          = 1.f;
    
    // 添加动画
    [layer addAnimation:animation forKey:nil];
    
    
    // 添加layer
    [self.view.layer addSublayer:layer];
}
-(void)test_fillMode
{
    //    UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    //    vvv.backgroundColor = [UIColor purpleColor];
    //    vvv.layer.masksToBounds = YES;
    //    [self.view addSubview:vvv];
    //
    //    [UIView animateWithDuration:2 animations:^{
    //        vvv.frame = CGRectMake(10, 100, 200, 200);
    //
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    //    CFTimeInterval currentTime = CACurrentMediaTime();
    //    CFTimeInterval currentTimeInSuperLayer = [superLayer convertTime:currentTime fromLayer:nil];
    //    layer.beginTime = currentTimeInSuperLayer + 2;
    //    CFTimeInterval currentTimeInLayer = [layer convertTime:currentTimeInSuperLayer fromLayer:superLayer];
    //    CFTimeInterval addTime = currentTimeInLayer;
    //
    //    CAAnimationGroup *group = [CAAnimationGroup animation];
    //    group.beginTime = addTime + 1;
    //    group.animations = [NSArray arrayWithObject:anim];
    //    group.duration = 2;
    //    anim.beginTime = 0.5;
    //    [layer addAnimation:group forKey:nil];
    
    
    
    /**
     kCAFillModeRemoved也是fillMode的默认属性，此时动画的效果：开始时，colorLayer的size为（20，20），当到2s的时候，colorLayer的size突然就变为（100，100），然后开始做动画，当到7s的时候colorLayer的duration已经完成，此时colorLayer的size会突然 变为（20，20），然后在持续3s，当总时间到10s时结束。
     
     当fillMode的属性设置为kCAFillModeForwards的时候，动画效果为：开始时，colorLayer的size为（20，20），当到2s的时候，colorLayer的size突然就变为（100，100），然后开始做动画，之前都和kCAFillModeRemoved都一样，不一样的时当到7s的时候colorLayer的duration已经完成，此时colorLayer的size还会保持在（400，400），然后在持续3s，当总时间到10s时结束，此时size才变为（20，20）
     
     当fillMode的属性设置为kCAFillModeBackwards的时候，动画效果为：开始时，colorLayer的size就为（100，100），当到2s的时候，colorLayer开始做动画，当到7s的时候colorLayer的duration已经完成，此时colorLayer的size会突然 变为（20，20），然后在持续3s，当总时间到10s时结束。
     
     kCAFillModeBoth就不在解释了，猜都能猜到应该是kCAFillModeForwards和kCAFillModeBackwards的结合。
     */
    
    CALayer *colorLayer = [[ CALayer alloc] init];
    colorLayer.position = self.view.center;
    colorLayer.backgroundColor = [UIColor redColor].CGColor;
    colorLayer.bounds = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
    [self.view.layer addSublayer:colorLayer];
    
    CABasicAnimation *boundAn = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundAn.fromValue = [NSValue valueWithCGRect:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    boundAn.toValue = [NSValue valueWithCGRect:CGRectMake(0.0f, 0.0f, 400.0f, 400.0f)];
    boundAn.beginTime = 2.0f;
    boundAn.duration = 5.0f;
    boundAn.fillMode = kCAFillModeBoth;//测试属性
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObject:boundAn];
    group.duration = 10.0f;
    
    [colorLayer addAnimation:group forKey:nil];
    
    
}

@end
