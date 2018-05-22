//
//  WelcomeViewController.m
//  PDF
//
//  Created by wu on 2018/5/18.
//  Copyright © 2018年 MMC. All rights reserved.
//

#import "WelcomeViewController.h"
#import "PDFViewController.h"
#import "WebViewController.h"
#import <QuickLook/QuickLook.h>

@interface WelcomeViewController () <NSURLSessionDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (nonatomic, strong) NSMutableData *data; // 数据流

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [NSMutableData data];
    
    [self createWhiteNavBarWithTitle:@"欢迎使用PDF"];
    [self display];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationItem.leftBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)display {
    // 循环创建3个button,依次为WebView、预览、PDFKit
    NSArray *array = @[@"webView-PDF",@"预览",@"PDFKIT"].mutableCopy;
    NSArray *normalArr = @[[UIColor orangeColor],[UIColor blueColor],[UIColor purpleColor]].mutableCopy;
    NSArray *hltArr = @[[[UIColor orangeColor] colorWithAlphaComponent:0.7f], [[UIColor blueColor] colorWithAlphaComponent:0.56f], [[UIColor purpleColor] colorWithAlphaComponent:0.647f]].mutableCopy;
    for (int i = 0; i < 3; i ++) {
        UIButton *btn = [self buttonWithTitle:[array objectAtIndex:i] NormalColor:[normalArr objectAtIndex:i] HltColor:[hltArr objectAtIndex:i] ButtonTag:i];
        btn.frame = CGRectMake((SCREEN_WIDTH - 130) / 2.0f, 60 * i + 70, 130, 50);
        [self.view addSubview:btn];
    }
    
    UILabel *imageView = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60) / 2.0f, 400, 60, 60)];
    imageView.backgroundColor = kUIColorFromRGB(0x118CE8);
    imageView.textColor = [UIColor whiteColor];
    imageView.font = [UIFont systemFontOfSize:16];
    imageView.textAlignment = NSTextAlignmentCenter;
    imageView.text = @"晨";
    imageView.layer.cornerRadius = 30.0f;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
}

#pragma mark - Actions
- (void)btnClicked:(UIButton *)btn {
    if (btn.tag == 0) {
        // webView
        WebViewController *webVC = [[WebViewController alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if (btn.tag == 1) {
        // 预览
        NSString *filename = @"预览显示pdf";
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
        if(![fileManager fileExistsAtPath:filePath]) {
            // 文件不存在,需要下载文件
            NSLog(@"文件不存在");
        }
        else {
            NSLog(@"文件存在");
        }
        NSURL *url = [NSURL URLWithString:kPDFURL]; // 下载网址
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration]; // 创建管理类
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]]; // 初始化session并制定代理
        NSURLSessionDataTask *task = [session dataTaskWithURL:url];
        [task resume];  // 开始
    }
    else {
        // pdfKit
        PDFViewController *pdfVC = [[PDFViewController alloc] init];
        [self.navigationController pushViewController:pdfVC animated:YES];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error  {
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    destPath = [destPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",@"预览显示pdf"]];
    // 将下载的二进制文件转成入文件
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDownLoad = [manager createFileAtPath:destPath contents:self.data attributes:nil];
    if (isDownLoad) {
        [self.progressHUB hideAnimated:NO];
        NSLog(@"下载完成");
    }
    else {
        // 下载失败
        [self.progressHUB hideAnimated:NO];
        [self showException:@"下载失败，请稍后再试！"];
        NSLog(@"下载失败");
    }
    // 创建预览
    QLPreviewController *qlPreview = [[QLPreviewController alloc] init];
    qlPreview.view.frame = self.view.bounds;
    qlPreview.dataSource = self;
    qlPreview.delegate = self;
    [self presentViewController:qlPreview animated:YES completion:^{
        [self defineUIStatusBarStyleDefault];
    }];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [self.progressHUB showAnimated:YES];
    [self.data appendData:data]; // 将每次接受到的数据拼接起来
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    [self.progressHUB hideAnimated:NO];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    [self.progressHUB hideAnimated:NO];
}

#pragma mark QLPreviewControllerDelegate
- (NSInteger)numberOfPreviewItemsInPreviewController:(nonnull QLPreviewController *)controller {
    return 1; // 返回文件的个数
}

- (nonnull id<QLPreviewItem>)previewController:(nonnull QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    // 在此代理处加载需要显示的文件
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]; // 获取指定文件 路径
    NSURL *storeUrl = [NSURL fileURLWithPath: [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",@"预览显示pdf"]]]; // 导航栏标题
    
    return storeUrl;
}

#pragma mak - Public
- (UIButton *)buttonWithTitle:(NSString *)title
                  NormalColor:(UIColor *)normalColor
                     HltColor:(UIColor *)hltColor
                    ButtonTag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:kUIColor(255, 255, 255, 0.7) forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:normalColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:hltColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
