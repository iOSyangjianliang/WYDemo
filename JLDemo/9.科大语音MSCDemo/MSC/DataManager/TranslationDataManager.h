//
//  TranslationDataManager.h
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/30.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCTranslationModel.h"
@interface TranslationDataManager : NSObject
+ (TranslationDataManager *)shareTranslationDataManager;

-(void)saveTranslationDataWithModel:(MSCTranslationModel*)model;
-(void)replaceLastModelWithModel:(MSCTranslationModel*)model;

-(NSArray*)getTranslationData;

@end
