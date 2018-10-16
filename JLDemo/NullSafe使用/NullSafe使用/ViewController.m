//
//  ViewController.m
//  NullSafe使用
//
//  Created by 杨建亮 on 2018/10/11.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "JLProtocol.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
  
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    id test= [NSNull null];
//    [test isEqual:touches];
    
    id <JLProtocol> test= [NSNull null];
        
    NSString *str = [NSString stringWithFormat:@"%@",test];
    NSLog(@"%@",str);
    
    [test jl_run];
    
}
@end
