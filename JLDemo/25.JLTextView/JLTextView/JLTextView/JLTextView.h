//
//  JLTextView.h
//  JLTextView
//
//  Created by 杨建亮 on 2018/4/26.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//
/**
 JLTextView继承UITextView
 
 1.新增了占位文字、及占位文字颜色;
 2.新增最大限制字符、及字符改变回调;
 3.a新增自适应高度及高度改变回调,
   b设置最小行数、最大行数,
   c可获取最小行数、最大行数所需高度,
   d可获取当前文本的行高，文本行数;
 4.基于UITextView的typingAttributes富文本设置扩展支持:
   a最小行高、行间距,字体等
   b同时兼容3中对应的自适应高度全部功能
   c占位文字大小、位置与富文本保持一致、
   d富文本光标位置偏移进行处理，
   e提供一个快捷设置行高、行间距方法，并自动调节文字垂直居中该行
 
 */


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JLTextInsetAdjustmentBehavior) {
    JLTextInsetAdjustmentNormal     = 0,
    //在自适应高度情况下自动调整内容上下间距使当输入超过最大行数时，恰好展示n行，eg：微信聊天输入框
    JLTextInsetAdjustmentAutomatic = 1,
};
NS_ASSUME_NONNULL_BEGIN

@class JLTextView;
typedef void(^JLTextChangedHandler)(JLTextView *view,NSUInteger curryLength);
typedef void(^JLTextHeightChangedHandler)(JLTextView *view,CGFloat textHeight);

IB_DESIGNABLE
@interface JLTextView : UITextView
//占位文字
@property (nonatomic, strong, nullable) IBInspectable NSString *placeholder;
//占位文字颜色
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

//super
@property(null_resettable,nonatomic,copy) IBInspectable NSString *text;

#pragma mark 自适应高度
//自适应高度 default is NO。设置YES后Frame高度设置无效，高度将由minNumberOfLines决定
@property (nonatomic, assign) BOOL sizeToFitHight;
//default is 1, 最小行数[0 NSUIntegerMax],建议在sizeToFitHight设置之前设置
@property (nonatomic, assign) NSUInteger minNumberOfLines;
//default is NSUIntegerMax, 最大行数[minNumberOfLines NSUIntegerMax],建议在sizeToFitHight设置之前设置
@property (nonatomic, assign) NSUInteger maxNumberOfLines;
//获取自适应高度时的最小行数高度
@property (nonatomic, assign, readonly) CGFloat minTextHeight;
//获取自适应高度时的最大行数高度
@property (nonatomic, assign, readonly) CGFloat maxTextHeight;
//自适应高度时内容上下间距调整、default is JLTextInsetAdjustmentNormal
@property (nonatomic, assign) JLTextInsetAdjustmentBehavior textInsetAdjustBehavior;
//获取自适应高度时当前文本的行高(不含行间距)
@property (nonatomic, assign, readonly) CGFloat rowHeight;
//获取自适应高度时当前文本行数
@property (nonatomic, assign, readonly) NSUInteger curryLines;
// 自适应高度(sizeToFitHight=YES)文本高度改变时Block回调.
- (void)addTextHeightDidChangeHandler:(JLTextHeightChangedHandler)textHeightHandler;

/**
 字符限制: default is NSUIntegerMax 最大限制文本长度[0 NSUIntegerMax], 默认为无穷大不限制
 */
@property (nonatomic, assign) NSUInteger maxLength;
/**
 字符改变Block回调.
 */
- (void)addTextDidChangeHandler:(JLTextChangedHandler)textHandler;

/**
 提供简便快捷设置富文本方式，更丰富样式可使用父类typingAttributes去实现

 @param lineHeight 行高、该快捷方法会自动偏移使文字垂直居中
 @param lineSpacing 行间距
 @param font 字体大小、若font=nil则字体大小为self.font
 @param color 字体颜色、若color=nil则字体颜色为self.textColor
 */
- (void)setTypingAttributesWithLineHeight:(CGFloat)lineHeight lineSpacing:(CGFloat)lineSpacing textFont:(nullable UIFont *)font textColor:(nullable UIColor *)color;

@end

#pragma mark UITextView文本内容实际大小计算扩展
@interface UITextView (JLSizeCalculate)
//限制textView当前字数，可用于UITextViewDelegate的textViewDidChange中限制字符个数
- (void)jl_limitTextViewMaxLengthWhenDidChange:(NSUInteger)maxLength;

//获取textView文本内容实际排版宽度
- (CGFloat)jl_getTextViewContentTextWidth;
//获取textView对应文本计算需要的高度(兼容富文本、textContainerInset情况)
- (CGFloat)jl_getTextHeightInTextView:(NSString *)text;
- (CGFloat)jl_getTextViewHeightWithTextHeight:(CGFloat)textHeight;
- (CGFloat)jl_getTextViewHeightInTextView:(NSString *)text;
@end
NS_ASSUME_NONNULL_END
