//
//  JLTextView.m
//  JLTextView
//
//  Created by 杨建亮 on 2018/4/26.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "JLTextView.h"

@interface JLTextView ()<UITextInput>
// UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
@property (nonatomic, weak) UITextView *placeholderView;

@property (nonatomic, assign) CGFloat lastTextHeight;
@property (nonatomic, assign) BOOL isChanggePositionHeight;

@property (nonatomic, copy) JLTextChangedHandler textHandler; // 文本改变Block
@property (nonatomic, copy) JLTextHeightChangedHandler textHeightHandler; // 自适应高度调整后Block
@end
static CGFloat const defaultTextHeight = -1.f;
@implementation JLTextView
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initDefaultData];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initDefaultData];
    }
    return self;
}
- (void)initDefaultData
{
    _rowHeight = self.font.lineHeight;
    _minNumberOfLines = 1;
    _maxNumberOfLines = NSUIntegerMax;
    _maxLength = NSUIntegerMax;
    _sizeToFitHight = NO;
    _isChanggePositionHeight = NO;
    _characterPolicy = CharacterTruncationDefault;
    _lastTextHeight = defaultTextHeight;
    _placeholderColor = [UIColor colorWithRed:194.f/255.0f green:194.f/255.0f blue:194.f/255.0f alpha:1.0];
    _firstCharacterDisableSpace = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}
