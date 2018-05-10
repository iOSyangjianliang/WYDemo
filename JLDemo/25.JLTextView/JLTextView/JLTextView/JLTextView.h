//
//  JLTextView.h
//  CMInputView
//
//  Created by 杨建亮 on 2018/4/26.
//  Copyright © 2018年 CrabMan. All rights reserved.
//
/**
 JLTextView继承UITextView
 
 1.新增了占位文字、及占位文字颜色;
 2.新增最大限制字符、及字符改变回调;
 3.新增自适应高度,最小、最大高度、及高度改变回调;
 4.基于UITextView的typingAttributes富文本设置扩展支持:最小行高、行间距,字体
   同时兼容对应的自适应高度、占位文字富文本保持一致、富文本光标位置偏移进行处理;
 
 */


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CharacterTruncationPolicy) {
    //截断字符策略
    CharacterTruncationDefault = 0,
    CharacterTruncationType1  = 1,
};
@class JLTextView;
typedef void(^JLTextChangedHandler)(JLTextView *view,NSUInteger curryLength);
typedef void(^JLTextHeightChangedHandler)(JLTextView *view,CGFloat textHeight);

@interface JLTextView : UITextView
//占位文字
@property (nonatomic, strong) NSString *placeholder;
//占位文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;

//default is NO,自适应高度，默认为minNumberOfLines高度。设置yes初始化后Frame的高度将由minNumberOfLines决定
@property (nonatomic, assign) BOOL sizeToFitHight;
//default is 1, 最小行数[0 NSUIntegerMax]
@property (nonatomic, assign) NSUInteger minNumberOfLines;
//default is NSUIntegerMax, 最大行数[minNumberOfLines NSUIntegerMax] ,
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

// 文本改变Block回调.
- (void)addTextDidChangeHandler:(JLTextChangedHandler)textHandler;
// 自适应高度(sizeToFitHight=YES)文本高度改变时Block回调.
- (void)addTextHeightDidChangeHandler:(JLTextHeightChangedHandler)textHeightHandler;


// default is NSUIntegerMax 最大限制文本长度[0 NSUIntegerMax], 默认为无穷大不限制, 如果被设为0不允许输入
@property (nonatomic, assign) NSUInteger maxLength;
// default is NO, 第一个字符限制输入空格、换行符
@property (nonatomic, assign) BOOL firstCharacterDisableSpace;
//字符将达到设置最大值截断策略
@property (nonatomic, assign) CharacterTruncationPolicy characterPolicy;

//基于UITextView的typingAttributes富文本设置行高、字体
- (void)setMinimumLineHeight:(CGFloat)lineHeight font:(UIFont *)font textColor:(UIColor *)color;
//基于UITextView的typingAttributes富文本设置行高、行间距,字体
- (void)setMinimumLineHeight:(CGFloat)lineHeight lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)color;

@end

@interface UITextView (JLSizeCalculate)
//计算textView文本内容实际宽度
- (CGFloat)jl_getTextViewContentTextWidth;
//计算textView对应文本计算需要的高度(兼容富文本、textContainerInset等情况)
- (CGFloat)jl_getTextHeightInTextView:(NSString *)text;
@end
