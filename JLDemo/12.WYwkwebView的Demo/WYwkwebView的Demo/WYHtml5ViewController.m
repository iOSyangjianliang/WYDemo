//
//  WYHtml5ViewController.m
//  WYwkwebView的Demo
//
//  Created by 杨建亮 on 2017/10/20.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "WYHtml5ViewController.h"

#import <WebKit/WebKit.h>

#import "WKWebViewJavascriptBridge.h"

#import <AlipaySDK/AlipaySDK.h>
#import "XLPhotoBrowser.h"
#import "GetIDFA.h"

#import "ZXEmptyViewController.h"
@interface WYHtml5ViewController ()<WKNavigationDelegate,XLPhotoBrowserDatasource,XLPhotoBrowserDelegate, ZXEmptyViewControllerDelegate>
@property (nonatomic,strong) WKWebView *wkWebView;
@property (nonatomic,strong) UIProgressView *progress;

@property (nonatomic,strong)UIBarButtonItem *backButtonItem;     //返回按钮
@property (nonatomic,strong)UIBarButtonItem *closeButtonItem;
@property (nonatomic,strong)UIBarButtonItem *negativeSpacerItem;
@property (nonatomic, strong)UIBarButtonItem *shareButtonItem;
@property (nonatomic, strong)UIBarButtonItem *moreButtonItem;

@property (nonatomic, strong) NSMutableDictionary *btnFun;
@property (nonatomic, strong) NSMutableDictionary *rrbtnDic;
@property (nonatomic, strong) NSMutableDictionary *lrbtnDic;

@property (nonatomic, strong)ZXEmptyViewController *emptyViewController;

@property WKWebViewJavascriptBridge *bridge;

@property(nonatomic, copy)NSMutableArray *picArray;
@end

@implementation WYHtml5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WYUISTYLE.colorF3F3F3;
    
    //1.搭建UI
    [self buildUI];
    
    //2.初始化数据
    [self setData];
    //3.建立桥接
    [self webJavascriptBridge];
    //设置userAgent
    [self userAgent];
    
    //加载request
    [self wy_loadRequest];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resume];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
}
#pragma mark - ------------------------UI--------------------------
-(void) buildUI{
    //导航栏设置
    NSArray *items = [self zhNavigationItem_leftOrRightItemReducedSpaceToMagin:-7 withItems:@[self.backButtonItem,self.negativeSpacerItem]];
    self.navigationItem.leftBarButtonItems =items;
    //分享
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    NSArray *itemsR = @[rightBarButtonItem];
    [self.navigationItem setRightBarButtonItems:itemsR animated:NO];
    
    [self addWKWebView];
    [self addProgressView];
    [self addObserver];
    [self addZXEmptyViewController];
    
}

