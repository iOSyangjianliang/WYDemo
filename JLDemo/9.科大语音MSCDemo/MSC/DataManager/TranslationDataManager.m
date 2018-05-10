//
//  TranslationDataManager.m
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/30.
//  Copyright © 2017年 com.Microants. All rights reserved.
//


#import "TranslationDataManager.h"

@implementation TranslationDataManager
+(TranslationDataManager *)shareTranslationDataManager
{
    static dispatch_once_t once;
    static TranslationDataManager *mInstance;
    dispatch_once(&once, ^{
        mInstance = [[TranslationDataManager alloc] init];
    });
    return mInstance;
}
-(void)saveTranslationDataWithModel:(MSCTranslationModel *)model
{
    NSMutableArray* arrayM = [NSMutableArray arrayWithArray:[self getTranslationData] ];
    [arrayM addObject:model];
    
    [self saveTranslationDataWithArray:arrayM];
}
-(void)replaceLastModelWithModel:(MSCTranslationModel *)model
{
    NSMutableArray* arrayM = [NSMutableArray arrayWithArray:[self getTranslationData] ];
    if (arrayM.count>0) {
        [arrayM replaceObjectAtIndex:arrayM.count-1 withObject:model];
    }
    [self saveTranslationDataWithArray:arrayM];
}


-(void)saveTranslationDataWithArray:(NSArray*)array
{
//    //自定义对象不能直接存入文件，必须遵循NSCoding协议
//    NSMutableData* data = [[NSMutableData alloc]init];
//    //归档对象
//    NSKeyedArchiver* keyedarchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    //存储数据
//    [keyedarchiver encodeObject:array forKey:@"TranslationData"];
//    //封口
//    [keyedarchiver finishEncoding];
//    //写入磁盘
//    [data writeToFile:kMSCTranslationDataPath atomically:YES];
    
}
-(NSArray *)getTranslationData
{
    return nil;
//    //解档
//    NSData* dataone = [[NSData alloc] initWithContentsOfFile:kMSCTranslationDataPath];
//    //通过解档对象解档
//    NSKeyedUnarchiver* keyedunarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:dataone];
//    //取出存储对象
//    NSArray* array = [keyedunarchiver decodeObjectForKey:@"TranslationData"];
//    //封口
//    [keyedunarchiver finishDecoding];
//
//    return array;
}
@end
