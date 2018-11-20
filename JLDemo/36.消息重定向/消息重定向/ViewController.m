//
//  ViewController.m
//  消息重定向
//
//  Created by 杨建亮 on 2018/11/2.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "JLTestObject.h"

@interface ViewController ()

@property(nonatomic,strong)JLTestObject *objc ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
    _objc = [[JLTestObject alloc] init];
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_objc performSelector:@selector(test) withObject:nil];

}


@end
