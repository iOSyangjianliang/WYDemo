//
//  MSCViewController.m
//  YiShangbao
//
//  Created by 杨建亮 on 2017/8/25.
//  Copyright © 2017年 com.Microants. All rights reserved.
// ------------科大讯飞语音--------

#define LCDW  [UIScreen mainScreen].bounds.size.width
#import "Masonry.h"
#import "WYUIStyle.h"


#import "MSCViewController.h"
#import "iflyMSC/iflyMSC.h"

#import "IATConfig.h"
#import "ISRDataHelper.h"

#import "MSCLeftTableViewCell.h"
#import "MSCRightTableViewCell.h"

#import "MSCTranslationModel.h"

#import "YouDaoTranslationApi.h"
#import "TranslationDataManager.h"

#import "MSCTranslationGuideView.h"
@interface MSCViewController ()<IFlySpeechRecognizerDelegate,IFlyPcmRecorderDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象

@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入
@property (nonatomic, strong) NSMutableString * result;

@property (nonatomic, strong) NSMutableArray * arrayMdata;

@property (nonatomic, strong) MSCLeftTableViewCell * Lcell;
@property (nonatomic, strong) MSCRightTableViewCell * Rcell;

@property (nonatomic, assign)BOOL isfirstScrollTo; //自动滑动

@property (nonatomic, weak) MSCTranslationGuideView * guideView; //功能引导页


@end
static NSString* const MSCLeftTableViewCellResign = @"MSCLeftTableViewCellResign";
static NSString* const MSCRightTableViewCellResign = @"MSCRightTableViewCellResign";

@implementation MSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.result = [NSMutableString string];
    self.title = @"在线语音翻译";
    
    self.arrayMdata = [NSMutableArray arrayWithArray:[[TranslationDataManager shareTranslationDataManager] getTranslationData] ] ;

    [self buildUI];
    
    
    
    //避免同时产生多个按钮事件
    [self setExclusiveTouchForButtons:self.view];
}

/**
 设置UIButton的ExclusiveTouch属性
 ****/
-(void)setExclusiveTouchForButtons:(UIView *)myView
{
    for (UIView * button in [myView subviews]) {
        if([button isKindOfClass:[UIButton class]])
        {
            [((UIButton *)button) setExclusiveTouch:YES];
        }
        else if ([button isKindOfClass:[UIView class]])
        {
            [self setExclusiveTouchForButtons:button];
        }
    }
}
/**---------------按住说英文-------------*/
- (void)englishUIControlEventTouchDown:(UIButton *)sender {

    
    [self  deallocMSC];

    self.result = [NSMutableString string];

    [IATConfig sharedInstance].language = [IFlySpeechConstant LANGUAGE_ENGLISH];
    [IATConfig sharedInstance].accent = @"";
    [self start_iFlySpeechRecognizer];

}
- (void)englisUIControlEventTouchUpInside:(UIButton *)sender {

    
    [self hiddenAnimatedView];
    [_pcmRecorder stop];
    [_iFlySpeechRecognizer stopListening];
}
- (void)englishUIControlEventTouchCancel:(UIButton *)sender {

    
    [self hiddenAnimatedView];
    [_pcmRecorder stop];
    [_iFlySpeechRecognizer stopListening];
}

/**---------------按住说中文-------------*/
- (void)chinaUIControlEventTouchDown:(UIButton *)sender {
    
    [self  deallocMSC];
    
    self.result = [NSMutableString string];

    [IATConfig sharedInstance].language = [IFlySpeechConstant LANGUAGE_CHINESE];
    [IATConfig sharedInstance].accent = [IFlySpeechConstant ACCENT_MANDARIN];
    [self start_iFlySpeechRecognizer];
    
}
- (void)chinaUIControlEventTouchUpInside:(UIButton *)sender {

    
    [self hiddenAnimatedView];
    [_pcmRecorder stop];
    [_iFlySpeechRecognizer stopListening];

}
- (void)chinaUIControlEventTouchCancel:(UIButton *)sender {

    
    [self hiddenAnimatedView];
    [_pcmRecorder stop];
    [_iFlySpeechRecognizer stopListening];
}


