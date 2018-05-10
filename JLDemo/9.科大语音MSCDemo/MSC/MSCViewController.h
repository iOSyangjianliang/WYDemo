//
//  MSCViewController.h
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/25.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *chinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *englishBtn;

@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIImageView *showView_AnimatedIMV;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end
