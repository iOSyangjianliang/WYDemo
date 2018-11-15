//
//  ViewController.m
//  JLTextView
//
//  Created by 杨建亮 on 2018/3/7.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "JLTextView.h"

@interface ViewController ()<UITextViewDelegate>
@property(nonatomic,strong)JLTextView *inputView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _inputView = [[JLTextView alloc]initWithFrame:CGRectMake(55, 50, 160, 55)];
    
    _inputView.layer.borderWidth = 0.5;
    _inputView.layer.cornerRadius = 4.f;
    _inputView.layer.borderColor = _inputView.placeholderColor.CGColor;
    _inputView.layer.masksToBounds = YES;

    
    _inputView.font = [UIFont systemFontOfSize:16]; //19.09375
//    _inputView.textColor = [UIColor redColor];
    _inputView.placeholder = @"默认占位文字";
    
    _inputView.backgroundColor = [UIColor whiteColor];
//    _inputView.placeholderColor = [UIColor redColor];
    
    [_inputView setTypingAttributesWithLineHeight:21 lineSpacing:0 textFont:nil textColor:nil];

    //内容边距
    NSLog(@"%@",NSStringFromUIEdgeInsets(_inputView.textContainerInset));//8、0、8、0
//    _inputView.contentInset = UIEdgeInsetsMake(20, 30, 20, 30);
//    _inputView.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8);


//    _inputView.maxLength = 100;
    
    // 设置文本框最大行数
    _inputView.minNumberOfLines = 2;
    _inputView.maxNumberOfLines =  4;
    _inputView.sizeToFitHight = YES;
    _inputView.textInsetAdjustBehavior = JLTextInsetAdjustmentAutomatic;
    
    [self.view addSubview:_inputView];
    
    [_inputView addTextDidChangeHandler:^(JLTextView *view, NSUInteger length) {
        NSLog(@"==%lu",(unsigned long)length);
    }];
    
    [_inputView addTextHeightDidChangeHandler:^(JLTextView *view, CGFloat textHeight) {
        NSLog(@"高度改变了==%f",textHeight);
        NSLog(@"%f",view.font.lineHeight);

    }];
    
    
    
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineSpacing = 0;// 字体的行间距
//    paragraphStyle.minimumLineHeight = 40 ;// 字体的行高
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:14] ,
//                                 NSForegroundColorAttributeName:[UIColor redColor],
//                                 NSParagraphStyleAttributeName:paragraphStyle,
//                                 NSBaselineOffsetAttributeName:@(15) //偏移，默认在底部
//                                 };
//    _inputView.typingAttributes = attributes;
    
    
    //内容边距
//    NSLog(@"%@",NSStringFromUIEdgeInsets(_inputView.textContainerInset));
//    _inputView.textContainerInset = UIEdgeInsetsMake(20, 30, 40, 30);
    
    
//    _inputView.sizeToFitHight = YES;


    _inputView.delegate = self;
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (textView.text.length >15) {
//        return NO;
//    }
//    return YES;
//}
- (void)textViewDidChange:(UITextView *)textView;
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%d",_inputView.scrollEnabled);

    NSLog(@"%f",_inputView.frame.size.height);

//    _inputView.minNumberOfLines = 3;

//    _inputView.textContainerInset = UIEdgeInsetsMake(20, 30, 40, 30);

    
//    _inputView.maxLength = 4;
    
        [self.view endEditing:YES];
    //    [_inputView removeFromSuperview];
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *vc=  [SB instantiateViewControllerWithIdentifier:@"AAViewControllerID"];
    [self presentViewController:vc animated:YES completion:nil];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
