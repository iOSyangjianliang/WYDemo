//
//  AATableViewCell.h
//  tableView自适应动态高度
//
//  Created by 杨建亮 on 2018/5/7.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLTextView.h"

@interface AATableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet JLTextView *jltextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightLayout;

@end
