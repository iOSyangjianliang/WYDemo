//
//  WKWebViewController.m
//  WKWebView的Demo
//
//  Created by 杨建亮 on 2017/10/16.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//
#define LCDW [UIScreen mainScreen].bounds.size.width
#define LCDH [UIScreen mainScreen].bounds.size.height
#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *wkWebview;
@property (nonatomic,strong) UIProgressView *progress;
@end

@implementation WKWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"WKWebView";
    [self LoadRequest];
    [self addObserver];
    
    
}
#pragma mark - --------------------------UI-----------------------------
- (WKWebView *)wkWebview
{
    if (_wkWebview == nil)
    {
        _wkWebview = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _wkWebview.UIDelegate = self;
        _wkWebview.navigationDelegate = self;
        _wkWebview.backgroundColor = [UIColor clearColor];
        _wkWebview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _wkWebview.multipleTouchEnabled = YES;
        _wkWebview.autoresizesSubviews = YES;
        _wkWebview.scrollView.alwaysBounceVertical = YES;
        _wkWebview.allowsBackForwardNavigationGestures = YES;/**这一步是，开启侧滑返回上一历史界面**/
        [self.view addSubview:_wkWebview];
    }
    return _wkWebview;
}
#pragma mark 加载进度条
- (UIProgressView *)progress
{
    if (_progress == nil)
    {
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, LCDW, 4)];
        _progress.tintColor = [UIColor blueColor];
        _progress.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_progress];
    }
    return _progress;
}
#pragma mark 加载网页
- (void)LoadRequest
{
    [self.wkWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com"]]];
}
#pragma mark 添加KVO观察者
- (void)addObserver
{
    //TODO:kvo监听，获得页面title和加载进度值，以及是否可以返回
    [self.wkWebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
//    [self.wkWebview addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
//    [self.wkWebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
#pragma mark 移除观察者
- (void)dealloc
{
    [self.wkWebview removeObserver:self forKeyPath:@"estimatedProgress"];
//    [self.wkWebview removeObserver:self forKeyPath:@"canGoBack"];
//    [self.wkWebview removeObserver:self forKeyPath:@"title"];
}
#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == self.wkWebview)
        {
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.wkWebview.estimatedProgress animated:YES];
            if(self.wkWebview.estimatedProgress >= 1.0f)
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
        if (object == self.wkWebview)
        {
            self.navigationItem.title = self.wkWebview.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //是否可以返回
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}




#pragma mark - WKWebView Delegate
#pragma mark -----------------------WKNavigationDelegate------------------------
// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"1-------在发送请求之前，决定是否跳转  -->%@",navigationAction.request);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 2 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"2-------页面开始加载时调用");
}

// 3 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    /// 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
    
    NSLog(@"3-------在收到响应后，决定是否跳转");
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 4  开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"4-------当内容开始返回时调用");
}

// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"5-------页面加载完成之后调用");
}

// 6 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"6-------页面加载失败时调用");
}

// 接收到服务器跳转请求之后调用(主机地址被重定向时调用)
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"-------接收到服务器跳转请求之后调用");
}

// 数据加载发生错误时调用(//跳转失败时调用)
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"----数据加载发生错误时调用");
}

// 需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    //用户身份信息
    
    NSLog(@"----需要响应身份验证时调用 同样在block中需要传入用户身份凭证");
    
    NSURLCredential *newCred = [NSURLCredential credentialWithUser:@""
                                                          password:@""
                                                       persistence:NSURLCredentialPersistenceNone];
    // 为 challenge 的发送方提供 credential
    [[challenge sender] useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

// 进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"----------进程被终止时调用");
}




#pragma mark - ---------------------- UIDelegate------------------------
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler {
    
    NSLog(@"-------web界面中有弹出警告框时调用");
}

// 创建新的webView时调用的方法
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    NSLog(@"-----创建新的webView时调用的方法");
    return webView;
}

// 关闭webView时调用的方法
- (void)webViewDidClose:(WKWebView *)webView {
    
    NSLog(@"----关闭webView时调用的方法");
}

// 下面这些方法是交互JavaScript的方法
// JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    NSLog(@"%@",message);
    completionHandler(YES);
}
// JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    NSLog(@"%@",prompt);
    completionHandler(@"123");
}

// 默认预览元素调用
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
    
    NSLog(@"-----默认预览元素调用");
    return YES;
}

// 返回一个视图控制器将导致视图控制器被显示为一个预览。返回nil将WebKit的默认预览的行为。
- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions {
    
    NSLog(@"----返回一个视图控制器将导致视图控制器被显示为一个预览。返回nil将WebKit的默认预览的行为。");
    return self;
}

// 允许应用程序向它创建的视图控制器弹出
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {
    
    NSLog(@"----允许应用程序向它创建的视图控制器弹出");
    
}

// 显示一个文件上传面板。completionhandler完成处理程序调用后打开面板已被撤销。通过选择的网址，如果用户选择确定，否则为零。如果不实现此方法，Web视图将表现为如果用户选择了取消按钮。
- (void)webView:(WKWebView *)webView runOpenPanelWithParameters:(WKOpenPanelParameters *)parameters initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSArray<NSURL *> * _Nullable URLs))completionHandler {
    
    NSLog(@"----显示一个文件上传面板");
    
}




//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler
//{    // js 里面的alert实现，如果不实现，网页的alert函数无效
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
//                                                                             message:nil
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
//                                                        style:UIAlertActionStyleCancel
//                                                      handler:^(UIAlertAction *action) {
//                                                          completionHandler();
//                                                      }]];
//
//    [self presentViewController:alertController animated:YES completion:^{}];
//
//}
//
//
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
//    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
//
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
//                                                                             message:nil
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
//                                                        style:UIAlertActionStyleDefault
//                                                      handler:^(UIAlertAction *action) {
//                                                          completionHandler(YES);
//                                                      }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
//                                                        style:UIAlertActionStyleCancel
//                                                      handler:^(UIAlertAction *action){
//                                                          completionHandler(NO);
//                                                      }]];
//
//    [self presentViewController:alertController animated:YES completion:^{}];
//
//}
//
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
//
//    completionHandler(@"Client Not handler");
//
//}
//


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