//IFlySpeechRecognizerDelegate协议实现
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
 
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    
    [self.result appendString:resultFromJson];

    if (isLast){
        NSLog(@"听写结果(json)：%@测试",  self.result);
        if ([self.result isEqualToString:@""] || [self.result isEqualToString:@"。"]) {
            return;
        }
        if ([[IATConfig sharedInstance].language isEqualToString:[IFlySpeechConstant LANGUAGE_CHINESE]]) {
            MSCTranslationModel* model = [[MSCTranslationModel alloc] init];
            model.chinese = self.result;
            model.english = @"";
            model.languageType = MSCTranslationModelChineseLanguage;
            [self.arrayMdata addObject:model];
            
            [[TranslationDataManager shareTranslationDataManager] saveTranslationDataWithModel:model];
            [self youdaoTranslationString:self.result type:TranslationChinese_English];
        }
        if ([[IATConfig sharedInstance].language isEqualToString:[IFlySpeechConstant LANGUAGE_ENGLISH]]) {
            MSCTranslationModel* model = [[MSCTranslationModel alloc] init];
            model.languageType = MSCTranslationModelEnglishLanguage;
            model.english = self.result;
            model.chinese = @"";
            [self.arrayMdata addObject:model];
            
            [[TranslationDataManager shareTranslationDataManager] saveTranslationDataWithModel:model];
            [self youdaoTranslationString:self.result type:TranslationEnglish_Chinese];
        }
        NSLog(@"%@",_arrayMdata);
        
        self.isfirstScrollTo = NO;
        [self.tableview reloadData];
//        [MBProgressHUD zx_showSuccess:self.result toView:nil];

    }
}
#pragma mark - 有道翻译
-(void)youdaoTranslationString:(NSString *)translationString type:(TranslationType)type
{
//    [MBProgressHUD zx_showLoadingWithStatus:nil toView:self.view];
//    
//    [YouDaoTranslationApi postRequestByUrlSessionWithTranslationString:translationString TranslationType:type successBlock:^(NSString *translationString) {
//       
//        [MBProgressHUD zx_hideHUDForView:self.view];
//
//        MSCTranslationModel* model = self.arrayMdata.lastObject;
//        if (type == TranslationEnglish_Chinese) { //英-中
//            model.chinese = translationString;
//        }else{
//            model.english = translationString;
//        }
////        NSLog(@"%@",kMSCTranslationDataPath);
//        [[TranslationDataManager shareTranslationDataManager] replaceLastModelWithModel:model];
//
//        self.isfirstScrollTo = NO;
//        [self.tableview reloadData];
//        
//    }failureBlock:^(NSError *error) {
//        [MBProgressHUD zx_hideHUDForView:self.view];
//
//        MSCTranslationModel* model = self.arrayMdata.lastObject;
//        if (type == TranslationEnglish_Chinese) { //英-中
//            model.TranslationFailure = @"Translation of failure";
//        }else{ //中-英
//            model.TranslationFailure = @"翻译失败";
//        }
//        [[TranslationDataManager shareTranslationDataManager] replaceLastModelWithModel:model];
//
//        self.isfirstScrollTo = NO;
//        [self.tableview reloadData];
//
//    }];
}
/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void)onError: (IFlySpeechError *) error{

    _chinaBtn.enabled = YES;
    _englishBtn.enabled = YES;
   
    if (error.errorCode != 0) {
//            [MBProgressHUD zx_showError:[NSString stringWithFormat:@"哎呀，语音识别失败啦T-T"] toView:self.view];
    }
}
//停止录音回调
- (void) onEndOfSpeech{
    [self hiddenAnimatedView];
}
//开始录音回调
- (void) onBeginOfSpeech{
    [self showAnimatedView];
    
}
//音量回调函数
- (void) onVolumeChanged: (int)volume{
}
//会话取消回调
- (void) onCancel{
    _chinaBtn.enabled = YES;
    _englishBtn.enabled = YES;
}
#pragma mark - IFlyPcmRecorderDelegate 录音代理
- (void) onIFlyRecorderBuffer: (const void *)buffer bufferSize:(int)size
{
    NSData *audioBuffer = [NSData dataWithBytes:buffer length:size];
    
    int ret = [self.iFlySpeechRecognizer writeAudio:audioBuffer];
    if (!ret)
    {
        [self.iFlySpeechRecognizer stopListening];
        
        _chinaBtn.enabled = YES;
        _englishBtn.enabled = YES;
    }
}
- (void) onIFlyRecorderError:(IFlyPcmRecorder*)recoder theError:(int) error
{
    
}
//---------------------------------
-(void)start_iFlySpeechRecognizer
{
    if(_iFlySpeechRecognizer == nil)
    {
        [self initRecognizer];
       
    }
    
    [_iFlySpeechRecognizer cancel];
    
    //设置识别语音类型
    IATConfig *instance = [IATConfig sharedInstance];
    [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
    [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
   
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iFlySpeechRecognizer setDelegate:self];
    
    BOOL ret = [_iFlySpeechRecognizer startListening];
    
    if (ret) {
        _chinaBtn.enabled = NO;
        _englishBtn.enabled = NO;

    }else{
//        [MBProgressHUD zx_showError:@"启动识别服务失败，请稍后重试" toView:self.view];//可能是上次请求未结束，暂不支持多路并发
    }

}

/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    _iFlySpeechRecognizer.delegate = self;
    
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
//        //设置语言
//        [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
//        //设置方言
//        [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];

    }
    
    //初始化录音器
    if (_pcmRecorder == nil)
    {
        _pcmRecorder = [IFlyPcmRecorder sharedInstance];
    }
    
    _pcmRecorder.delegate = self;
    
    [_pcmRecorder setSample:[IATConfig sharedInstance].sampleRate];
    
    [_pcmRecorder setSaveAudioPath:nil];    //不保存录音文件
    
    
}


