//
//  YJLAppHeader.h
//  YJL
//
//  Created by 海狮 on 17/7/2.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//...

//宏定义的参数，就是一个字符串替换；所以参数一定要带括号；
#ifndef YJLAppHeader_h
#define YJLAppHeader_h

#define AppPlaceholderImage [UIImage imageNamed:@"placeimage"]


/****************************************************************/
#pragma mark - App相关
//返回Application
#ifndef APP_Application
#define APP_Application           [UIApplication sharedApplication]
#endif
//返回AppDelegate指针
#ifndef APP_Delegate
#define APP_Delegate            (AppDelegate*)[[UIApplication sharedApplication]  delegate]
#endif
//应用当前持有的最高级window
#ifndef APP_keyWindow
#define APP_keyWindow            [[UIApplication sharedApplication] keyWindow]
#endif

#define App_UserDefaults       [NSUserDefaults standardUserDefaults]
#define App_NotificationCenter [NSNotificationCenter defaultCenter]
#define App_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]//沙盒Document路径
//#define kTempPath NSTemporaryDirectory()  //temp
//#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] //沙盒Cache路径

#pragma mark - frame相关
//获取屏幕 宽度、高度
#define LCDW ([UIScreen mainScreen].bounds.size.width)
#define LCDH ([UIScreen mainScreen].bounds.size.height)
//设置iphone6尺寸比例/竖屏,UI所有设备等比例缩放
#define LCDScale_iphone6_Width(X)    ((X)*LCDW/375)
//iphone5,6 一样，plus放大，用于间距，字体大小，文本控件高度；
//宏定义的变量数字一定要加()才能准;
//CGFloat right = (LCDScale_5Equal6_To6plus(-93.f))-15.f
#define LCDScale_5Equal6_To6plus(X) (IS_IPHONE_6P ? ((X)*LCDW/375) : (X))

#pragma mark 设置view某个尺寸改变后的frame
//单独设置view的frame里的高度，其他的值保持不变
#define YJL_FRAME_X(view,x) CGRectMake(x,CGRectGetMinY(view.frame), CGRectGetWidth(view.frame),CGRectGetHeight(view.frame))
#define YJL_FRAME_Y(view,y) CGRectMake(CGRectGetMinX(view.frame),y, CGRectGetWidth(view.frame),CGRectGetHeight(view.frame))
#define YJL_FRAME_H(view,h) CGRectMake(CGRectGetMinX(view.frame),CGRectGetMinY(view.frame), CGRectGetWidth(view.frame),h)
#define YJL_FRAME_W(view,w) CGRectMake(CGRectGetMinX(view.frame),CGRectGetMinY(view.frame), w,CGRectGetHeight(view.frame))

#pragma mark - 时间
//a day/month/year has many secondes;
#define SECONDS_PER_HOUR (60*60)
#define SECONDS_PER_DAY (24*60*60)
#define SECONDS_PER_MONTH (30*24*60*60)
#define SECONDS_PER_YEAR (365*24*60*60)
//时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

#pragma mark - 角度degress转化为radian弧度
#ifndef YJL_DegreesToRadian
#define YJL_DegreesToRadian(x) (M_PI * (x) / 180.0) //角度转换弧度
#endif
#ifndef YJL_RadianToDegrees
#define YJL_RadianToDegrees(radian) (radian * 180.0) / (M_PI) //弧度转换角度
#endif


/**********************************************************************/
#pragma mark - AppBundle信息
//资源包info.plist文件的所有健值的字典；
#define APPInfoDictionary    [[NSBundle mainBundle]infoDictionary]
#define APP_AllInfoShow      CFShow(APPInfoDictionary)
//应用标识 bundelId
#define APP_bundleIdentifier [[NSBundle mainBundle]bundleIdentifier]
//包名；根据key值获取本地化资源对象的值
#define APP_BundleName       [APPInfoDictionary objectForKey:@"CFBundleName"]
//显示包别名；根据key值获取本地化资源对象的值
#define APP_DisplayName      [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APP_Name             APP_DisplayName?APP_DisplayName:APP_BundleName
//app版本号version
#define APP_Version          [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//app版本号Build
#define APP_build            [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleVersion"]//版本号
///当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//-------------------获取系统信息-------------------------
#pragma mark - 系统版本
#ifndef                         Device_Version
#define Device_Version          [[UIDevice currentDevice] systemVersion]
#endif
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue
#define Device_IOS7_OR_LATER ([Device_Version floatValue] >= 7.0)
#define Device_IOS8_OR_LATER ([Device_Version floatValue] >= 8.0)
#define Device_IOS9_OR_LATER ([Device_Version floatValue] >= 9.0)
#define Device_IOS10_OR_LATER([Device_Version floatValue] >= 10.0)

