//
//  ViewController.m
//  JLWebPDemo
//  Created by 杨建亮 on 2017/9/28.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//  手动集成SDWebImage 1.导入frameworks 2.设置-fobjc-arc

#import "ViewController.h"

#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@end

static NSString* png = @"http://upload-images.jianshu.io/upload_images/1311290-ef5c158fb5cec9dc.png";
static NSString* webP = @"http://public-read-bkt.microants.cn/2/pro/f4b64bb18a1edd94e15c54568200f85b.webp";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView* webPImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
    webPImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:webPImageView];
    [webPImageView sd_setImageWithURL:[NSURL URLWithString:webP] ];
    
    
    

}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
