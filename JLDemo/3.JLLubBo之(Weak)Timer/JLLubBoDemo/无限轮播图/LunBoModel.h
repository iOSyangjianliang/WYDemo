//
//  LunBoModel.h
//  YiShangbao
//
//  Created by 海狮 on 17/7/11.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LunBoModel : NSObject
-(instancetype)initWithlunboNumId:(NSNumber*)lunboNumId lunboImageUrl:(NSString*)lunboImageUrl lunboUrl:(NSString*)lunboUrl lunboTtile:(NSString*)lunboTtile lunboOther:(NSString*)lunboOther
;
@property(nonatomic,strong)NSNumber* lunboNumId;
@property(nonatomic,strong)NSString* lunboImageUrl;
@property(nonatomic,strong)NSString* lunboUrl;
@property(nonatomic,strong)NSString* lunboTtile;
@property(nonatomic,strong)NSString* lunboOther;

@end
