//
//  MSCLeftTableViewCell.m
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/25.
//  Copyright © 2017年 com.Microants. All rights reserved.
//
#define LCDW  [UIScreen mainScreen].bounds.size.width

#define  ContentWidth  LCDW-15-30.f*LCDW/375.f-20-30-9.f*2

#import "MSCLeftTableViewCell.h"
#import "MSCTranslationModel.h"

#import "Masonry.h"

@implementation MSCLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.LabelContentView.layer.masksToBounds = YES;
    self.LabelContentView.layer.cornerRadius = 3.f;
}
- (CGFloat)getCellHeightWithContentData:(id)data
{
    MSCTranslationModel* model = (MSCTranslationModel*)data;

    self.chineseLabel.text = [NSString stringWithFormat:@"%@",model.chinese];
    self.englishLabel.text = [NSString stringWithFormat:@"%@",model.english];

    CGRect rect_C = [model.chinese boundingRectWithSize:CGSizeMake(ContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5f]} context:nil];
    
    CGRect rect_E = [model.english boundingRectWithSize:CGSizeMake(ContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5f]} context:nil];
    
    CGFloat h = 7.f*2 +rect_C.size.height+rect_E.size.height+10.f +1.f;
    
    [self.LabelContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h).priority(1000);
    }];
    return 95.f-64.f+h;
    

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
