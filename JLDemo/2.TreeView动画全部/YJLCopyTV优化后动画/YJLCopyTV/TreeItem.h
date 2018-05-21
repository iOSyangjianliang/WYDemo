//
//  TreeItem.h
//  test
//
//  Created by 海狮 on 17/5/13.
//  Copyright © 2017年 海狮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreeItem : UIView

@property (nonatomic, assign) CGPoint DefaultPoint;

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) CGPoint nearPoint;
@property (nonatomic, assign) CGPoint farPoint;

@property(nonatomic,strong)UIButton* treeBtn;
@property(nonatomic,assign)CGSize treeBtnSize;
@end