#define SYSTEM_VERSION_EQUAL_TO(v)                  (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//获取系统名
#ifndef                         Device_SystemName
#define Device_SystemName       [[UIDevice currentDevice]systemName]
#endif
//设备名称－用户自己写的名称
#ifndef                         Device_Name
#define Device_Name             [[UIDevice currentDevice]name]
#endif
//用户设备实时类型 @"iPhone", @"iPod touch"
#ifndef                         Device_model
#define Device_model            [[UIDevice currentDevice]model]
#endif

#define Device_UUID             [[[UIDevice currentDevice]identifierForVendor]UUIDString]
#define Device_localizedModel   [[UIDevice currentDevice]localizedModel]

/***************************************************/
#pragma mark - 字符串
//去除两端空格；
#ifndef ZX_StringRemoveSpace
#define ZX_StringRemoveSpace(string)     [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
#endif
/*------是否为空-----------------*/
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#define kObjectIsEmpty(_object) (_object == nil \|| [_object isKindOfClass:[NSNull class]] \|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//
#pragma mark - RGBA颜色
#define UIColorFromRGB(R,G,B)  [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#define UIColorFromRGBA(R,G,B,A)  [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#define UIRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)//随机色生成

/* 16进制的字符串颜色转RGB.把＃变为0x，如果没有则加上:
eg:#333333--ZX_RGBHexString(0X333333)*/
#define UIColorFromRGB_HexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.f]
#define UIColorFromRGBA_HexValue(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:A]

/**************************************************/
//单例
#define SINGLETON(_type_, _class_, _name_) \
+ (_type_)_name_ { \
static id o = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
o = [[_class_ alloc] init]; \
}); \
return o; \
}

/************************----打印----******************************/
//NSLog 根据url和dictionary 参数 打印httpURL请求地址
#ifndef YJL_NSLog_HTTPURL
#define YJL_NSLog_HTTPURL(hostURL,path, parameterDic) \
NSString *string = [NSString stringWithFormat:@"%@%@?", hostURL, path];\
NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameterDic];\
NSMutableArray *array = [NSMutableArray array];\
[dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) { \
NSString *para = [NSString stringWithFormat:@"%@=%@",key,[dic objectForKey:key]];\
[array addObject:para];\
}];\
NSString *p = [array componentsJoinedByString:@"&"];\
NSString *urlString = [string stringByAppendingString:p];\
NSLog(@"%@",urlString);
#endif



#pragma mark-NSLog utility 打印

////NSLog返回更多信息。
//#ifdef DEBUG
//#define NSLog(format, ...)  do{ printf("\n <%s : %d行> %s \n %s \n",\
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __FUNCTION__,[[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]); \
//} while (0)
//#else
//#define NSLog(format, ...)
//#endif

#ifndef __OPTIMIZE__
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#endif
//不能用，一旦用了，会无法打包
//#ifndef __OPTIMIZE__
//#define NSLitLog(format, ...) printf(" %s\n", [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#endif

//NSLog 根据url和dictionary 参数 打印httpURL请求地址
#ifndef ZX_NSLog_HTTPURL
#define ZX_NSLog_HTTPURL(hostURL,path, parameterDic) \
NSString *string = [NSString stringWithFormat:@"%@%@?", hostURL, path];\
NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameterDic];\
NSMutableArray *array = [NSMutableArray array];\
[dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) { \
NSString *para = [NSString stringWithFormat:@"%@=%@",key,[dic objectForKey:key]];\
[array addObject:para];\
}];\
NSString *p = [array componentsJoinedByString:@"&"];\
NSString *urlString = [string stringByAppendingString:p];\
NSLog(@"%@",urlString);
#endif

#pragma mark - 打印一个对象model的所有属性key和他的value

NS_INLINE void ZX_NSLog_ClassAllPropertyAndValue(id model)
{
    u_int count;
    Class cla = object_isClass(model)?model:[model class];
    objc_property_t *properties = class_copyPropertyList(cla, &count);
    for (int i =0; i<count; i++)
    {
        objc_property_t property = properties [i];
        const char *propertyName = property_getName(property);
        NSString *strName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        id getIvar = [model valueForKey:strName];
        NSLog(@"key=%@,value=%@",strName,getIvar);
    }
    free(properties);
    NSLog(@"%u",count);
}

#pragma mark - 打印一个class的所有方法列表(包括没有声明的私有方法)

NS_INLINE void ZX_NSLog_ClassMethodListName(id object)
{
    u_int count;
    Class cla = object_isClass(object)?object:object_getClass(object);
    Method *methods = class_copyMethodList(cla, &count);
    for (int i =0; i<count; i++)
    {
        SEL name1 = method_getName(methods[i]);
        //        IMP imp = class_getMethodImplementation(cla, name1);
        // 这2句等同于NSStringFromSelector(name1);
        const char *selName= sel_getName(name1);
        NSString *strName = [NSString stringWithCString:selName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strName);
        
    }
    free(methods);
    NSLog(@"%u",count);//包括很多私有方法;
}






//定义block使用的weak引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//弱引用/强引用   __weak __typeof(&*self)weakSelf = self;
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;









#endif /* YJLAppHeader_h */
