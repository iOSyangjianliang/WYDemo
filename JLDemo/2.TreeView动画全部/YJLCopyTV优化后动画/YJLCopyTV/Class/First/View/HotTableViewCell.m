//
//  HotTableViewCell.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import "HotTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RGBColor.h"

@interface HotTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *smallimV;
@property (weak, nonatomic) IBOutlet UILabel *gpsLabel;
@property (weak, nonatomic) IBOutlet UILabel *myNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starimV;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *BigimV;

@end
@implementation HotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setHotModel:(HotLiveModel *)hotModel
{
    [_smallimV sd_setImageWithURL:[NSURL URLWithString:hotModel.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _smallimV.layer.masksToBounds = YES;
        _smallimV.layer.cornerRadius = 20;
        _smallimV.layer.borderWidth = 1;
        _smallimV.layer.borderColor = [RGBColor colorWithHexString:@"#EE3A8C"].CGColor;
    }] ;
    _gpsLabel.text = hotModel.gps;
    
    CGRect Re = [hotModel.myname boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    if (Re.size.width>=80) {
        Re.size.width = 80;
    }
    CGRect frame = _myNameLabel.frame;
    frame.size.width = Re.size.width;
    _myNameLabel.frame = frame;
    _myNameLabel.text = hotModel.myname;
//    NSLog(@"%f--%f",Re.size.width,_myNameLabel.frame.size.width);
    
    NSArray* array = @[@"",@"girl_star1_40x19",@"girl_star2_40x19",@"girl_star3_40x19",@"girl_star4_40x19",@"girl_star5_40x19"];
    int i = hotModel.starlevel.intValue;
    if (i==0) {
        _starimV.hidden = YES;
    }else{
        _starimV.image = [UIImage imageNamed:array[i]];

    }
    _peopleLabel.text = [NSString stringWithFormat:@"%@",hotModel.allnum];
    _peopleLabel.textColor = [RGBColor colorWithHexString:@"#EE3A8C"];
    [_BigimV sd_setImageWithURL:[NSURL URLWithString:hotModel.bigpic]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
