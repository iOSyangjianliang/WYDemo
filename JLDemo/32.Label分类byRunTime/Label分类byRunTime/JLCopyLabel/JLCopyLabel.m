//
//  JLCopyLabel.m
//  YiShangbao
//
//  Created by 杨建亮 on 2018/6/4.
//  Copyright © 2018年 com.Microants. All rights reserved.
//

#import "JLCopyLabel.h"

@implementation JLCopyLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addCopyingLongPressGestureRecognizer];
    }return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addCopyingLongPressGestureRecognizer];
}
-(void)addCopyingLongPressGestureRecognizer
{
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 0.3;
    [self addGestureRecognizer:longPressGr];
    
    
    self.userInteractionEnabled = YES;
    [self becomeFirstResponder];//不加的话第一次出现又立即消失
}
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self];
        [self addMenuControllerWithPoint:point];
    }
}
#pragma mark 菜单选项
-(void)addMenuControllerWithPoint:(CGPoint)point
{
    NSLog(@"addMenuControllerWithPoint");
    [self becomeFirstResponder];

    UIMenuItem *copyMenuItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(customCopyAction:)];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    [menuController setMenuItems:[NSArray arrayWithObjects:copyMenuItem,nil]];
    [menuController setTargetRect:CGRectMake(point.x, point.y-10, 0, 0) inView:self];
    [menuController setMenuVisible:YES animated: YES];
    
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
-(BOOL)resignFirstResponder
{
    [[UIMenuController sharedMenuController] setMenuItems:nil];//重置下，UIMenuController是手机全局通用的，eg不然跳到云信那边使用粘贴板多个复制
    return [super resignFirstResponder];
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    NSLog(@"%@",NSStringFromSelector(action));
    if (action == @selector(customCopyAction:)) {
        return YES;
    }
//    if (action == @selector(copy:)) {
//        return YES;
//    }
    return [super canPerformAction:action withSender:sender];
}
- (void)customCopyAction:(id)sender
//-(void)copy:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//    if (![NSString zhIsBlankString:self.text]) {
        [pboard setString:self.text];
//    }
}
@end
