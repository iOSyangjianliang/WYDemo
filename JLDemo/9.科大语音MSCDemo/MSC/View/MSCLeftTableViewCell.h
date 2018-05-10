//
//  MSCLeftTableViewCell.h
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/25.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCLeftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;

@property (weak, nonatomic) IBOutlet UIView *LabelContentView;

- (CGFloat)getCellHeightWithContentData:(id)data;
@end
