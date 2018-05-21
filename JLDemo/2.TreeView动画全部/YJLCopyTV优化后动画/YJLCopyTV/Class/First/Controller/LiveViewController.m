//
//  LiveViewController.m
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import "LiveViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "KxMovieViewController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "RGBColor.h"

@interface LiveViewController ()
{
    UIImageView* _imV ;
    HotLiveModel* nowHotModel;
    UICollectionView* _collectionView;
    UICollectionViewFlowLayout*_flowLayout;
}
@property (weak, nonatomic) IBOutlet UIView *PlayView;
@property (weak, nonatomic) IBOutlet UIView *TouchView;
@property (weak, nonatomic) IBOutlet UIButton *BeiJingBtn;

@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UILabel *miaoboLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollerView;
@property (weak, nonatomic) IBOutlet UIButton *touxiangBtn;
@property (weak, nonatomic) IBOutlet UILabel *renshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *maoliangLabel;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *TwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *ThreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *FourBtn;
@property (weak, nonatomic) IBOutlet UIButton *FiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
@property (weak, nonatomic) IBOutlet UIImageView *BackImV;

@property (weak, nonatomic) IBOutlet UIView *maoliangbackView;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor blackColor];
    
    [self boFangLiZhi];
    [self qieYuanJiao:_num];
    [self loadIMG:_index leiXin:_num];
    [self liveWithIndex:_index];
}

-(void)qieYuanJiao:(NSInteger)num
{
    _BeiJingBtn.layer.masksToBounds = YES;
    _BeiJingBtn.layer.cornerRadius  = 25;
    
    _touxiangBtn.layer.masksToBounds = YES;
    _touxiangBtn.layer.cornerRadius = 15;
    _touxiangBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _touxiangBtn.layer.borderWidth = 1;
    _touxiangBtn.adjustsImageWhenHighlighted = NO;
    
    _guanzhuBtn.layer.masksToBounds = YES;
    _guanzhuBtn.layer.cornerRadius = 15;
    _guanzhuBtn.backgroundColor = [RGBColor colorWithHexString:@"#EE3A8C"];
    
    _maoliangbackView.layer.masksToBounds = YES;
    _maoliangbackView.layer.cornerRadius = 10;
    
    _ScrollerView.contentSize = CGSizeMake(_arrayData.count*40, 0);
    _ScrollerView.showsHorizontalScrollIndicator = NO;
//    _ScrollerView.backgroundColor = [UIColor redColor];
    for (int i=0; i<_arrayData.count; ++i) {
        CGFloat X =(30+10)*i;
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(X, 10, 30, 30)];
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth =1;
        btn.layer.borderColor = [RGBColor colorWithHexString:@"#00EEEE"].CGColor;
        btn.layer.cornerRadius = 15;
        HotLiveModel* model = _arrayData[i];
        NSString* str ;
        if (_num == 1) {
            str = model.smallpic;
        }else if (_num==2){
            str = model.photo;
        }
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [_ScrollerView addSubview:btn];
    }
    [_ScrollerView setContentOffset:CGPointMake(40*_index, 0) animated:NO];
    
}

-(void)Click:(UIButton*)sender
{
    [self liveWithIndex:sender.tag-100];
    [self loadIMG:sender.tag-100 leiXin:_num];
}
//播放粒子效果
-(void)boFangLiZhi
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    // 发射器在xy平面的中心位置
    CGPoint point = _oneBtn.center;
    point.y-= 50;
    NSLog(@">>>>>>>>%f",point.y);
    emitterLayer.emitterPosition = point;
    // 发射器的尺寸大小
    emitterLayer.emitterSize = CGSizeMake(20, 20);
    // 渲染模式
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
    // 开启三维效果
//    emitterLayer.preservesDepth = YES;
    NSMutableArray *array = [NSMutableArray array];
    // 创建粒子
    for (int i = 0; i<10; i++) {
        // 发射单元
        CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
        // 粒子的创建速率，默认为1/s
        stepCell.birthRate = 1;
        // 粒子存活时间
        stepCell.lifetime = arc4random_uniform(2) + 1;
        // 粒子的生存时间容差
        stepCell.lifetimeRange = 1.2;
        // 颜色
        // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30_", i]];
        
        // 粒子显示的内容
        stepCell.contents = (id)[image CGImage];
        // 粒子的名字
        //            [fire setName:@"step%d", i];
        // 粒子的运动速度
        stepCell.velocity = arc4random_uniform(100) + 100;
        // 粒子速度的容差
        stepCell.velocityRange = 80;
        // 粒子在xy平面的发射角度
        stepCell.emissionLongitude = M_PI+M_PI_2;;
        // 粒子发射角度的容差
        stepCell.emissionRange = M_PI_2/6;
        // 缩放比例
        stepCell.scale = 0.35;
        [array addObject:stepCell];
    }    
    emitterLayer.emitterCells = array;
    [_TouchView.layer addSublayer:emitterLayer];
}
-(void)loadIMG:(NSInteger)index leiXin:(NSInteger)num
{
    HotLiveModel* model = _arrayData[index];
    NSString* str ;
    if (_num == 1) {
        str = model.smallpic;
        _nameLabel.text = model.myname;
        _renshuLabel.text = [NSString stringWithFormat:@"%@",model.allnum];
    }else if (_num==2){
        str = model.photo;
    }
    [_touxiangBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
    [_BackImV sd_setImageWithURL:[NSURL URLWithString:str]];
    _BackImV.alpha = 0.3;
}
-(void)liveWithIndex:(NSInteger)index
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    if ([_hotModel.flv isEqualToString:@"flv"]) {
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    }
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone) {
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    }
    HotLiveModel* hotM = _arrayData[index];
    
    KxMovieViewController* KxMVC = [KxMovieViewController movieViewControllerWithContentPath:hotM.flv parameters:parameters];
    KxMVC.view.backgroundColor = [UIColor clearColor];
    [_PlayView addSubview: KxMVC.view];
    [self addChildViewController:KxMVC];
    
    [KxMVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_PlayView.mas_top).offset(0);
        make.left.equalTo(_PlayView.mas_left).offset(0);
        make.right.equalTo(_PlayView.mas_right).offset(0);
        make.bottom.equalTo(_PlayView.mas_bottom).offset(0);
    } ];
}
/**
 *
 */
- (IBAction)SixBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)GuanZhu:(id)sender {
}

@end
