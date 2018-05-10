//
//  WYUIStyle.m
//  YiShangbao
//
//  Created by 何可 on 2016/12/6.
//  Copyright © 2016年 com.Microants. All rights reserved.
//

#import "WYUIStyle.h"

@implementation WYUIStyle

+(WYUIStyle *)style{
    static dispatch_once_t once;
    static WYUIStyle *mInstance;
    dispatch_once(&once, ^{
        mInstance = [[WYUIStyle alloc] init];
    });
    return mInstance;
}





//店内共有12件商品
+(NSMutableAttributedString*)changeAllnumbersOfString:(NSString*)str WithStrColor:(UIColor*)color numberColor:(UIColor*)numColr
{
    if (!str) {
        return nil;
    }
    NSArray* arr = [str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]];
    NSInteger length = 1;
    for (NSString* str in arr) {
        if ([str isEqualToString:@""]) {
            length ++;
        }
    }
    NSString* firStr = arr.firstObject;
    NSUInteger location = firStr.length;
    NSMutableString* strM = [NSMutableString stringWithString:str];
    [strM insertString:@" " atIndex:location];
    if (strM.length>=location+length+1) {
        [strM insertString:@" " atIndex:location+length+1];
    }else{
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        NSLog(@"目前只支持'XX123XX'这种特定格式");
        return attributedString;
    }
    
    NSRange range = NSMakeRange(location+1, length);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strM];
    [attributedString addAttribute:NSForegroundColorAttributeName value:numColr range:range];
    return attributedString;
}
//
+(NSMutableAttributedString *)changeStringOfNumberStyle:(NSString *)str  numberColor:(UIColor *)numColr
{
    if (!str) {
        return nil;
    }
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    NSInteger local = 0;
    NSString* strnum = [NSString stringWithFormat:@"%d",number];
    NSRange range_num = [str rangeOfString:strnum];
    
    NSMutableString* strCopy = [NSMutableString stringWithString:str];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    while (range_num.location != NSNotFound) {
        NSRange range = NSMakeRange(range_num.location+local, range_num.length);
        [attributedString addAttribute:NSForegroundColorAttributeName value:numColr range:range];
        local = range_num.length;
        [strCopy deleteCharactersInRange:range_num];

        NSScanner *scanner = [NSScanner scannerWithString:strCopy];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        int number;
        [scanner scanInt:&number];
        
        NSString* strnum = [NSString stringWithFormat:@"%d",number];
        range_num = [strCopy rangeOfString:strnum];
    }
    return attributedString;
}
//垂直方向渐变
- (UIImage *)hk_getGradientImageWithSize:(CGSize)size
                               locations:(const CGFloat[])locations
                              components:(const CGFloat[])components
                                   count:(NSInteger)count
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建色彩空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGGradientRef colorGradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint = (CGPoint){size.width,0};
    CGPoint endPoint = (CGPoint){size.width,size.height};
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, colorGradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    
    
    
    CGGradientRelease(colorGradient);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}


-(NSArray*)HexStringExchangeToRGB:(NSString*)HexString
{
    NSString *colorString = [[HexString stringByReplacingOccurrencesOfString:@"#" withString:@""]  uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    return @[[NSString stringWithFormat:@"%f",red],[NSString stringWithFormat:@"%f",green],[NSString stringWithFormat:@"%f",blue]];

}
//---------------------hex色值处理
-(UIColor *)colorWithHexString:(NSString *)hexString{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""]  uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}
//以上-------------------hex色值处理
-(UIColor *)colorMred{      //主色红色
    return [self colorWithHexString:@"#EE4F4F"];
}
//-(UIColor *)colorBtnred{      //按钮红
//    return [self colorWithHexString:@"#EE4F4F"];
//}
-(UIColor *)colorPink{      //粉色
    return [self colorWithHexString:@"#FE6767"];
}
-(UIColor *)colorSorange{   //辅色橙色
    return [self colorWithHexString:@"#ffb700"];
}
-(UIColor *)colorSblue{     //辅色蓝色
    return [self colorWithHexString:@"#00a3ee"];
}
-(UIColor *)colorMTblack{   //文字主要黑色
    return [self colorWithHexString:@"#222222"];
}
-(UIColor *)colorLTgrey{    //文字次要灰色
    return [self colorWithHexString:@"#666666"];
}
-(UIColor *)colorSTgrey{    //文字辅助灰色
    return [self colorWithHexString:@"#999999"];
}
-(UIColor *)colorBTgrey{    //文字背景灰
    return [self colorWithHexString:@"#cccccc"];
}
-(UIColor *)colorBWhite{    //背景白
    return [self colorWithHexString:@"#ffffff"];
}
-(UIColor *)colorBGgrey{    //背景灰
    return [self colorWithHexString:@"#f3f3f3"];
}
-(UIColor *)colorLinegrey{
    return [self colorWithHexString:@"#e0e0e0"];
}
-(UIColor *)colorBGyellow{
    return [self colorWithHexString:@"#FFF9E0"];
}
//分割线颜色－新
- (UIColor *)colorLineBGgrey
{
    return [self colorWithHexString:@"#EFEFEF"];
}

//----------------------规范字体
- (UIFont *)fontNormalWithSize:(CGFloat)size //普通【可在这更换字体】
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];//常规
    //ios9 默认 PingFangSC-Regular
}
//常规字体

-(UIFont *)fontWith36{
//    if ([WYUTILITY.getMainScreen isEqualToString:@"6p"]) {
//        return [self fontNormalWithSize:(18*1.15)];
//    }else{
        return [self fontNormalWithSize:18];
//    }
}
-(UIFont *)fontWith34{
//    if ([WYUTILITY.getMainScreen isEqualToString:@"6p"]) {
//        return [self fontNormalWithSize:(17*1.15)];
//    }else{
        return [self fontNormalWithSize:17];
//    }
}
-(UIFont *)fontWith32{
//    if ([WYUTILITY.getMainScreen isEqualToString:@"6p"]) {
//        return [self fontNormalWithSize:(16*1.15)];
//    }else{
        return [self fontNormalWithSize:16];
//    }
    
}
-(UIFont *)fontWith30{
//    if ([WYUTILITY.getMainScreen isEqualToString:@"6p"]) {
//        return [self fontNormalWithSize:(15*1.15)];
//    }else{
        return [self fontNormalWithSize:15];
//    }
    
}
-(UIFont *)fontWith28{
//    if ([WYUTILITY.getMainScreen isEqualToString:@"6p"]) {
//        return [self fontNormalWithSize:(14*1.15)];
//    }else{
        return [self fontNormalWithSize:14];
//    }
    
}
-(UIFont *)fontWith24{
//    if ([WYUTILITY.getMainScreen isEqualToString:@"6p"]) {
//        return [self fontNormalWithSize:(12*1.15)];
//    }else{
        return [self fontNormalWithSize:12];
//    }
    
}
-(UIFont *)fontWith18{
//    if ([WYUTILITY.getMainScreen isEqualToString:@"6p"]) {
//        return [self fontNormalWithSize:(9*1.15)];
//    }else{
           return [self fontNormalWithSize:9];
//    }

}


//uicolor转uiimage
+ (UIImage*)imageWithColor: (UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 100.0f, 50.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *Image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return Image;
}
@end