-(void)addWKWebView
{
    //    WKUserContentController* userContentController = WKUserContentController.new;
    //    WKUserScript * cookieScript = [[WKUserScript alloc]
    //                                   initWithSource: @"document.cookie = 'TeskCookieKey1=TeskCookieValue1';document.cookie = 'TeskCookieKey2=TeskCookieValue2';"
    //                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    //    [userContentController addUserScript:cookieScript];
    //    WKWebViewConfiguration* webViewConfig = WKWebViewConfiguration.new;
    //    webViewConfig.userContentController = userContentController;
    //    _wkwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1) configuration:webViewConfig];
    //    [self.view addSubview:_wkwebView];
    
    _wkWebView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    //    _wkWebView.UIDelegate = self;
    //    _wkWebView.navigationDelegate = self;
    _wkWebView.backgroundColor = self.view.backgroundColor;
    _wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _wkWebView.multipleTouchEnabled = YES;
    _wkWebView.autoresizesSubviews = YES;
    _wkWebView.scrollView.alwaysBounceVertical = YES;
    _wkWebView.allowsBackForwardNavigationGestures = YES;/**这一步是，开启侧滑返回上一历史界面**/
    [self.view addSubview:_wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
-(void)addProgressView
{
    self.progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0,NAVIBARHEIGHT, LCDW, 3)];
    self.progress.backgroundColor = [UIColor clearColor];
    self.progress.trackTintColor = [UIColor clearColor];
    self.progress.progressTintColor = [WYUISTYLE colorWithHexString:@"4C81FF"];
    [self.view addSubview:self.progress];
}
-(void)addZXEmptyViewController
{
    ZXEmptyViewController *emptyVC =[[ZXEmptyViewController alloc] init];
    emptyVC.view.frame = self.view.frame;
    emptyVC.delegate = self;
    self.emptyViewController = emptyVC;
}
-(void)wy_loadRequest
{
    
    if ([self.webUrl rangeOfString:@"{token}"].location != NSNotFound)
    {
        NSString *token = ISLOGIN?[UserInfoUDManager getToken]:@"";
        self.webUrl = [self.webUrl stringByReplacingOccurrencesOfString:@"{token}" withString:token];
    }
    
    NSURL *url = [NSURL zhURLWithString:self.webUrl queryItemValue:[BaseHttpAPI getCurrentAppVersion] forKey:@"ttid"];
    NSLog(@"url = %@",[url absoluteString]);
    
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [self.wkWebView loadRequest:mRequest];
    
    NSArray* arrayCook = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    NSLog(@"%@",arrayCook);
    
    if (@available(iOS 11.0, *)){
        //        WKHTTPCookieStore* coo = [WKHTTPCookieStore init];
        [_wkWebView.configuration.websiteDataStore.httpCookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * _Nonnull arr) {
            NSLog(@"%@",arr);
        }];
    }
    
}
//初始化数据
- (void)setData
{
    //加载数据
    self.picArray = [[NSMutableArray alloc] init];
    _btnFun = [NSMutableDictionary new];
    _lrbtnDic = [NSMutableDictionary new];
    _rrbtnDic = [NSMutableDictionary new];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateInfo:) name:Noti_ProductManager_Edit_goBackUpdate object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginIn:) name:kNotificationUserLoginIn object:nil];
}
- (void)updateInfo:(id)notification
{
    [self.wkWebView reload];
}
- (void)loginIn:(id)notification
{
    [self.wkWebView reload];
}
#pragma mark 添加KVO观察者
- (void)addObserver
{
    //TODO:kvo监听，获得页面title和加载进度值，以及是否可以返回
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == self.wkWebView)
        {
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.wkWebView.estimatedProgress animated:YES];
            if(self.wkWebView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:1.5f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progress setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progress setProgress:0.0f animated:NO];
                                 }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //网页title
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.wkWebView)
        {
            self.navigationItem.title = self.wkWebView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma  mark - ------------webViewJavascriptBridge--------------
-(void)webJavascriptBridge{
    //WebViewJavascriptBridge
    // 开启日志
    [WKWebViewJavascriptBridge enableLogging];
    // 给哪个webview建立JS与OjbC的沟通桥梁
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:_wkWebView];
    //添加webviewDelegate
    [self.bridge setWebViewDelegate:self];
    // JS主动调用OjbC的方法
    // 这是JS会调用getUserIdFromObjC方法，这是OC注册给JS调用的
    // JS需要回调，当然JS也可以传参数过来。data就是JS所传的参数，不一定需要传
    // OC端通过responseCallback回调JS端，JS就可以得到所需要的数据
    
    //-----结束当前页面(finish)，无参
    [self.bridge registerHandler:@"finish" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self finish];
    }];
    //----调用分享(share)，参数为分享的标题以及点击的链接地址{'title':xxx,'text':xxx,'link':xxx,'image':xxx}
    [self.bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self share:data];
    }];
    //----跳转到大图浏览(previewImages)，参数为下标和图片数组
    [self.bridge registerHandler:@"previewImages" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self previewImages:data];
    }];
    //----设置标题（setTitle)
    [self.bridge registerHandler:@"setTitle" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self setNavTitle:data];
    }];
    //----设置导航右侧按钮(setRight)
    [self.bridge registerHandler:@"setRight" handler:^(id data, WVJBResponseCallback responseCallback) {
        _btnFun = data;
        [self setRight:data];
    }];
    //----js跳转native页面
    [self.bridge registerHandler:@"route" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self route:data];
        
    }];
    
    
    [self.bridge registerHandler:@"productChangeType" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_ProductManager_updatePrivacy object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_ProductManager_updatePublic object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_ProductManager_updateSoldouting object:nil];
        
        
    }];
    
    [_bridge registerHandler:@"h5NeedData" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *idfa = [GetIDFA idfaString];
        NSDictionary *dic = @{@"deviceId":idfa};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        responseCallback(jsonString);
    }];
}
#pragma mark --------------JS调用原生方法实现-----------------
//1.结束当前页面(finish)，无参
- (void)finish{
    [self.navigationController popViewControllerAnimated:YES];
}

