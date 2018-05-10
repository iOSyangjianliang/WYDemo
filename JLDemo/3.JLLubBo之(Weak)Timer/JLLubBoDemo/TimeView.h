//
//  TimeView.h
//  JLLubBoDemo
//
//  Created by 杨建亮 on 2017/7/28.
//  Copyright © 2017年 杨建亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView


///**多少秒后启动，eg:viewwillapper调用 */
//-(void)resumeTimerAfterDuration:(NSTimeInterval)duration;
//
///**暂停,eg:viewwilldisapper调用*/
//-(void) pauseTimer;
//
///**销毁,eg:delloc调用*/
//-(void) stopTimer;   
-(void)buildTimer;

@end
