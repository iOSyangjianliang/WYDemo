//
//  GuanZhuViewController.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.bounds.size.height
#import "GuanZhuViewController.h"
#import "RGBColor.h"

@interface GuanZhuViewController ()

@end

@implementation GuanZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
}

-(void)buildUI
{
    UIImageView* imV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_W*250/414.000000, SCR_W*247/414.000000)];
    imV.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    imV.image = [UIImage imageNamed:@"no_follow_250x247"];
    [self.view addSubview:imV];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(imV.frame), CGRectGetMaxY(imV.frame), SCR_W*0.6, 40)];
    label.text = @"您关注的主播还未开播";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCR_W*0.7, 40)];
    btn.center = CGPointMake(imV.center.x, imV.center.y+180);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius  = 20;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [RGBColor colorWithHexString:@"#EE3A8C"].CGColor;
    [btn setTitle:@"取看看当前热门直播" forState:UIControlStateNormal];
    [btn setTitleColor:[RGBColor colorWithHexString:@"#EE3A8C"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}
-(void)clickBtn
{
    
}
@end
