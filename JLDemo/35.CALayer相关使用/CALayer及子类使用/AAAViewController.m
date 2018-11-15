//
//  AAAViewController.m
//  CALayer及子类使用
//
//  Created by 杨建亮 on 2018/10/19.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AAAViewController.h"

@interface AAAViewController ()

@end

@implementation AAAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(300, 200, 10, 10)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    UIView *AnimView = [[UIView alloc] initWithFrame:CGRectMake(100, 210, 200, 200)];
    AnimView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:AnimView];
    
    AnimView.layer.anchorPoint = CGPointMake(1, 0);
    AnimView.layer.frame = CGRectMake(100, 210, 200, 200);//!!!
   
    [UIView animateWithDuration:3.25 animations:^{
        
        AnimView.layer.transform = CATransform3DMakeScale(0.2, 0.2, 1);
        
//        AnimView.layer.transform = CATransform3DMakeTranslation(200, 0, 0);
//        AnimView.layer.transform = CATransform3DMakeRotation(M_E, 1, 1, 1);
        
//        CGRect frame = AnimView.layer.frame;
//        frame.origin.x =  AnimView.layer.position.x -  AnimView.layer.anchorPoint.x *  AnimView.layer.bounds.size.width;
//        frame.origin.y = AnimView.layer.position.y - AnimView.layer.anchorPoint.y * AnimView.layer.bounds.size.height;
//        frame.size = CGSizeMake(20, 20);
//
//        AnimView.layer.frame = frame;
    }];
    
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
