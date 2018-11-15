//
//  FFViewController.m
//  CALayer子类动画
//
//  Created by 杨建亮 on 2018/10/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "FFViewController.h"

@interface FFViewController ()
{
    UIImageView* _tree;
}
@end

@implementation FFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    
    //1.添加一棵🌲
//    [self addTree];
    
    //2.
    [self boFangLiZhi];
}
-(void)addTree
{
    _tree  = [[UIImageView alloc] initWithFrame:self.view.frame];
    _tree.image = [UIImage imageNamed:@"005.jpg"];
    //    _tree.contentMode =
    [self.view addSubview: _tree];
    
    //方向
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    
    //发射的位置
    layer.emitterPosition = CGPointMake(80, -80);
    //发射区域大小
    layer.emitterSize = CGSizeMake(self.view.frame.size.width, 0);
    //发射模式
    layer.emitterMode = kCAEmitterLayerOutline;
    //发射的路线
    layer.emitterShape = kCAEmitterLayerLine;
    
    CAEmitterCell* cell = [CAEmitterCell emitterCell];
    //设置粒子显示的内容
    cell.contents = (id)[UIImage imageNamed:@"flower"].CGImage;
    //存活时间（单位s）
    cell.lifetime = 60;
    //每秒产生多少个
    cell.birthRate = 10;
    
    //设置花瓣缩放比例(范围)
    cell.scaleRange = 0.1;
    cell.scale = 0.4;
    
    //设置cell掉落角度
    cell.emissionRange = M_PI;
    //设置旋转速度
    cell.spin = M_PI_4;
    
    
    cell.velocity = 35;
    cell.velocityRange = 70;
    
    layer.emitterCells = [NSArray arrayWithObjects:cell, nil];
    [_tree.layer addSublayer:layer];
    
}





//播放粒子效果
-(void)boFangLiZhi
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    // 发射器在xy平面的中心位置
    CGPoint point = self.view.center;
    point.y-= 50;
    NSLog(@">>>>>>>>%f",point.y);
    emitterLayer.emitterPosition = point;
    // 发射器的尺寸大小
    emitterLayer.emitterSize = CGSizeMake(20, 20);
    // 渲染模式
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
    // 开启三维效果
    //    emitterLayer.preservesDepth = YES;
    NSMutableArray *array = [NSMutableArray array];
    // 创建粒子
    for (int i = 0; i<10; i++) {
        // 发射单元
        CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
        // 粒子的创建速率，默认为1/s
        stepCell.birthRate = 1;
        // 粒子存活时间
        stepCell.lifetime = arc4random_uniform(2) + 1;
        // 粒子的生存时间容差
        stepCell.lifetimeRange = 1.2;
        // 颜色
        // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30_", i]];
        
        // 粒子显示的内容
        stepCell.contents = (id)[image CGImage];
        // 粒子的名字
        //            [fire setName:@"step%d", i];
        // 粒子的运动速度
        stepCell.velocity = arc4random_uniform(100) + 100;
        // 粒子速度的容差
        stepCell.velocityRange = 80;
        // 粒子在xy平面的发射角度
        stepCell.emissionLongitude = M_PI+M_PI_2;;
        // 粒子发射角度的容差
        stepCell.emissionRange = M_PI_2/6;
        // 缩放比例
        stepCell.scale = 0.35;
        [array addObject:stepCell];
    }
    emitterLayer.emitterCells = array;
    [self.view.layer addSublayer:emitterLayer];
}
@end
