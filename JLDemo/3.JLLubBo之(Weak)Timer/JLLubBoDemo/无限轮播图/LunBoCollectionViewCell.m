//
//  LunBoCollectionViewCell.m
//  YiShangbao
//
//  Created by 海狮 on 17/7/11.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import "LunBoCollectionViewCell.h"
#import "LunBoModel.h"
//#import "UIImageView+WebCache.h"
@implementation LunBoCollectionViewCell

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
    LunBoModel* lunbo =  (LunBoModel*)data;
//    [self.lunboImageView sd_setImageWithURL:[NSURL ossImageWithResizeType:OSSImageResizeType_w600_hX relativeToImgPath:lunbo.lunboImageUrl] placeholderImage:AppPlaceholderFenLeiImage options:SDWebImageRetryFailed | SDWebImageRefreshCached ];
    self.lunboImageView.contentMode = UIViewContentModeScaleAspectFill;
    

}
@end