//2.调用分享(share)，参数为分享的标题以及点击的链接地址
-(void)share:(NSDictionary *)dic{
    [WYUTILITY shareSDKWithImage:[dic objectForKey:@"image"] Title:[dic objectForKey:@"title"] Content:[dic objectForKey:@"text"] withUrl:[dic objectForKey:@"link"]];
}

//3.跳转到大图浏览(previewImages)，参数为下标和图片数组
-(void)previewImages:(NSDictionary *)dic{
    //大图浏览
    NSInteger index = [[dic objectForKey:@"position"] integerValue];
    self.picArray = [dic objectForKey:@"images"];
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithCurrentImageIndex:index imageCount:_picArray.count datasource:self];
    browser.browserStyle = XLPhotoBrowserStyleCustom;
    browser.pageControlStyle = XLPhotoBrowserPageControlStyleClassic;
}

#pragma mark  XLPhotoBrowserDatasource
- (NSURL *)photoBrowser:(XLPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    return _picArray[index];
}


//4.设置标题（setTitle)
-(void)setNavTitle:(NSDictionary *)dic{
    [self setTitle:[dic objectForKey:@"title"]];
    //    [self.mainView stringByEvaluatingJavaScriptFromString:@"(function (text) {\n          alert(text);\n        })('a')"];
}

//5.设置导航右侧按钮(setRight)
-(void)setRight:(NSDictionary *)dic{
    NSMutableArray *btnArray = [dic objectForKey:@"items"];
    if (btnArray.count == 1)
    {
        self.rrbtnDic = btnArray[0];
        NSString *icon = [self.rrbtnDic objectForKey:@"icon"];
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] init];
        if (icon.length)
        {
            rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rrbtnAction)];
            //            UIImage *backImg = [UIImage zh_imageWithColor:[UIColor redColor] andSize:[UIImage imageNamed:icon].size];
            //            [rightBarButtonItem setBackgroundImage:backImg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        }else
        {
            rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[self.rrbtnDic objectForKey:@"text"] style:UIBarButtonItemStylePlain target:self action:@selector(rrbtnAction)];
        }
        NSArray *items = @[rightBarButtonItem];
        [self.navigationItem setRightBarButtonItems:items animated:YES];
    }
    else if (btnArray.count == 2)
    {
        self.lrbtnDic = btnArray[0];
        NSString *icon = [self.lrbtnDic objectForKey:@"icon"];
        
        UIBarButtonItem *rightBarButtonItem_first = [[UIBarButtonItem alloc] init];
        if (icon.length) {
            rightBarButtonItem_first = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rlbtnAction)];
        }else{
            rightBarButtonItem_first = [[UIBarButtonItem alloc] initWithTitle:[self.lrbtnDic objectForKey:@"text"] style:UIBarButtonItemStylePlain target:self action:@selector(rlbtnAction)];
        }
        self.rrbtnDic = btnArray[1];
        NSString *icon2 = [self.rrbtnDic objectForKey:@"icon"];
        UIBarButtonItem *rightBarButtonItem_second = [[UIBarButtonItem alloc] init];
        if (icon2.length)
        {
            rightBarButtonItem_second = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:icon2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rrbtnAction)];
            
        }else{
            rightBarButtonItem_second = [[UIBarButtonItem alloc] initWithTitle:[self.rrbtnDic objectForKey:@"text"] style:UIBarButtonItemStylePlain target:self action:@selector(rrbtnAction)];
        }
        NSArray *items = @[rightBarButtonItem_second,rightBarButtonItem_first];
        [self.navigationItem setRightBarButtonItems:items animated:YES];
    }
    else
    {
        self.navigationItem.rightBarButtonItems = nil;
    }
}

#pragma mark btn添加
-(void)rrbtnAction{
    NSString *idstr = [self.rrbtnDic objectForKey:@"id"];
    NSString *successStr = [self.btnFun objectForKey:@"onSuccess"];
    NSString *str = [NSString stringWithFormat:@"(%@)(%@)",successStr,idstr];
    //    [self.mainView stringByEvaluatingJavaScriptFromString:str];
    [self.wkWebView evaluateJavaScript:str completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
    }];
    
}

-(void)rlbtnAction{
    NSString *idstr = [self.lrbtnDic objectForKey:@"id"];
    NSString *successStr = [self.btnFun objectForKey:@"onSuccess"];
    NSString *str = [NSString stringWithFormat:@"(%@)(%@)",successStr,idstr];
    //    [self.mainView stringByEvaluatingJavaScriptFromString:str];
    [self.wkWebView evaluateJavaScript:str completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
    }];
}