#pragma mark - placeholderView
- (UITextView *)placeholderView
{
    if (!_placeholderView ) {
        UITextView *placeholderView = [[UITextView alloc] initWithFrame:self.bounds];
        _placeholderView = placeholderView;
        _placeholderView.scrollEnabled = NO;
        _placeholderView.showsHorizontalScrollIndicator = NO;
        _placeholderView.showsVerticalScrollIndicator = NO;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.textColor = _placeholderColor;
        _placeholderView.backgroundColor = [UIColor clearColor];
        _placeholderView.font = self.font;
        _placeholderView.attributedText = self.attributedText;
        _placeholderView.textContainerInset = self.textContainerInset;
        [self addSubview:placeholderView];
    }
    return _placeholderView;
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderView.textColor = placeholderColor;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderView.text = placeholder;
}
-(void)setSizeToFitHight:(BOOL)sizeToFitHight
{
    _sizeToFitHight = sizeToFitHight;
    if (_sizeToFitHight) {
        self.scrollEnabled = NO;
    }
    if (!self.text||[self.text isEqualToString:@""]) {
        [self sizeToFitMinLinesHightWhenNoText];
    }else{
        [self sizeToFitHightWhenNeed];
    }
}
-(CGFloat)minTextHeight
{
    if (self.minNumberOfLines == 0) {
        return 0.0;
    }
    CGFloat heightMIN = self.rowHeight * self.minNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom +self.contentInset.top+self.contentInset.bottom;
    return ceilf(heightMIN);
}
-(CGFloat)maxTextHeight
{
    CGFloat heightMAX = self.rowHeight * self.maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom+self.contentInset.top+self.contentInset.bottom;
    return ceilf(heightMAX);
}
-(NSUInteger)curryLines
{
    if (self.text&& ![self.text isEqualToString:@""]) {
        CGFloat  width = [self jl_getTextViewContentTextWidth];
        CGFloat textHeight =  [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:self.typingAttributes context:nil].size.height;
        CGFloat Lines = textHeight/self.rowHeight;
        return ceilf(Lines);
    }
    return 0;
}
-(void)setMaxLength:(NSUInteger)maxLength
{
    _maxLength = maxLength;
    if (self.text.length > _maxLength) {
        self.text = [self.text substringToIndex:_maxLength]; // 截取最大限制字符数.
    }
}
#pragma mark 自适应高度
-(void)sizeToFitMinLinesHightWhenNoText
{
    if (self.sizeToFitHight && self.text.length==0) {
        BOOL heightChange = self.frame.size.height!=self.minTextHeight;
        CGRect frame = self.frame;
        frame.size.height = self.minTextHeight;
        self.frame = frame;
        if (heightChange) {
            _lastTextHeight = self.minTextHeight;
            !_textHeightHandler ?: _textHeightHandler(self,self.minTextHeight);
        }
    }
}
-(void)sizeToFitHightWhenNeed
{
    if (self.sizeToFitHight) {
        CGFloat height = [self jl_getTextHeightInTextView:self.text];
        if (self.lastTextHeight != height) { // 字符串高度改变时调整frame高度
            // 当高度大于自身高度时，设置允许滚动，否则不滚动
            self.scrollEnabled = height > self.frame.size.height?YES:NO;
            _lastTextHeight = height;
            
            if (height<=self.minTextHeight)
            {
                CGRect frame = self.frame;
                frame.size.height = self.minTextHeight;
                self.frame = frame;
                !_textHeightHandler ?: _textHeightHandler(self,self.minTextHeight);
            }
            else if (height>=self.maxTextHeight)
            {
                CGRect frame = self.frame;
                frame.size.height = self.maxTextHeight;
                self.frame = frame;
                !_textHeightHandler ?: _textHeightHandler(self,self.maxTextHeight);
            }else{
                CGRect frame = self.frame;
                frame.size.height = height;
                self.frame = frame;
                !_textHeightHandler ?: _textHeightHandler(self,height);
            }
        }
    }
}
#pragma mark 限制字符输入
-(void)limitCharacterLengthWhenNeed
{
    // 禁止第一个字符输入空格或者换行
    if (self.firstCharacterDisableSpace) {
        if (self.text.length == 1) {
            if ([self.text isEqualToString:@" "] || [self.text isEqualToString:@"\n"]) {
                self.text = @"";
            }
        }
    }
    
    if (self.characterPolicy == CharacterTruncationType1)
    {
        // 只有当maxLength字段的值不为无穷大整型时才计算限制字符数.
        if (_maxLength != NSUIntegerMax && self.text.length > 0) {
            //需要判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，可以计算文字长度。否则此时计算出来的字符长度可能不正确。
            if (!self.markedTextRange && self.text.length > _maxLength) {
                self.text = [self.text substringToIndex:_maxLength]; // 截取最大限制字符数.
                [self.undoManager removeAllActions]; // 达到最大字符数后清空所有undoaction, 以免undo 操作造成crash.
            }
        }
        
    }
    else
    {
        NSString *lang = [[self.nextResponder textInputMode] primaryLanguage]; // 键盘输入模式
        // 简体中文输入，包括简体拼音，健体五笔，简体手写
        if ([lang isEqualToString:@"zh-Hans"])
        {
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position)
            {
                if (self.text.length > self.maxLength) {
                    self.text = [self.text substringToIndex:self.maxLength];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else
            {
    
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else
        {
            if (self.text.length > self.maxLength)
            {
                self.text = [ self.text substringToIndex:self.maxLength];
            }
        }
    }
   
    // 回调文本改变的Block.
    !_textHandler ?: _textHandler(self,self.text.length);
}
-(void)setMinNumberOfLines:(NSUInteger)minNumberOfLines
{
    NSUInteger lastMinNumberOfLines = self.minNumberOfLines;
    _minNumberOfLines = minNumberOfLines<_maxNumberOfLines?minNumberOfLines:_maxNumberOfLines;
    if (self.minNumberOfLines!=lastMinNumberOfLines) {
        _lastTextHeight = defaultTextHeight;
        [self sizeToFitHightWhenNeed];
    }
}
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
{
    NSUInteger lastMaxNumberOfLines = self.maxNumberOfLines;
    _maxNumberOfLines = maxNumberOfLines>_minNumberOfLines?maxNumberOfLines:_minNumberOfLines;
    if (self.maxNumberOfLines!=lastMaxNumberOfLines) {
        _lastTextHeight = defaultTextHeight;
        [self sizeToFitHightWhenNeed];
    }
}
#pragma mark - NSNotification
- (void)textDidChange:(NSNotification *)notification
{    
    //隐藏placeholderView
    self.placeholderView.hidden = self.text.length > 0?YES:NO;
    
    //限制字符输入
    [self limitCharacterLengthWhenNeed];
    
    //自适应高度
    [self sizeToFitHightWhenNeed];
}
-(void)addTextDidChangeHandler:(JLTextChangedHandler)textHandler
{
    _textHandler = [textHandler copy];
}
-(void)addTextHeightDidChangeHandler:(JLTextHeightChangedHandler)textHeightHandler
{
    _textHeightHandler = [textHeightHandler copy];
}
#pragma mark - 重写父类方法
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [_placeholderView setFont:font];
    _rowHeight = font.lineHeight;
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange:nil];
}
-(void)setTextContainerInset:(UIEdgeInsets)textContainerInset
{
    [super setTextContainerInset:textContainerInset];
    [_placeholderView setTextContainerInset:textContainerInset];
    _lastTextHeight = defaultTextHeight;
    [self sizeToFitHightWhenNeed];
}
-(void)setTypingAttributes:(NSDictionary<NSString *,id> *)typingAttributes
{
    [super setTypingAttributes:typingAttributes];
    _placeholderView.typingAttributes = typingAttributes;
    _placeholderView.text = self.placeholder;
    _placeholderView.textColor = self.placeholderColor;

    UIFont *font =  [typingAttributes objectForKey:NSFontAttributeName];
    if (font) {
        _rowHeight = font.lineHeight;
    }
    NSMutableParagraphStyle *attName =  [typingAttributes objectForKey:NSParagraphStyleAttributeName];
    if (attName) {
        if (attName.minimumLineHeight==0) {
            _rowHeight = _rowHeight +attName.lineSpacing ;
        }else{
            _rowHeight = attName.minimumLineHeight +attName.lineSpacing;
        }
        if (attName.lineSpacing!=0) {
            _isChanggePositionHeight = YES;
        }
    }
    _lastTextHeight = defaultTextHeight;
    [self sizeToFitHightWhenNeed];
}
-(void)setContentInset:(UIEdgeInsets)contentInset
{//Setup is not supported. UIEdgeInsetsZero
    [super setContentInset:UIEdgeInsetsZero];
}
-(void)layoutSubviews
{
    NSLog(@"JLTextView layoutSubviews");
    [super layoutSubviews];
    [self sizeToFitMinLinesHightWhenNoText];
    if (_placeholderView) {
        if (!CGRectEqualToRect(self.bounds, _placeholderView.frame)) {
            _placeholderView.frame = self.bounds;
        }
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - UITextInput 重写返回光标frame的方法避免光标在富文本中扩大问题。(尤其是设置行间距不居中)
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [super caretRectForPosition:position];
    if (_isChanggePositionHeight) {
        NSMutableParagraphStyle *attName =  [self.typingAttributes objectForKey:NSParagraphStyleAttributeName];
        if (attName) {
            originalRect.origin.y = originalRect.origin.y+(_rowHeight-attName.lineSpacing-self.font.lineHeight);
        }
        originalRect.size.height = self.font.lineHeight;
    }
    return originalRect;
}
//基于UITextView的typingAttributes富文本设置行高、字体
- (void)setMinimumLineHeight:(CGFloat)lineHeight font:(UIFont *)font textColor:(UIColor *)color
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.minimumLineHeight = lineHeight;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:color,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.typingAttributes = attributes;
}
//基于UITextView的typingAttributes富文本设置行高、行间距,字体
- (void)setMinimumLineHeight:(CGFloat)lineHeight lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)color
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    paragraphStyle.minimumLineHeight = lineHeight ;// 字体的行高
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:color,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.typingAttributes = attributes;
}
@end

@implementation UITextView (JLSizeCalculate)
- (CGFloat)jl_getTextViewContentTextWidth
{
    CGFloat contentWidth = CGRectGetWidth(self.frame);
    //内容需要除去显示的边框值
    CGFloat broadWith    = (  self.contentInset.left
                            + self.contentInset.right
                            + self.textContainerInset.left
                            + self.textContainerInset.right
                            + self.textContainer.lineFragmentPadding/*左边距*/
                            + self.textContainer.lineFragmentPadding/*右边距*/
                            );
    contentWidth -= broadWith;
    return contentWidth;
}
- (CGFloat)jl_getTextHeightInTextView:(NSString *)text
{
    CGFloat  width = [self jl_getTextViewContentTextWidth];
    CGSize InSize = CGSizeMake(width, MAXFLOAT);
    CGSize calculatedSize =  [text boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:self.typingAttributes context:nil].size;
    CGFloat broadHeight  = (  self.contentInset.top
                            + self.contentInset.bottom
                            + self.textContainerInset.top
                            + self.textContainerInset.bottom);//+self.textContainer.lineFragmentPadding/*top*//*+self*//*there is no bottom padding*/);
    CGFloat height = ceilf(calculatedSize.height+broadHeight);
    return height;
}

@end