#pragma mark - ------------UI-----------
-(void)showAnimatedView
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i =1; i<=3; i++) {
        NSString* imageName = [NSString stringWithFormat:@"ic_luyin1"];
        UIImage* image = [UIImage imageNamed:imageName];
        [arrayM addObject:image];
        
    }
    self.showView_AnimatedIMV.animationImages = arrayM;
    self.showView_AnimatedIMV.animationRepeatCount = 0;
    self.showView_AnimatedIMV.animationDuration = 2;
    [self.showView_AnimatedIMV startAnimating];
    self.showView.hidden = NO;

}
-(void)hiddenAnimatedView
{
    [self.showView_AnimatedIMV stopAnimating];
    self.showView.hidden = YES;
}
-(void)clickFirstUse
{
//    if (! [[NSUserDefaults standardUserDefaults] objectForKey:isFirstUseTranslation]) {
//        [[NSUserDefaults standardUserDefaults] setObject:@"MSCViewControllerIsFirstUseTranslation" forKey:isFirstUseTranslation];
//        [[NSUserDefaults standardUserDefaults]  synchronize];
//        
//        MSCTranslationGuideView * view = [[[NSBundle mainBundle] loadNibNamed:@"MSCTranslationGuideView" owner:self options:nil] lastObject];
//    
//        self.guideView = view ;
//        [self.tabBarController.view addSubview:self.guideView];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self.tabBarController.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
//    }
}
-(void)buildUI
{
    [_chinaBtn addTarget:self action:@selector(chinaUIControlEventTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_chinaBtn addTarget:self action:@selector(chinaUIControlEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_chinaBtn addTarget:self action:@selector(chinaUIControlEventTouchCancel:) forControlEvents:UIControlEventTouchCancel];

    [_englishBtn addTarget:self action:@selector(englishUIControlEventTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_englishBtn addTarget:self action:@selector(englisUIControlEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_englishBtn addTarget:self action:@selector(englishUIControlEventTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    

    self.showView.layer.masksToBounds = YES;
    self.showView.layer.cornerRadius = 5.f;
    self.showLabel.font = [UIFont systemFontOfSize:13.f];

    
    UIView *vieww = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LCDW, 25.f)];
    vieww.backgroundColor = self.tableview.backgroundColor;
    UILabel* labeel = [[UILabel alloc] initWithFrame:CGRectMake(LCDW/2-70.f, 10, 140, 15)];
    labeel.text = @"语音技术由科大讯飞提供";
    labeel.font = [UIFont systemFontOfSize:12.f];
    labeel.textColor =  [WYUISTYLE colorWithHexString:@"c2c2c2"];
    labeel.textAlignment = NSTextAlignmentCenter;
    [vieww addSubview:labeel];

    self.tableview.tableHeaderView = vieww;
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.estimatedRowHeight = 200; //

    
    [self.tableview registerNib:[UINib nibWithNibName:@"MSCLeftTableViewCell" bundle:nil ] forCellReuseIdentifier:MSCLeftTableViewCellResign];
    [self.tableview registerNib:[UINib nibWithNibName:@"MSCRightTableViewCell" bundle:nil] forCellReuseIdentifier:MSCRightTableViewCellResign];
 
    self.Lcell = [self.tableview dequeueReusableCellWithIdentifier:MSCLeftTableViewCellResign];
    self.Rcell = [self.tableview dequeueReusableCellWithIdentifier:MSCRightTableViewCellResign];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self  clickFirstUse];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayMdata.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSCTranslationModel* model = self.arrayMdata[indexPath.row];
    if (model.languageType == MSCTranslationModelChineseLanguage) {
        return [self.Lcell getCellHeightWithContentData:model];
    }else{
        return [self.Rcell getCellHeightWithContentData:model];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSCTranslationModel* model = self.arrayMdata[indexPath.row];
    
    if (model.languageType == MSCTranslationModelChineseLanguage) {
        MSCLeftTableViewCell* cellLeft = [tableView dequeueReusableCellWithIdentifier:MSCLeftTableViewCellResign forIndexPath:indexPath];
        

        cellLeft.chineseLabel.text = [NSString stringWithFormat:@"%@",model.chinese];
        if (model.TranslationFailure) {
            cellLeft.englishLabel.text = [NSString stringWithFormat:@"%@",model.TranslationFailure];
            cellLeft.englishLabel.textColor = [WYUISTYLE colorWithHexString:@"45a4e8"];
        }else{
            cellLeft.englishLabel.text = [NSString stringWithFormat:@"%@",model.english];
            cellLeft.englishLabel.textColor = [WYUISTYLE colorWithHexString:@"2f2f2f"];
        }
        cellLeft.selectionStyle = UITableViewCellSelectionStyleNone;
        return cellLeft;
    }else{
        MSCRightTableViewCell* cellRight = [tableView dequeueReusableCellWithIdentifier:MSCRightTableViewCellResign forIndexPath:indexPath];
        
        
        
        cellRight.englishLabel.text = [NSString stringWithFormat:@"%@",model.english];
        
        if (model.TranslationFailure) {
            cellRight.chineseLabel.text = [NSString stringWithFormat:@"%@",model.TranslationFailure];
            cellRight.chineseLabel.textColor = [WYUISTYLE colorWithHexString:@"45a4e8"];
        }else{
            cellRight.chineseLabel.text = [NSString stringWithFormat:@"%@",model.chinese];
            cellRight.chineseLabel.textColor = [WYUISTYLE colorWithHexString:@"2f2f2f"];
        }
        cellRight.selectionStyle = UITableViewCellSelectionStyleNone;
        return cellRight;

    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    if ( !self.isfirstScrollTo) {
        self.isfirstScrollTo = YES; //scrollToRowAtIndexPath只在第一次进来生效
        NSIndexPath* indexP = [NSIndexPath indexPathForRow:self.arrayMdata.count-1 inSection:0];
        [self.tableview scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self initRecognizer];//初始化识别对象
    
    NSString * str_Network = [YouDaoTranslationApi networkingStatesFromStatebar];
    if (!str_Network) {
//        [MBProgressHUD zx_showError:@"老板，你的网断了，检查下哇" toView:self.view];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self deallocMSC];
    
    [super viewWillDisappear:animated];
    
    if (self.guideView.superview) {
        [self.guideView removeFromSuperview];
    }
}
-(void)deallocMSC
{
    [_iFlySpeechRecognizer cancel]; //取消识别
    [_iFlySpeechRecognizer setDelegate:nil];
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    
    [_pcmRecorder stop];
    _pcmRecorder.delegate = nil;

}
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