//6.js跳转native页面
-(void)route:(NSDictionary *)dic{
    
    
    [[WYUtility dataUtil]routerWithName:[dic objectForKey:@"url"] withSoureController:self];
}

//7.resume事件
-(void)resume{
    NSString *str = [NSString stringWithFormat:@"(function () {var event = new Event('resume');document.dispatchEvent(event);})()"];
    //    [self.mainView stringByEvaluatingJavaScriptFromString:str];
    [self.wkWebView evaluateJavaScript:str completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
    }];
    
}
//分享
-(void)shareAction{
    //默认图片地址
    NSString *imageStr = @"http://public-read-bkt-oss.oss-cn-hangzhou.aliyuncs.com/app/icon/logo_zj.png";
    [WYUTILITY shareSDKWithImage:imageStr Title:self.title Content:@"用了义采宝，生意就是好!" withUrl:self.webUrl];
}

#pragma mark   ============== URL pay 开始支付 ==============
//alipay开始支付
- (void)payWithUrlOrder:(NSString*)urlOrder
{
    if (urlOrder.length > 0) {
        __weak WYWKWebViewController* wself = self;
        [[AlipaySDK defaultService]payUrlOrder:urlOrder fromScheme:@"yicaibao" callback:^(NSDictionary* result) {
            // 处理支付结果
            NSLog(@"%@", result);
            // isProcessUrlPay 代表 支付宝已经处理该URL
            if ([result[@"isProcessUrlPay"] boolValue]) {
                // returnUrl 代表 第三方App需要跳转的成功页URL
                NSString* urlStr = result[@"returnUrl"];
                [wself loadWithUrlStr:urlStr];
            }
        }];
    }
}
//加载
- (void)loadWithUrlStr:(NSString*)urlStr
{
    if (urlStr.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                    timeoutInterval:30];
            [self.wkWebView loadRequest:webRequest];
        });
    }
}


