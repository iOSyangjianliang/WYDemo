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
    NSString *imagePath = @"1.png";//😄
//    NSString *imagePath = @"img/A/1.png"; //😄必须是create folder references才有效，勾选create Groups加载不出来(应该是系统自动拼接路径img/A部分重复导致路径匹配错误)
    
//    NSString *path = [[NSBundle mainBundle] resourcePath];
//    NSString *imagePath = [NSString stringWithFormat:@"%@img/C/1.png",path];  //X
    
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];//😄
    
//    //从mainbundle中获取自己创建的resources.bundle //😄
//    NSString *myBundle = [[NSBundle mainBundle] pathForResource:@"myBundle" ofType:@"bundle"];
//    //找到对应images夹下的图片
//    NSString *imagePath = [[NSBundle bundleWithPath:myBundle] pathForResource:@"1" ofType:@"png" inDirectory:@"B"];

//    NSString *imagePath = @"myBundle/B/1.png"; //X
//    NSString *imagePath = @"myBundle.bundle/B/1.png"; //😄

//====😄必须是create folder references才有效，勾选create Groups加载不出来(应该是系统自动拼接路径img/A部分重复导致路径匹配错误)
//    NSString *imagePath = @"myAssets/D/1"; //X
//    NSString *imagePath = @"myAssets.xcassets/D/1"; //X
//    NSString *imagePath = @"myAssets.xcassets/D/1.imageset"; //X
//    NSString *imagePath = @"myAssets.xcassets/1.png"; //X
//    NSString *imagePath = @"myAssets/1.png"; //X

    
//    NSString *myBundle = [[NSBundle mainBundle] pathForResource:@"myAssets" ofType:@"xcassets"];
//    NSString *imagePath = [[NSBundle bundleWithPath:myBundle] pathForResource:@"1" ofType:@"png" inDirectory:@"C"]; //X
    
    
   
    
    imageV.image = [UIImage imageNamed:imagePath]; //重名的话根据文件夹添加顺序，文件夹命名顺序等
    [self.view addSubview:imageV];
    
}
/**
 
 group 和 directory reference, 分别是虚结构和实结构. 黄颜色的 group 是默认的格式, 它的结构和磁盘上的文件夹毫无关系, 仅仅表示资源的逻辑组织结构, 这在管理源文件是非常方便. 同一段代码可以被很多项目使用, 也可能只使用一个目录的部分文件, 它不需要被拷贝到当前项目中, 但可以在当前项目中保持一个清晰的逻辑结构. 而且引用头文件时不需要指明复杂的层次结构, 因为这些文件在XCode看来是 flat 的, 即它们处在同一层文件夹里.
 
 但是 group 带来便利的同时也导致更加棘手的麻烦, 文件重名冲突问题; 尤其当你要使用上千个资源文件时, 这种问题已经极难避免; 而且, 资源文件一般是要拷贝到目标程序中的, 虽然它们在项目中可以有结构的组织, 但是复制到程序中时将会 flat 地输出到程序的根目录中, 这将是怎样的一个灾难! 同时, 如果你在外部向文件夹中加入了上百幅图片, 你不得不把它们再向xcode中加入一遍. 归根结底, 还要求助于我们传统的蓝色的 directory reference。
 
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
