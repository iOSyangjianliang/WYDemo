//
//  JLLunBoPageControl.h
//  YiShangbao
//
//  Created by 杨建亮 on 2017/7/27.
//  Copyright © 2017年 com.Microants. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JLLunBoPageControl : UIControl

@property(nonatomic) BOOL hidesForSinglePage;

//@property(nonatomic) BOOL defersCurrentPageDisplay;
//- (void)updateCurrentPageDisplay;

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;
@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor;

@property(nullable, nonatomic,strong) UIColor *pageIndicatorImage;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorImage;

@end
NS_ASSUME_NONNULL_END

