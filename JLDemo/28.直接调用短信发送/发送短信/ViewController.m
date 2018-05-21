//
//  ViewController.m
//  发送短信
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "ViewController.h"
// 引入系统框架
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    1.系统方法
//    调用系统打电话功能
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
    
//    调用发短信功能
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://10000"]];
    
//    调用mail功能
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://131472877@qq.com"]];
    
}

// 2.自定义方法
// 发送按钮事件
- (IBAction)sendMessageButton:(id)sender {
    // 判断是否可以发送文本信息
    if([MFMessageComposeViewController canSendText])
    {
        // 创建短信界面（把短信界面当作一个控制器）
        MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
        
        // 设置代理(注：代理不是controller.delegate = self)
        controller.messageComposeDelegate = self;
        
        // 短信接收者是一个数组
        controller.recipients = @[self.phoneTextField.text];
        
        controller.body = self.messageBody.text;

        
        // 取消按钮的颜色
//        controller.navigationBar.tintColor = [UIColor redColor];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"该设备不支持短信功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
//        NSLog(@"该设备不支持短信功能");
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    // 发送完短信回到原程序
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"发送成功");
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");
            break;
        case MessageComposeResultCancelled:
            NSLog(@"发送取消");
            break;
        default:
            break;
    }
}

@end
