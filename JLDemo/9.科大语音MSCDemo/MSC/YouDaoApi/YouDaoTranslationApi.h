//
//  YouDaoTranslationApi.h
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/30.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger,TranslationType) {
    TranslationChinese_English = 0 ,
    TranslationEnglish_Chinese = 1
};
@interface YouDaoTranslationApi : NSObject
//有道Api翻译
+ (void)postRequestByUrlSessionWithTranslationString:(NSString *)translationString TranslationType:(TranslationType)type successBlock:(void(^)(NSString *translationString))success failureBlock:(void(^)(NSError *error))failure;

// 根据状态栏获取当前网络状态
+(NSString *)networkingStatesFromStatebar;

@end
