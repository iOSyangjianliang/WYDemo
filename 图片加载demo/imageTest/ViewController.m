//
//  ViewController.m
//  imageTest
//
//  Created by 杨建亮 on 2018/5/14.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    
//    NSString *imagePath = @"/Users/yangjianliang/Desktop/imageTest/imageTest/img/C/1.png";//😄
//    NSString *imagePath = @"1.png";//😄
//    NSString *imagePath = @"img/C/1.png"; //X

    
//    NSString *path = [[NSBundle mainBundle] resourcePath];
//    NSString *imagePath = [NSString stringWithFormat:@"%@img/C/1.png",path];  //X
    
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];//😄
    
//    //从mainbundle中获取自己创建的resources.bundle //😄
//    NSString *myBundle = [[NSBundle mainBundle] pathForResource:@"myBundle" ofType:@"bundle"];
//    //找到对应images夹下的图片
//    NSString *imagePath = [[NSBundle bundleWithPath:myBundle] pathForResource:@"1" ofType:@"png" inDirectory:@"B"];

//    NSString *imagePath = @"myBundle/B/1.png"; //X
    NSString *imagePath = @"myBundle.bundle/B/1.png"; //😄

//    NSString *imagePath = @"myAssets/D/1.png"; //X
//    NSString *imagePath = @"myAssets.xcassets/D/1.png"; //X
//    NSString *imagePath = @"myAssets.xcassets/D/1.imageset"; //X
//    NSString *imagePath = @"myAssets.xcassets/1.png"; //X

    
//    NSString *myBundle = [[NSBundle mainBundle] pathForResource:@"myAssets" ofType:@"xcassets"];
//    NSString *imagePath = [[NSBundle bundleWithPath:myBundle] pathForResource:@"1" ofType:@"png" inDirectory:@"C"]; //X
    
    
   
    
    imageV.image = [UIImage imageNamed:imagePath]; //重名的话根据文件夹添加顺序，文件夹命名顺序等
    [self.view addSubview:imageV];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
