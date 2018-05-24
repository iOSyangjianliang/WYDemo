//
//  ViewController.m
//  获取通讯录
//
//  Created by 杨建亮 on 2018/5/23.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "AddressBookManager.h"
#import "AddressBookController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [[AddressBookManager shareInstance] requestAuthorizationForAddressBook:^(AddressBookMainModel *model) {
//        NSLog(@"%@",model);
//        NSArray *arr = model.addressBook;
//    } failure:^(NSString *message) {
//        NSLog(@"%@",message);
//    }];
//    
    AddressBookController *vc = [[AddressBookController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
