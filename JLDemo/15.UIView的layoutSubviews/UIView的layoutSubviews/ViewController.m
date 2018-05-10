//
//  ViewController.m
//  UIView的layoutSubviews
//
//  Created by 杨建亮 on 2018/4/25.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "JLTestView.h"
#import "JLTestViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIWindow *jlVC;

@property(nonatomic,strong)JLTestView *testView;
@property(nonatomic,strong)JLTestView *testTwoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    
    //3.
    _testView = [[JLTestView alloc] initWithFrame:CGRectMake(0, 0, 90,0)];
    _testView.backgroundColor = [UIColor redColor];
    _testView.tag = 100;
//    [self.view addSubview:_testView];
    
//    _jlVC = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _jlVC.backgroundColor = [UIColor redColor];
//    _jlVC.tag = 999;
//    _jlVC.hidden = NO;
//    NSLog(@"%d",_jlVC.hidden);
////    [_jlVC addSubview:_testView];
//    NSLog(@"%@",[UIApplication sharedApplication].windows);
//    NSLog(@"%@",_testView.window);
    
    _testTwoView = [[JLTestView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    _testTwoView.tag = 103;
    [_testView addSubview:_testTwoView];

    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100,400, 200, 100)];
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)click:(UIButton *)sender
{
    
    _testTwoView.frame = CGRectMake(90, 30, 20, 40);
}
//UIWindow创建出来默认Hidden=YES

//注释:在控制器中创建一个window时Hidden=YES且会自动添加到[UIApplication sharedApplication].windows中，若设置NO会直接展示出来
//[init]等价于[initWithFrame:CGRectZero]

//1.初始化创建出来不添加到父视图(因为有父视图的父视图不存在情况，系统其实是根据self.window不存在判定，如注释，以下统一以父视图说明)不会触发，不管初始化frame是怎样，修改frame都不会触发layoutSubviews;
//2.addSubview会触先发父视图再触发子视图(若子视图size=00子视图不会触发)的layoutSubviews
//3.1初始化创建出来立即添加到父视图，若size=00，只会触发一次，否则两次,一次是初始化,和作为子视图被添加到父视图的一次(size=00会少掉这次);
//3.2初始化创建出来不立即添加到父视图，当某个时机添加到父视图时:若size=00不会触发，否则触发一次(应该是作为子视图被添加的这一次）
//4.修改存在父视图的视图的Frame的size会先触发父视图再触发自身但不触发自身子视图layoutSubviews，origin修改都不会触发layoutSubviews

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.
//    _testView = [[JLTestView alloc] initWithFrame:CGRectMake(0, 0, 10, 70)];
//    _testView.tag = 100;
//    [self.view addSubview:_testView];
//
//    //2.
//    JLTestView *jlview = [[JLTestView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
//    jlview.tag = 101;
////    [_testView addSubview:jlview];
    
    //3.
//    _testView.frame = CGRectMake(90,30, 0, 0);
    
    //4.
//    [_testView addSubview:_testTwoView];
    
//    5.
    [self.view addSubview:_testView];

    
//    JLTestView *three = [[JLTestView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
//    three.tag = 104;
//    [_testTwoView addSubview:three];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
