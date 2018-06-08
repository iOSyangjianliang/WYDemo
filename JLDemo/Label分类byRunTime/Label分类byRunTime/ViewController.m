//
//  ViewController.m
//  Label分类byRunTime
//
//  Created by 杨建亮 on 2018/6/4.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+TextCopy.h"
#import "JLLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JLLabel *label = [[JLLabel alloc] initWithFrame:CGRectMake(20, 40, 100, 50)];
    label.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:label];
    label.userInteractionEnabled = YES;
    
    NSLog(@"%d",label.isNeedCopy);
    label.isNeedCopy = YES;
//    NSLog(@"%d",label.isNeedCopy);
//    [label performSelector:@selector(setIsNeedCopy:) withObject:@(NO) ];
//    NSLog(@"%d",label.isNeedCopy);
    
    label.text = @"666";
//    [label setText:@"666"];

//    [label jl_TextNamed:@"666"];
//    [label performSelector:@selector(jl_TextNamed:) withObject:@"666" ];
    

    label.textDidCopyHandler = ^(UILabel *label) {
        NSLog(@"%@",label.text);
    } ;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    JLLabel *label = [[JLLabel alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    label.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:label];
    label.text = @"dasdafdafadf";
    
    NSLog(@"%d",label.isNeedCopy);

    NSLog(@"%@",label.longCopyPressGesture);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
