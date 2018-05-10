//
//  ViewController.m
//  TextFild提现Demo
//
//  Created by 杨建亮 on 2017/9/10.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 字符串校验，输入控制
//是否纯数字判断
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    BOOL bo= [scan scanInt:&val] && [scan isAtEnd];
    return bo;
}
//浮点形判断
- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
#pragma mark- 小数点前面8位，小数点后面最多2位，一共不能超过10位（包含小数点）
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([self isPureInt:string] || [string isEqualToString:@"."]) { //只支持单个字符输入
        NSString* textStr = textField.text;
        NSRange range_dian = [textField.text rangeOfString:@"."];
        
        if (range_dian.location == NSNotFound) { //没有“.”
            if ( [string isEqualToString:@"."] ) { //此时输入"."
                if (textStr.length<8) { //已输入小于8位
                    
                    if (textStr.length <=2) { //长度小于2位，“.”任意插入
                        return YES;
                    }else{
                        if (range.location>=textStr.length-2) {//输入“.”的位置后面只能有两位
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                }else{
                    return NO; //输入12345678+“.”
                }
                
            }else{
                if (textStr.length<8) {
                    return YES;
                }else{
                    return NO; //输入12345678+“9”
                }
            }
            
        }else{
            if ([string isEqualToString:@"."]) {
                return NO;
            }else{
                if (range.location>range_dian.location+2) { //小数点保留后两位
                    return NO;
                }else{
                    if (textStr.length >=10) {
                        textField.text = [textField.text substringToIndex:10];
                        return NO;
                    }else{
                        return YES;
                    }
                }
            }
            
        }
    }else{
        return NO;
    }
    
    
}


@end
