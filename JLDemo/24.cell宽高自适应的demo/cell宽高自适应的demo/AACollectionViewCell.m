//
//  AACollectionViewCell.m
//  cell宽高自适应的demo
//
//  Created by 杨建亮 on 2018/2/8.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AACollectionViewCell.h"

@implementation AACollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.contentView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imageView];
        
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_textLabel];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    self.textLabel.frame = self.contentView.bounds;

   
    
}
//在实例从重用队列返回之前，由集合视图调用。
-(void)prepareForReuse
{
    NSLog(@"%s——1",__FUNCTION__);
    [super prepareForReuse];
    NSLog(@"%s——2",__FUNCTION__);
}
//根据LayoutAttributes来布局当前View，在view被添加到collectionView上但是还没有被复用队列返回的时候调用
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    NSLog(@"%s",__FUNCTION__);
    
    [super applyLayoutAttributes:layoutAttributes];
    
    
    NSLog(@"%s",__FUNCTION__);
    

}
-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    NSLog(@"%s",__FUNCTION__);
    
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
//    CGRect rect = [self.textLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, itemHeight) options:NSStringDrawingTruncatesLastVisibleLine|   NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
//    rect.size.width +=8;
//    rect.size.height+=8;
//    attributes.frame = rect;
    return attributes;
}
-(void)setHighlighted:(BOOL)highlighted
{
    NSLog(@"%s-%d",__FUNCTION__,highlighted);
    [super setHighlighted:highlighted];
}
-(void)setSelected:(BOOL)selected
{
    NSLog(@"%s-%d",__FUNCTION__,selected);
    [super setSelected:selected];
}
@end
