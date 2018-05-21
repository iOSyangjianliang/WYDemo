//
//  TreeItem.m
//  test
//
//  Created by 海狮 on 17/5/13.
//  Copyright © 2017年 海狮. All rights reserved.
//

#import "TreeItem.h"

@implementation TreeItem
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
//        self.backgroundColor = [UIColor whiteColor];
        
        self.treeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//        self.treeBtn.backgroundColor = [UIColor yellowColor];
        self.treeBtn.adjustsImageWhenHighlighted = NO;

        [self addSubview: self.treeBtn];
    }
    return self;
}
-(void)setTreeBtnSize:(CGSize)treeBtnSize
{
    CGRect frame = self.treeBtn.frame;
    frame.size = treeBtnSize;
    self.treeBtn.frame = frame;
    self.treeBtn.layer.masksToBounds = YES;
    self.treeBtn.layer.cornerRadius = self.treeBtn.frame.size.height/2 ;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
