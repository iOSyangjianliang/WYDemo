//
//  JLLunBoCollectionViewCell.h
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/2.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLLunboProtocol.h"

@interface JLLunBoCollectionViewCell : UICollectionViewCell<JLLunboProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *lunboImageView;

@end
