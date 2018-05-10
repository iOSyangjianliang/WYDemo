//
//  MainViewController.m
//  SBXib使用
//
//  Created by 海狮 on 17/5/28.
//  Copyright © 2017年 海狮. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property(nonatomic,strong)NSString* ssssss;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%d--%@",self.isbo,self.ssssss);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
    //     Pass the selected object to the new view controller. UIViewController *viewController= segue.destinationViewController;

    

    
    
}


@end
