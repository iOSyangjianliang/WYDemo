//
//  WebViewController.m
//  PDF
//
//  Created by wu on 2018/5/18.
//  Copyright © 2018年 MMC. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "WYWebProgressLayer.h"
#import "UIView+Frame.h"

@interface WebViewController () <WKNavigationDelegate>

{
    WYWebProgressLayer *_progressLayer; // 网页加载进度条
}

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWhiteNavBarWithTitle:@"webView显示pdf"];
    [self display];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_progressLayer finishedLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)display {
    // _webView
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    if (@available(iOS 11.0, *)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _webView.navigationDelegate = self;
    _webView.opaque = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.backgroundColor = [UIColor clearColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kPDFURL]]];
    [self.view addSubview:_webView];
    
    // textLabel
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2.0f, 16, 200.0f, 12)];
    _textLabel.hidden = YES;
    _textLabel.textColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.45];
    _textLabel.text = @"网页由www.hsjy.com提供";
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont systemFontOfSize:12.0f];
    [_webView addSubview:_textLabel];
    [_webView bringSubviewToFront:_webView.scrollView];
    
    // progressLayer
    _progressLayer = [[WYWebProgressLayer alloc] init];
    _progressLayer.frame = CGRectMake(0, 42, SCREEN_WIDTH, 2);
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    // 开始加载
    [_progressLayer startLoad];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 加载完成
    _textLabel.hidden = NO;
    [_progressLayer finishedLoad];
    
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil]; // 禁止复制
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    // 网页出错
    _textLabel.hidden = NO;
    [_progressLayer finishedLoad];
    NSLog(@"网页报错信息:%@",error.localizedDescription);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    // 网页出错
    [_progressLayer finishedLoad];
    
    NSLog(@"网页报错信息:%@",error.localizedDescription);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSLog(@"URL:%@",URL);
    NSString *scheme = [URL scheme];
    NSLog(@"scheme:%@",scheme);
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
