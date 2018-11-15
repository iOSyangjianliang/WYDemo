//
//  GGViewController.m
//  CALayer子类动画
//
//  Created by 杨建亮 on 2018/10/17.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "GGViewController.h"

@interface GGViewController ()
{
    int _count;
    UIImage* _image;
    CADisplayLink* _disPlayLink;
    
}
@end

@implementation GGViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _count = 0;
    
    self.view.backgroundColor = [UIColor blackColor];
    _image = [UIImage imageNamed:@"snow"];
    
    //时钟(和NSTimer类似，区别在于它更精确，依据屏幕刷新频率，每秒60次)
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(beginSnow)];
    
    //把时钟添加到主循环
    [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    
    
}
-(void)beginSnow
{
    NSLog(@"%d",_count++);
    //每秒10次
    if (_count %6 == 0) {
        
        CGFloat wh = arc4random()%30+10;
        UIImageView* imageView = [[UIImageView alloc] initWithImage:_image];
        //大小随机
        imageView.frame  = CGRectMake(0, 0, wh, wh);
        
        //位置随机
        CGFloat x =  arc4random()%(int)self.view.frame.size.width;
        CGFloat y = -100;
        
        imageView.center = CGPointMake(x, y);
        [self.view addSubview:imageView];
        
        //添加下雪动画
        [UIView animateWithDuration:10 animations:^{
            imageView.center = CGPointMake(x, self.view.frame.size.height-20);
            //            imageView.alpha = 0;
        }completion:^(BOOL finished){
            [imageView removeFromSuperview];
        }];
        
        
    }
}
















@end

