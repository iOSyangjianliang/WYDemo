//
//  LunBoCollectionViewCell.h
//  YiShangbao
//
//  Created by 海狮 on 17/7/11.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLLunboProtocol.h"
@interface LunBoCollectionViewCell : UICollectionViewCell<JLLunboProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *lunboImageView;

@end
