//
//  JLViewController.m
//  UIView视图添加移除Demo
//
//  Created by 杨建亮 on 2017/12/28.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "JLViewController.h"
#import "JLView.h"
#import "RRViewController.h"

@interface JLViewController ()
@property(nonatomic,strong)JLView *jlview;
@property(nonatomic,strong)UIWindow *wide;
@end

@implementation JLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(100, 20, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(1, 0, 50, 50)];
    textView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:textView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.
//    if (_jlview.superview) {
//        [_jlview removeFromSuperview];
//    }else{
//        _jlview= [[JLView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
//        _jlview.backgroundColor = [UIColor purpleColor];
//        [self.view addSubview:_jlview];
//    }

    //2.
        if (_jlview.window) {
            [_jlview removeFromSuperview];
        }else{
            _jlview= [[JLView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
            _jlview.backgroundColor = [UIColor purpleColor];
            [self.view addSubview:_jlview];
        }
}
-(void)click:(UIButton*)sender
{
    //1.
//    UIViewController *vieww = [[UIViewController alloc] init];
//    vieww.view.backgroundColor = [UIColor yellowColor];
//    [self.navigationController pushViewController:vieww animated:YES];
    
 
    //2.
//    RRViewController *view = [[RRViewController alloc] init];
//    //    [self.navigationController pushViewController:view animated:YES];
//    [self presentViewController:view animated:YES completion:^{
//
//    }];
    
    //3.
    UIView *wide = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 1000, 1000)];
    wide.backgroundColor = [UIColor purpleColor];
//    [[UIApplication sharedApplication].delegate.window addSubview:_wide];
    
    _jlview= [[JLView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    _jlview.backgroundColor = [UIColor purpleColor];
    [wide addSubview:_jlview];
    

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
