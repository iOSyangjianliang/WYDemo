//
//  myUiview.m
//  SBXib使用
//
//  Created by 海狮 on 17/5/28.
//  Copyright © 2017年 海狮. All rights reserved.
//

#import "myUiview.h"

@implementation myUiview
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}
//sb/xib初始化
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self  = [super initWithCoder:aDecoder]) {
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
