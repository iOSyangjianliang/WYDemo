//
//  YJLRequestData.h
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJLRequestData : NSObject
+ (void)getGuangGaoDataToComplention:(void (^)(NSArray * arrary))sucessBlock error:(void (^)(NSError *error))errorBlcok;
+ (void)getHotLivDataWithPath:(NSInteger)currentPage Complention:(void (^)(NSArray *array))sucessBlock error:(void (^)(NSError *error))errorBlcok;
+ (void)getNewLivDataWithPath:(NSInteger)currentPage Complention:(void (^)(NSArray *array))sucessBlock error:(void (^)(NSError *error))errorBlcok;
@end
