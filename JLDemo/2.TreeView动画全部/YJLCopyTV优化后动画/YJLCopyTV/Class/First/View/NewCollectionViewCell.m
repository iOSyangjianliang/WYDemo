//
//  NewCollectionViewCell.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import "NewCollectionViewCell.h"
#import "HotLiveModel.h"
#import "UIImageView+WebCache.h"

@interface NewCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *gpsLabel;
@property (weak, nonatomic) IBOutlet UILabel *myNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dianimV;

@property (weak, nonatomic) IBOutlet UIImageView *ewIMV;
@end
@implementation NewCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setHotModel:(HotLiveModel *)hotModel
{
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:hotModel.photo] placeholderImage:[UIImage imageNamed:@"profile_user_375x375"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _ewIMV.image = [UIImage imageNamed:@"flag_new_33x17_"];
        _dianimV.image = [UIImage imageNamed:@"location_white_8x9_"];
        _myNameLabel.text = hotModel.nickname;
        _gpsLabel.text = hotModel.position;
    }];
    
}

@end
