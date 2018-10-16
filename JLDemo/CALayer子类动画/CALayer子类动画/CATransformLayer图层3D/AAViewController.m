//
//  AAViewController.m
//  CALayer及子类使用
//
//  Created by 杨建亮 on 2018/10/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AAViewController.h"


@interface AAViewController (){
    CGPoint startPoint;
    CATransformLayer *s_Cube;
    float pix, piy;
}

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //画个立方体
    CATransform3D c1t = CATransform3DIdentity;
    CALayer *cube1 = [self cubeWithTransform:c1t];
    s_Cube = (CATransformLayer *)cube1;
    [self.view.layer addSublayer:cube1];
}
- (CALayer *)faceWithTransform:(CATransform3D)transform color:(UIColor*)color
{
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    face.backgroundColor = color.CGColor;
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    //3D容器
    CATransformLayer *cube = [CATransformLayer layer];
    
    //前
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor redColor]]];
    
    //右
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor yellowColor]]];
    
    //上
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor blueColor]]];
    
    //下
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor brownColor]]];
    
    //左
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor greenColor]]];
    
    //后
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor orangeColor]]];
    
    //
    CGSize containerSize = self.view.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0,
                                containerSize.height / 2.0);
    
    cube.transform = transform;
    return cube;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    CGFloat deltaX = startPoint.x - currentPosition.x;
    CGFloat deltaY = startPoint.y - currentPosition.y;
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DRotate(c1t, pix + M_PI_2 * deltaY / 100, 1, 0, 0);
    c1t = CATransform3DRotate(c1t, piy - M_PI_2 * deltaX / 100, 0, 1, 0);
    s_Cube.transform = c1t;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    CGFloat deltaX = startPoint.x - currentPosition.x;
    CGFloat deltaY = startPoint.y - currentPosition.y;
    pix = M_PI_2 * deltaY / 100;
    piy = -M_PI_2 * deltaX / 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
