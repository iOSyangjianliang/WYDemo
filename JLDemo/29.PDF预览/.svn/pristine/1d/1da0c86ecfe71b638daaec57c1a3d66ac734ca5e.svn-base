//
//  PDFViewController.m
//  PDF
//
//  Created by wu on 2018/5/18.
//  Copyright © 2018年 MMC. All rights reserved.
//

#import "PDFViewController.h"
#import <PDFKit/PDFKit.h>

API_AVAILABLE(ios(11.0))
@interface PDFViewController () <PDFDocumentDelegate>

@property (nonatomic, strong) PDFView *pdfView; // 只能在iOS11以上适用
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWhiteNavBarWithTitle:@"PDFKit显示pdf"];
    [self display];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)display {
    // iOS 11+以上的设置才能支持PDFKit
    if (@available(iOS 11.0, *)) {
        _pdfView = [[PDFView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f)];
        _pdfView.backgroundColor = [UIColor clearColor];
        _pdfView.displaysPageBreaks = YES;
        _pdfView.displayBox = kPDFDisplayBoxBleedBox; // 指定要显示/剪辑的框
        _pdfView.autoScales = YES; // 适应页面
        // 初始化document
        PDFDocument *document = [[PDFDocument alloc] initWithURL:[NSURL URLWithString:kPDFURL]];
        document.delegate = self;
        _pdfView.document = document;
        [self.view addSubview:_pdfView];
        [_pdfView layoutDocumentView];
    } else {
        // Fallback on earlier versions
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT - 460, SCREEN_WIDTH - 60, 160)];
        label.text = @"您的设备/模拟器还不是""iOS 11+""的系统，如果您想继续使用PDFKIT，请先系统升级，否则请选择webView或者预览的模式~~~";
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20.0f];
        label.numberOfLines = 0;
        [self.view addSubview:label];
        // gradientLayer
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = label.frame;
        gradientLayer.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
        [self.view.layer addSublayer:gradientLayer];
        _gradientLayer = gradientLayer;
        gradientLayer.mask = label.layer;
        label.frame = gradientLayer.bounds;
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)]; // 监听
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (UIColor *)randomColor {
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)textColorChange {
    
    _gradientLayer.colors = @[(id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor];
}

@end
