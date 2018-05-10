//
//  YouDaoTranslationApi.m
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/30.
//  Copyright © 2017年 com.Microants. All rights reserved.
// -----------有道智云翻译--Api形式------

#import "YouDaoTranslationApi.h"

@implementation YouDaoTranslationApi

+ (void)postRequestByUrlSessionWithTranslationString:(NSString *)translationString TranslationType:(TranslationType)type successBlock:(void (^)(NSString *))success failureBlock:(void (^)(NSError *))failure

{
    success(@"海狮关闭了翻译Api");
    
//    NSString* path = @"https://openapi.youdao.com/api";
//    
//    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionary];
//
//    
//    if (type == TranslationEnglish_Chinese) { //英-中
//        [postDictionary setObject:@"EN" forKey:@"from"];
//        [postDictionary setObject:@"zh-CHS" forKey:@"to"];
//    }else{ //中-英
//        [postDictionary setObject:@"zh-CHS" forKey:@"from"];
//        [postDictionary setObject:@"EN" forKey:@"to"];
//    }
//    
//    NSString * translationString_UTF8 = [translationString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString * appKey = @"348ac7503229982d";
//    NSString * salt = [NSString stringWithFormat:@"%d",arc4random() %10000];
//    NSString * keys = @"JsgsvIa8XJR0QumoGCBVXXvbTlA3SezP";
//
//    NSMutableString* sign = [NSMutableString stringWithFormat:@"%@%@%@%@",appKey,translationString,salt,keys];
//    NSString * sign_md5 = [NSString zhCreatedMD5String:sign];
//
//    [postDictionary setObject:translationString_UTF8 forKey:@"q"];
//    [postDictionary setObject:appKey forKey:@"appKey"];
//    [postDictionary setObject:salt forKey:@"salt"];
//    [postDictionary setObject:sign_md5 forKey:@"sign"];
//
//    
//    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
//    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain", nil];
//    
//    [managers POST:path parameters:postDictionary progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        
//       
//        NSString *errorCode =responseObject[@"errorCode"];
//        NSArray *array = responseObject[@"translation"];
//        
//        if ([errorCode isEqualToString:@"0"]) {
//            success(array.firstObject);
//        }else{
//            if ([errorCode isEqualToString:@"103"]) {
//                [MBProgressHUD zx_showError:@"你说的话太长啦" toView:nil];
//            }else{
//                [MBProgressHUD zx_showError:@"翻译失败" toView:nil];
//            }
//            NSError * error =nil;
//            failure(error);
//
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        [MBProgressHUD zx_showError:@"翻译失败" toView:nil];
//        failure(error);
//        
//    }];
//    
//
    
}


#pragma mark  - 根据状态栏获取当前网络状态
+(NSString *)networkingStatesFromStatebar
{
    return @"888";
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
//    
//    int type = 0;
//    for (id child in children) {
//        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
//            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
//        }
//    }
//    
//    NSString *stateString  ;
//    
//    switch (type) {
//        case 0:
//            stateString = nil;
//            break;
//            
//        case 1:
//            stateString = @"2G";
//            break;
//            
//        case 2:
//            stateString = @"3G";
//            break;
//            
//        case 3:
//            stateString = @"4G";
//            break;
//            
//        case 4:
//            stateString = @"LTE";
//            break;
//            
//        case 5:
//            stateString = @"wifi";
//            break;
//            
//        default:
//            stateString = @"notReachable";
//            break;
//    }
//    
//    return stateString;
}

@end
