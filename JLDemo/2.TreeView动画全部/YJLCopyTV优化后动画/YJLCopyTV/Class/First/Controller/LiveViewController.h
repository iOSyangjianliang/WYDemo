//
//  LiveViewController.h
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotLiveModel.h"

@interface LiveViewController : UIViewController
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)HotLiveModel*hotModel;
@property(nonatomic,strong)NSArray* arrayData;
//判断时最热/最热需要播放
//最热1 最新2 
@property(nonatomic,assign)NSInteger num;
@end
