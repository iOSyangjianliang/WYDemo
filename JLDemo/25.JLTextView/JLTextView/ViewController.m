//
//  ViewController.m
//  JLTextView
//
//  Created by 杨建亮 on 2018/3/7.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "JLTextView.h"

@interface ViewController ()
@property(nonatomic,strong)JLTextView *inputView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _inputView = [[JLTextView alloc]initWithFrame:CGRectMake(40, 40, 200, 55)];
    
    _inputView.layer.borderWidth = 1;
    _inputView.layer.borderColor = [UIColor grayColor].CGColor;
    _inputView.layer.masksToBounds = YES;

    
    _inputView.font = [UIFont systemFontOfSize:18];
    _inputView.placeholder = @"默认占位文字";
    
    _inputView.backgroundColor = [UIColor grayColor];
//    _inputView.placeholderColor = [UIColor redColor];
    
    //内容边距
//    _inputView.contentInset = UIEdgeInsetsMake(20, 30, 20, 30);
    _inputView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);

    _inputView.maxLength = 100;
    
    // 设置文本框最大行数
    _inputView.minNumberOfLines = 1;
    _inputView.maxNumberOfLines =  3;
    _inputView.sizeToFitHight = YES;

    [self.view addSubview:_inputView];
    
    [_inputView addTextDidChangeHandler:^(JLTextView *view, NSUInteger length) {
        NSLog(@"==%lu",(unsigned long)length);
    }];
    
    [_inputView addTextHeightDidChangeHandler:^(JLTextView *view, CGFloat textHeight) {
        NSLog(@"高度改变了==%f",textHeight);
    }];
    
    [_inputView setMinimumLineHeight:30 lineSpacing:14 font:[UIFont systemFontOfSize:24] textColor:[UIColor redColor]];
    
    //内容边距
//    NSLog(@"%@",NSStringFromUIEdgeInsets(_inputView.textContainerInset));
//    _inputView.textContainerInset = UIEdgeInsetsMake(20, 30, 40, 30);
    
    
//    _inputView.sizeToFitHight = YES;


    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%d",_inputView.scrollEnabled);

//    _inputView.minNumberOfLines = 3;

//    _inputView.textContainerInset = UIEdgeInsetsMake(20, 30, 40, 30);

    
//    _inputView.maxLength = 4;
    
        [self.view endEditing:YES];
    //    [_inputView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
