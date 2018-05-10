//
//  WYUIStyle.h
//  YiShangbao
//
//  Created by 何可 on 2016/12/6.
//  Copyright © 2016年 com.Microants. All rights reserved.
//

/**
 *  使用范例
 *  self.button.color = WYUISTYLE.colorMred;
 *  self.label.font = WYUISTYLE.fontWith30;
 *
 */

#define WYUISTYLE [WYUIStyle style]


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WYUIStyle : NSObject

+ (WYUIStyle *)style;
//---------------------hex色值处理----------------------
- (UIColor *) colorWithHexString:(NSString *) hexString;



@end
