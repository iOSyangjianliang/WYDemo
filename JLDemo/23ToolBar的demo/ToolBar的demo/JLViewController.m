//
//  JLViewController.m
//  ToolBar的demo
//
//  Created by 杨建亮 on 2018/1/12.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "JLViewController.h"

@interface JLViewController ()

@end

@implementation JLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"ToolBar";
    
    [self buildUI];
}
-(void)buildUI
{
    //ToolBar显示出来
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.frame =CGRectMake(0, 0, 320, 160);  //设置无效
    self.navigationController.toolbar.translucent = NO;
//    self.navigationController.toolbar.tintColor = [UIColor purpleColor];
//    self.navigationController.toolbar.barTintColor = [UIColor whiteColor];
    
    NSArray *array1 = @[@"tab_kaidan1",@"tab_shuju1",@"tab_shuju1"];
    NSArray *array2 = @[@"tab_kaidan2",@"tab_shuju2",@"tab_shuju2"];

//    只支持 UIControlStateNormal, UIControlStateHighlighted, UIControlStateDisabled and UIControlStateFocused.
//    UIBarButtonItem* itemOne = [[UIBarButtonItem alloc] init];
    UIBarButtonItem* itemOne = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"tab_kaidan1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
//    [itemOne setBackgroundImage:[self getOriginalImageWithPath:array2[0]] forState:UIControlStateNormal style:UIBarButtonItemStylePlain barMetrics:UIBarMetricsDefault];
    [itemOne setBackgroundImage:[self getOriginalImageWithPath:array1[0]] forState:UIControlStateSelected style:UIBarButtonItemStylePlain barMetrics:UIBarMetricsDefault];

//    UIBarButtonItem* itemTwo = [[UIBarButtonItem alloc] init];
    UIBarButtonItem* itemTwo = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"tab_shuju2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(click:)];
//    [itemTwo setBackgroundImage:[self getOriginalImageWithPath:array2[1]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [itemTwo setBackgroundImage:[self getOriginalImageWithPath:array1[1]] forState:UIControlStateFocused barMetrics:UIBarMetricsDefault];

//    UIBarButtonItem* itemThree = [[UIBarButtonItem alloc] init];
    UIBarButtonItem* itemThree = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"tab_kehu2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(click:)];
//    [itemThree setBackgroundImage:[self getOriginalImageWithPath:array2[2]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [itemThree setBackgroundImage:[self getOriginalImageWithPath:array1[2]] forState:UIControlStateFocused barMetrics:UIBarMetricsDefault];
   
    
    //另一种初始化。无效
//    UIBarButtonItem*itemOne = [[UIBarButtonItem alloc] initWithImage:[self getOriginalImageWithPath:array2[0]] landscapeImagePhone:[self getOriginalImageWithPath:array1[0]] style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
//    UIBarButtonItem* itemTwo = [[UIBarButtonItem alloc] initWithImage:[self getOriginalImageWithPath:array2[1]] landscapeImagePhone:[self getOriginalImageWithPath:array1[1]] style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
//    UIBarButtonItem* itemThree = [[UIBarButtonItem alloc] initWithImage:[self getOriginalImageWithPath:array2[2]] landscapeImagePhone:[self getOriginalImageWithPath:array1[2]] style:UIBarButtonItemStylePlain target:self action:@selector(click:)];


//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
////        btn.backgroundColor = [UIColor redColor];
//        UIBarButtonItem* itemThree = [[UIBarButtonItem alloc] initWithCustomView:btn];
//        [itemThree setBackgroundImage:[self getOriginalImageWithPath:array2[2]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault]; //无效
//        [itemThree setBackgroundImage:[self getOriginalImageWithPath:array1[2]] forState:UIControlStateFocused barMetrics:UIBarMetricsDefault];
    
    
    //弹簧间隙
    UIBarButtonItem* itemLeft_Ritht = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    itemLeft_Ritht.width = -40;
    UIBarButtonItem* itemFix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, 320, 50)];
    toolBar.items = @[itemLeft_Ritht,itemOne,itemFix,itemTwo,itemLeft_Ritht];
    [self.view addSubview:toolBar];
    
    
    self.toolbarItems = @[itemLeft_Ritht,itemOne,itemFix,itemTwo,itemFix,itemThree,itemLeft_Ritht];

    

}
-(void)click:(UIBarButtonItem*)sender
{
}
-(UIImage*)getOriginalImageWithPath:(NSString*)name
{
   return  [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
