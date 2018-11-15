//
//  AAViewController.m
//  JLTextView
//
//  Created by 杨建亮 on 2018/10/25.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AAViewController.h"
#import "JLTextView/JLTextView.h"

@interface AAViewController ()
@property (weak, nonatomic) IBOutlet JLTextView *testView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height_LayoutC_testView;
@property (weak, nonatomic) IBOutlet UILabel *reminderLab;

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.testView.text = nil;
    self.testView.placeholder = @"请输入产品名称";
    
    self.testView.maxLength = 60;
    self.testView.sizeToFitHight = YES;
    [self.testView addTextDidChangeHandler:^(JLTextView * _Nonnull view, NSUInteger curryLength) {
        NSInteger reminder = 60-(NSInteger)curryLength;
        reminder<0?reminder =0 :reminder;
        self.reminderLab.text = [NSString stringWithFormat:@"还可以输入:%ld字符",reminder];
        
    }];
    [self.testView addTextHeightDidChangeHandler:^(JLTextView * _Nonnull view, CGFloat textHeight) {
        self.height_LayoutC_testView.constant = textHeight+1.f;
    }];
    
    NSString *strr = [[NSUserDefaults standardUserDefaults] objectForKey: @"666"];

    NSString *str = [self zhFilterInputTextWithWittespaceAndLine:strr];


    self.testView.text = str;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.testView resignFirstResponder];
    
    NSString *str = [self zhFilterInputTextWithWittespaceAndLine:self.testView.text];

    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"666"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSString *)zhFilterInputTextWithWittespaceAndLine:(NSString *)str
{
    NSCharacterSet *whitespaceLine = [NSCharacterSet  whitespaceAndNewlineCharacterSet];
    NSRange spaceRange = [str rangeOfCharacterFromSet:whitespaceLine];
    if (spaceRange.location != NSNotFound)
    {
        str = [str stringByTrimmingCharactersInSet:whitespaceLine];
    }
    
    return str;
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
