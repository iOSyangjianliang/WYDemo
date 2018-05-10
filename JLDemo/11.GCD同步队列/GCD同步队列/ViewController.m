//
//  ViewController.m
//  GCD同步队列
//
//  Created by 杨建亮 on 2017/10/13.
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
- (void)getNetworkingData{
    NSString *appIdKey = @"8781e4ef1c73ff20a180d3d7a42a8c04";
    NSString* urlString_1 = @"http://api.openweathermap.org/data/2.5/weather";
    NSString* urlString_2 = @"http://api.openweathermap.org/data/2.5/forecast/daily";
    NSDictionary* dictionary =@{@"lat":@"40.04991291",
                                @"lon":@"116.25626162",
                                @"APPID" : appIdKey};
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    // 将第一个网络请求任务添加到组中
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        // 开始网络请求任务
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString_1
          parameters:dictionary
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"成功请求数据1:%@",[responseObject class]);
                 // 如果请求成功，发送信号量
                 dispatch_semaphore_signal(semaphore);
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"失败请求数据");
                 // 如果请求失败，也发送信号量
                 dispatch_semaphore_signal(semaphore);
             }];
        // 在网络请求任务成功之前，信号量等待中
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    // 将第二个网络请求任务添加到组中
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        // 开始网络请求任务
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString_2
          parameters:dictionary
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"成功请求数据2:%@",[responseObject class]);
                 // 如果请求成功，发送信号量
                 dispatch_semaphore_signal(semaphore);
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"失败请求数据");
                 // 如果请求失败，也发送信号量
                 dispatch_semaphore_signal(semaphore);
             }];
        // 在网络请求任务成功之前，信号量等待中
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"完成了网络请求，不管网络请求失败了还是成功了。");
    });
}
- (void)getNetworkingData_sample
{
   
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    // 将第一个网络请求任务添加到组中
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        // 开始网络请求任务
       
                 // 如果请求成功，发送信号量
                 dispatch_semaphore_signal(semaphore);
        
                 // 如果请求失败，也发送信号量
                 dispatch_semaphore_signal(semaphore);

        // 在网络请求任务成功之前，信号量等待中
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    // 将第二个网络请求任务添加到组中
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        // 开始网络请求任务
       
                 // 如果请求成功，发送信号量
                 dispatch_semaphore_signal(semaphore);
        
                 // 如果请求失败，也发送信号量
                 dispatch_semaphore_signal(semaphore);

        // 在网络请求任务成功之前，信号量等待中
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"完成了网络请求，不管网络请求失败了还是成功了。");
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 数据请求
-(void)initData
{
    [[LoadingClass shared] showLoading:@"正在加载..."];
    
    // 创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    // 创建全局并行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        
        // 请求一
        [self tenderBaseRequest];
        
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        
        // 请求二
        [self tenderBidRequest];
        
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        
        // 请求三
        [self tenderInvalidRequest];
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, queue, ^{
        // 三个请求对应三次信号等待
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
}


@end
