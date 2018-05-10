//
//  JLLunBoCollectionViewCell.m
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/2.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#define JLLunBoCellPlaceholderImage [UIImage imageNamed:@"search_fenleiplo"]
#import "JLLunBoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation JLLunBoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


/**
 协议方法
 
 @param data 数据模型
 */
-(void)setLunBoCellData:(id)data
{

    if ([data isKindOfClass:[NSString class]]) {
        if ([data hasPrefix:@"http"]) {
            [self.lunboImageView sd_setImageWithURL:[NSURL URLWithString:data] placeholderImage:JLLunBoCellPlaceholderImage options:SDWebImageRetryFailed | SDWebImageRefreshCached ];
        } else {
            UIImage *image = [UIImage imageNamed:data];
            if (image) {
                self.lunboImageView.image = image;
            }
        }
    }else if ([data isKindOfClass:[NSURL class]]) {
        [self.lunboImageView sd_setImageWithURL:(NSURL*)data placeholderImage:JLLunBoCellPlaceholderImage options:SDWebImageRetryFailed | SDWebImageRefreshCached ];
    }else if ([data isKindOfClass:[UIImage class]]) {
        self.lunboImageView.image = data;
    }else{
        NSLog(@"推荐返回数据类型(NSString,NSURL,UIImage),你也可以在DataSource直接根据代理返回的lunboCollectionViewCell进行Cell设置eg：lunboCollectionViewCell.lunboImageView.contentMode = you like!");
    }
    
    
    
}
@end
