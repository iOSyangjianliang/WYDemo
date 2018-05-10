//
//  TimeView.m
//  JLLubBoDemo
//
//  Created by 杨建亮 on 2017/7/28.
//  Copyright © 2017年 杨建亮. All rights reserved.
//

#import "TimeView.h"

@interface TimeView ()
@property(nonatomic,weak)NSTimer *timer;  //weak内存释放测试


@property(nonatomic,assign)NSInteger countn;

@end

@implementation TimeView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self buildTimer];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor blackColor];

        [self buildTimer];
    }
    return self;
}

-(void)buildTimer
{
//    [self stopTimer];
    _countn = 0;
    NSTimer* tim = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(AutoPage) userInfo:nil repeats:YES];
    self.timer = tim;

    [[NSRunLoop currentRunLoop] addTimer:tim forMode:NSRunLoopCommonModes];
    
}

-(void)AutoPage{
    _countn++;
    
    NSLog(@"%ld",_countn);
}


//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)dealloc
{
//    [_timer invalidate];
//    _timer = nil;

    
    NSLog(@"V%s",__FUNCTION__);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)pauseTimer{
    
    if (![self.timer isValid]) {
        return ;
    }
    
    if(_timer){
        //暂停定时器
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    
}
-(void)resumeTimerAfterDuration:(NSTimeInterval)duration
{
    
    if (![self.timer isValid]) {
        return ;
    }
    
    if(_timer){
        //开启定时器
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:duration]];
        
    }
    
}
-(void)stopTimer
{

    if (_timer.isValid) {
        [_timer invalidate];
        _timer=nil;
    }
    
}

@end
