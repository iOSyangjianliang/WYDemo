//
//  AACollectionViewCell.m
//  collectionView的cell自适应Demo
//
//  Created by 杨建亮 on 2018/5/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AACollectionViewCell.h"

@interface AACollectionViewCell ()
@property(nonatomic, assign) CGFloat textH;
@end

@implementation AACollectionViewCell

- (void)awakeFromNib {
//    NSLog(@"%s——1",__FUNCTION__);
    [super awakeFromNib];
    // Initialization code
//    NSLog(@"%s——2",__FUNCTION__);

   
//    self.jltextView.text = @"AAewCel这样只能追踪到手拖动情况，其他代码设置滚动无法控制，eg：点击状";

   
    self.jltextView.placeholder = @"请在动态高度输入框输入文字";
//    self.jltextView.placeholderColor = [UIColor grayColor];
    
//    [self.jltextView setMinimumLineHeight:21 font:[UIFont systemFontOfSize:14] textColor:[UIColor brownColor]];
//    [self.jltextView setMinimumLineHeight:25 lineSpacing:4.f font:[UIFont systemFontOfSize:20] textColor:[UIColor brownColor] ];
    
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineSpacing = 50;// 字体的行间距
//    paragraphStyle.minimumLineHeight = 30 ;// 字体的行高
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 };
//    self.jltextView.typingAttributes = attributes;
//
    
    self.jltextView.minNumberOfLines  = 2;
    self.jltextView.maxNumberOfLines  = 4;
    self.jltextView.sizeToFitHight = YES;

    self.textH = self.jltextView.minTextHeight;
    
    self.jltextView.maxLength = 200;
    
    [self.jltextView addTextHeightDidChangeHandler:^(JLTextView *view, CGFloat textHeight) {
        self.textH = textHeight;
        
        if (self.jltextView.isFirstResponder) {
            [self.flowLayout invalidateLayout];
        }
        
//        if (self.collectionView.dragging||self.collectionView.decelerating) { //这样只能追踪到手拖动情况，其他代码设置滚动无法控制，eg：点击状态栏，滚动时调用会导致崩溃
//        }else{
//            [self.flowLayout invalidateLayout];
//        }
    }];
    
    self.jltextView.text = @"AAewCel这样只能追踪到手拖动情况，其他代码设置滚动无法控制，eg：点击状态栏，滚动时调用会导致崩溃ionVie输入框输入文字099991";

    
//    self.jltextView.text = @"AACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCel这样只能追踪到手拖动情况，其他代码设置滚动无法控制，eg：点击状态栏，滚动时调用会导致崩溃ionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionVieCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionViewCellAACollectionVieiewCell输入框输入文字";
    
    NSLog(@"%f",self.jltextView.minTextHeight);
    NSLog(@"%f",self.jltextView.maxTextHeight);
    NSLog(@"%f",self.jltextView.rowHeight);


}

//在实例从重用队列返回之前，由集合视图调用。
-(void)prepareForReuse
{
//    NSLog(@"%s——1",__FUNCTION__);
    [super prepareForReuse];
//    NSLog(@"%s——2",__FUNCTION__);
}
//根据LayoutAttributes来布局当前View，在view被添加到collectionView上但是还没有被复用队列返回的时候调用
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
//    NSLog(@"%s",__FUNCTION__);
    [super applyLayoutAttributes:layoutAttributes];
//    NSLog(@"%s",__FUNCTION__);
}
-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
//    NSLog(@"%s",__FUNCTION__);
    
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
   
    CGRect frame = attributes.frame;
    frame.size.width = 250;
    CGFloat h = self.textH;
    frame.size.height = h+20+30.f;
    attributes.frame = frame;
   
    return attributes;
}
@end
