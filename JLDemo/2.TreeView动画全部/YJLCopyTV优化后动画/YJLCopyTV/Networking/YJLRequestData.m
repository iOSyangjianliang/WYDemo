//
//  YJLRequestData.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import "YJLRequestData.h"
#import "YJLSessionManager.h"
#import "GuangGaoModel.h"
#import "HotLiveModel.h"
@implementation YJLRequestData
/**
 *  广告轮播图数据
 *
 *  @param sucessBlock <#sucessBlock description#>
 *  @param errorBlcok  <#errorBlcok description#>
 */
+(void)getGuangGaoDataToComplention:(void (^)(NSArray *))sucessBlock error:(void (^)(NSError *))errorBlcok
{
    NSString* path = [NSString stringWithFormat:@"http://live.9158.com/Living/GetAD"];
    [[YJLSessionManager shareManager] GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        NSMutableArray *arrayM = [GuangGaoModel arrayOfModelsFromDictionaries:array];
        sucessBlock (arrayM);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {        
        errorBlcok(error);
    }];
}
/**
 *  获取热门直播数据列表
 *
 *  @param path        分页
 *  @param sucessBlock <#sucessBlock description#>
 *  @param errorBlcok  <#errorBlcok description#>
 */
+ (void)getHotLivDataWithPath:(NSInteger)currentPage Complention:(void (^)(NSArray *))sucessBlock error:(void (^)(NSError *))errorBlcok{
    
    NSString* path = [NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld" ,currentPage];
    [[YJLSessionManager shareManager]GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"][@"list"];
        NSArray *modelArray = [HotLiveModel arrayOfModelsFromDictionaries:array];
        sucessBlock(modelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlcok(error);
    }];
    
    
}
/**
 *  获取最新直播数据列表
 *
 *  @param path        分页
 *  @param sucessBlock <#sucessBlock description#>
 *  @param errorBlcok  <#errorBlcok description#>
 */
+(void)getNewLivDataWithPath:(NSInteger)currentPage Complention:(void (^)(NSArray *))sucessBlock error:(void (^)(NSError *))errorBlcok
{
    NSString* path = [NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld", currentPage];
    [[YJLSessionManager shareManager]GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"][@"list"];
        NSArray *modelArray = [HotLiveModel arrayOfModelsFromDictionaries:array];
        sucessBlock(modelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlcok(error);
    }];
    

}


@end
