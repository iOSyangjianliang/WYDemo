//
//  RootViewController.m
//  JLLubBoDemo
//
//  Created by 杨建亮 on 2017/7/28.
//  Copyright © 2017年 杨建亮. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSegueWithIdentifier:@"RootViewControllerSUGUE" sender:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    UIViewController *viewController= segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"RootViewControllerSUGUE"])
    {        
//        [viewController setValue:@"hello" forKey:@"ssssss"];
        
    }


}


@end
