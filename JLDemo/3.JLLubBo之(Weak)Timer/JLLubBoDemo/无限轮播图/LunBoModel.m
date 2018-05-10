//
//  LunBoModel.m
//  YiShangbao
//
//  Created by 海狮 on 17/7/11.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import "LunBoModel.h"

@implementation LunBoModel

-(instancetype)initWithlunboNumId:(NSNumber*)lunboNumId lunboImageUrl:(NSString*)lunboImageUrl lunboUrl:(NSString*)lunboUrl lunboTtile:(NSString*)lunboTtile lunboOther:(NSString*)lunboOther
{
    if (self = [super init]) {
        _lunboNumId = lunboNumId;
        _lunboImageUrl = lunboImageUrl;
        _lunboUrl   = lunboUrl;
        _lunboTtile = lunboTtile;
        _lunboOther = lunboOther;
    }
    return self;
}
@end
