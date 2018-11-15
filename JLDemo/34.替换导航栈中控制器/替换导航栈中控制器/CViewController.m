//
//  CViewController.m
//  替换导航栈中控制器
//
//  Created by 杨建亮 on 2018/9/6.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"C";

    self.view.backgroundColor = [UIColor redColor];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.navigationController.childViewControllers];
    
    NSLog(@"1.arrayM=%@",arrayM);
        
    UIViewController *VC = [[NSClassFromString(@"BBViewController") alloc] init ];
    [arrayM replaceObjectAtIndex:arrayM.count-1 withObject:VC];
    
    NSLog(@"2.arrayM=%@",self.navigationController.childViewControllers);
    
    [self.navigationController setViewControllers:arrayM];
    
    //此时打印值为 arrayM=(null)，在新的BBViewController中ViewDidLoad打印才是正常的
    NSLog(@"3.arrayM=%@",self.navigationController.childViewControllers);

}
/**
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.navigationController.childViewControllers];
   
    NSLog(@"1.arrayM=%@",arrayM);
    
    UIViewController *Bvc = arrayM[arrayM.count-2];
    if ([NSStringFromClass(Bvc.class) isEqualToString:@"BViewController" ]) {
       
        UIViewController *VC = [[NSClassFromString(@"BBViewController") alloc] init ];
        [arrayM replaceObjectAtIndex:arrayM.count-2 withObject:VC];
    }
    
    NSLog(@"2.arrayM=%@",self.navigationController.childViewControllers);
    
    [self.navigationController setViewControllers:arrayM];
    
    NSLog(@"3.arrayM=%@",self.navigationController.childViewControllers);

}
*/

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
