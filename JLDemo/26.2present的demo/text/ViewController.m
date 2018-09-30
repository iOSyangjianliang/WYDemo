//
//  ViewController.m
//  text
//
//  Created by 杨建亮 on 2018/2/2.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "AAViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *arr = [UIApplication sharedApplication].windows;
    NSLog(@"1.%@",arr);
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AAViewController *VC = [SB instantiateViewControllerWithIdentifier:@"AAViewControllerID"];
    [VC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [self presentViewController:VC animated:NO completion:nil];
    
    
//    UINavigationController *Navi = [UIApplication sharedApplication].delegate.window.rootViewController;
//    UIViewController *visibleVC = Navi.visibleViewController;
//    [visibleVC presentViewController:VC animated:NO completion:nil];
    
    NSArray *arr2 = [UIApplication sharedApplication].windows;
    NSLog(@"2.%@",arr2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
