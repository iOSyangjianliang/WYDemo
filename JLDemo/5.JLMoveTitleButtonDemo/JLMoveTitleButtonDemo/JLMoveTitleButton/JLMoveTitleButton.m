//
//  JLMoveTitleButton.m
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/4.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#define DefualtTwoTitleLabelClearance 50.f
#define SCR_W  [UIScreen mainScreen].bounds.size.width
#define Font  [UIFont systemFontOfSize:14.f*SCR_W/375]

#import "JLMoveTitleButton.h"

@interface JLMoveTitleButton ()
@property(nonatomic,weak)NSTimer *timer;

@property(nonatomic,strong)UILabel* leftLabel;
@property(nonatomic,strong)UILabel* rightLabel;
@property(nonatomic,assign)CGRect StrRect;

@end

@implementation JLMoveTitleButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super initWithCoder:aDecoder]) {
        [self addTwoLabels];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTwoLabels];
    }
    return self;
}
-(void)addTwoLabels
{
    self.clipsToBounds = YES;
    
    _leftLabel = [[UILabel alloc] init];
    [self addSubview:_leftLabel];
    _rightLabel = [[UILabel alloc] init];
    [self addSubview:_rightLabel];
    
    _leftLabel.textColor = _rightLabel.textColor = [UIColor purpleColor];//[[WYUIStyle style] colorWithHexString:@"#FFE07F49"];
    _leftLabel.font = _rightLabel.font = Font;
}
-(void)setMoveString:(NSString *)moveString
{
    _moveString = moveString;

    [self deallocTimer];
    
    _leftLabel.text = self.moveString;
    _rightLabel.text = self.moveString;
   
    [self layoutIfNeeded];
    CGFloat selfH = self.bounds.size.height;
    CGFloat selfW = self.bounds.size.width;

    self.StrRect = [moveString boundingRectWithSize:CGSizeMake(MAXFLOAT, selfH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font} context:nil];
    
    //    NSLog(@"%@--%f",NSStringFromCGRect(self.frame),_StrRect.size.width);
    
    _leftLabel.frame = CGRectMake(0, 0, _StrRect.size.width, selfH) ;
    
    if(self.StrRect.size.width +DefualtTwoTitleLabelClearance < selfW) {
        _rightLabel.frame = CGRectMake(selfW, 0, _StrRect.size.width, selfH) ;
    }else{
        _rightLabel.frame = CGRectMake(DefualtTwoTitleLabelClearance+_StrRect.size.width, 0, _StrRect.size.width, selfH) ;
    }
    //
    [self addNstimer];
    
}
-(void)addNstimer
{
    [self deallocTimer];
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(move) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)move
{
    CGRect frame = self.leftLabel.frame;
    frame.origin.x -= 0.4;
    self.leftLabel.frame = frame;
    
    CGRect frameRight = self.rightLabel.frame;
    frameRight.origin.x -= 0.4;
    self.rightLabel.frame = frameRight;
    
    //    NSLog(@"%@--%f",NSStringFromCGRect(self.leftLabel.frame),_StrRect.size.width);
    
    [self layoutIfNeeded];
    CGFloat selfH = self.frame.size.height;
    if (self.leftLabel.frame.origin.x <= -_StrRect.size.width) {
        
        if(self.StrRect.size.width +DefualtTwoTitleLabelClearance < self.bounds.size.width) {
            self.leftLabel.frame = CGRectMake(CGRectGetMaxX(self.rightLabel.frame)+self.bounds.size.width-_StrRect.size.width, 0, _StrRect.size.width, selfH);
            
        }else{
            
            self.leftLabel.frame = CGRectMake(CGRectGetMaxX(self.rightLabel.frame)+DefualtTwoTitleLabelClearance, 0, _StrRect.size.width, selfH);
            
        }
        
    }
    if (self.rightLabel.frame.origin.x <= -_StrRect.size.width) {
        
        if(self.StrRect.size.width +DefualtTwoTitleLabelClearance < self.bounds.size.width) {
            self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame)+self.bounds.size.width-_StrRect.size.width, 0, _StrRect.size.width, selfH);
        }else{
            
            self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame)+DefualtTwoTitleLabelClearance, 0, _StrRect.size.width, selfH);
        }
    }
}
-(void)resumeJLMoveTitleButtonTimerAfterDuration:(NSTimeInterval)duration
{
    if(self.timer&&[self.timer isValid]){
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:duration]];
    }
    
}
-(void)pauseJLMoveTitleButtonTimer
{
    if(self.timer&&[self.timer isValid]){
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    
}
//在视图移除时销毁定时器
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self deallocTimer];
    }
}
-(void)deallocTimer
{
    if (self.timer && self.timer.isValid) {
        [_timer invalidate];
        _timer=nil;
    }
}
-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
