//
//  ViewController.h
//  发送短信
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 HL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//接收的手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
// 发送信息内容
@property (weak, nonatomic) IBOutlet UITextField *messageBody;


@end