#pragma mark - 设置user-agent
- (void)userAgent
{
    [_wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSString *oldAgent = (NSString*)obj;
        NSString *newAgent ;
        //    microants-xx-版本号
        NSRange r = [oldAgent rangeOfString:@"microants"];
        if (r.location != NSNotFound) {
            NSArray *array = [oldAgent componentsSeparatedByString:@"microants"];
            newAgent = [NSString stringWithFormat:@"%@%@",array[0],[NSString stringWithFormat:@"microants-%ld-%@",(long)[WYUserDefaultManager getUserTargetRoleType],kAppVersion]];
        }else{
            newAgent = [NSString stringWithFormat:@"%@%@",oldAgent,[NSString stringWithFormat:@"microants-%ld-%@",(long)[WYUserDefaultManager getUserTargetRoleType],kAppVersion]];
        }
        //regist the new agent
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _wkWebView.customUserAgent = newAgent;
        
        // After this point the web view will use a custom appended user agent
        //        [_wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        //            NSLog(@"%@", result);
        //        }];
    }];
    
}
-(void)userAgent_two
{
    WS(weakSelf);
    [self.wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *oldAgent = (NSString*)result;
        NSString *newAgent ;
        //    microants-xx-版本号
        NSRange r = [oldAgent rangeOfString:@"microants"];
        if (r.location != NSNotFound) {
            NSArray *array = [oldAgent componentsSeparatedByString:@"microants"];
            newAgent = [NSString stringWithFormat:@"%@%@",array[0],[NSString stringWithFormat:@"microants-%ld-%@",(long)[WYUserDefaultManager getUserTargetRoleType],kAppVersion]];
        }else{
            newAgent = [NSString stringWithFormat:@"%@%@",oldAgent,[NSString stringWithFormat:@"microants-%ld-%@",(long)[WYUserDefaultManager getUserTargetRoleType],kAppVersion]];
        }
        //regist the new agent
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        //        [self addWKWebView];
        //        [self wy_loadRequest];
        
        // After this point the web view will use a custom appended user agent
        [strongSelf.wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
            NSLog(@"%@", result);
        }];
    }];
    
}
#pragma mark - ButtonItems
- (UIBarButtonItem*)backButtonItem{
    if (!_backButtonItem) {
        UIImage* backItemImage = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage* backItemHlImage = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        //        [backButton sizeToFit];
        backButton.frame = CGRectMake(0, 0, 50, 44);
        [backButton zh_centerHorizontalImageAndTitleWithTheirSpace:10.f];
        //              [backButton setBackgroundColor:[UIColor redColor]];
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _backButtonItem;
}
- (UIBarButtonItem*)closeButtonItem{
    if (!_closeButtonItem) {
        
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"关闭" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [backButton sizeToFit];
        //        [backButton setBackgroundColor:[UIColor redColor]];
        [backButton addTarget:self action:@selector(closeButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        _closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _closeButtonItem;
}
- (void)customBackItemClicked
{
    if ([self.wkWebView canGoBack])
    {
        [self.wkWebView goBack];
    }
    else
    {
        [self closeButtonItemAction:nil];
    }
}
- (void)closeButtonItemAction:(id)sender
{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    if ([self.wkWebView isLoading])
    {
        [self.wkWebView stopLoading];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)updateNavigationItems
{
    if ([self.wkWebView canGoBack])
    {
        NSArray *items = [self zhNavigationItem_leftOrRightItemReducedSpaceToMagin:-7 withItems:@[self.backButtonItem,self.closeButtonItem,_negativeSpacerItem]];
        [self.navigationItem setLeftBarButtonItems:items animated:NO];
    }
    else
    {
        if (self.navigationItem.leftBarButtonItems.count>3)
        {
            NSArray *items = [self zhNavigationItem_leftOrRightItemReducedSpaceToMagin:-7 withItems:@[self.backButtonItem,_negativeSpacerItem]];
            [self.navigationItem setLeftBarButtonItems:items animated:NO];
        }
    }
    
}
//在iOS11，多增加一个 view
- (UIBarButtonItem *)negativeSpacerItem
{
    if (!_negativeSpacerItem)
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = 10;
        _negativeSpacerItem = negativeSpacer;
    }
    return _negativeSpacerItem;
}

#pragma mark - 请求失败／列表为空时候的代理请求
- (void)zxEmptyViewUpdateAction
{
    NSURL *url = [NSURL zhURLWithString:self.webUrl queryItemValue:[BaseHttpAPI getCurrentAppVersion] forKey:@"ttid"];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [self.wkWebView loadRequest:mRequest];
}

#pragma mark - ------------------------WKWebView Delegate-------------------------
#pragma mark WKNavigationDelegate
// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"\n1-------在发送请求之前，决定是否跳转  -->%@",navigationAction.request);
    NSURLRequest *request = navigationAction.request;
    
    //        NSLog(@"%@",request.URL.absoluteString);
    //        NSLog(@"%@",request.allHTTPHeaderFields);
    //        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:request.allHTTPHeaderFields forURL:request.URL];
    //        NSLog(@"cookies=%@",cookies);
    //
    //        NSLog(@"%@",request.HTTPMethod);
    //        NSLog(@"%@",request.HTTPBody);
    //        NSLog(@"%@",request.HTTPBodyStream);
    //        NSLog(@"%@",@(request.HTTPShouldUsePipelining));
    //        NSLog(@"%@",@(request.HTTPShouldHandleCookies));
    [webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"\n>>%@",obj);
    }];
    
    //阿里支付加载
    NSString* orderInfo = [[AlipaySDK defaultService] fetchOrderInfoFromH5PayUrl:[request.URL absoluteString]];
    if (orderInfo.length > 0) {
        [self payWithUrlOrder:orderInfo];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow); //iOS11必须保证decisionHandler只执行一次
    }
}

// 2 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"\n2-------页面开始加载时调用");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

// 3 在收到响应后，决定是否加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    /// 在收到服务器的响应头，根据response相关信息，决定是否加载。decisionHandler必须调用，来决定是否加载，参数WKNavigationActionPolicyCancel取消加载，WKNavigationActionPolicyAllow允许加载
    
    NSLog(@"\n3-------知道返回内容之后，是否允许加载，允许加载");
    
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 4 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"\n4-------当内容开始返回时调用");
    
}

// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"\n5-------页面加载完成之后调用");
    [self updateNavigationItems];
    [webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"\n>>%@",obj);
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_emptyViewController hideEmptyViewInController:self hasLocalData:YES];
}

// 6 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"\n6-------页面加载失败时调用");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_emptyViewController addEmptyViewInController:self hasLocalData:NO error:nil emptyImage:ZXEmptyRequestFaileImage emptyTitle:ZXEmptyRequestFaileTitle updateBtnHide:NO];
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"-------接收到服务器跳转请求之后调用,跳转到其他的服务器");
}

// 数据加载发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"----数据加载发生错误时调用");
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //    [self.configuration.userContentController addScriptMessageHandler:self name:@"senderModel"];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

