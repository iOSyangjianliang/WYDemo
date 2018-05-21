//
//  YJLSessionManager.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import "YJLSessionManager.h"

@implementation YJLSessionManager
static YJLSessionManager *_manager;
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [YJLSessionManager manager];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = 15.f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}

@end
