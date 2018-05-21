//
//  TreeView.m
//  test
//
//  Created by 海狮 on 17/5/13.
//  Copyright © 2017年 海狮. All rights reserved.
//
#define SCR_W     [UIScreen mainScreen].bounds.size.width
#define SCR_H     [UIScreen mainScreen].bounds.size.height
#define Default_left_rightW 40.f  //按钮距离左右边界间距
#define Default_button_V_W 15.f  //按钮之间水平间距
#define Default_button_H_H 0.f   //按钮之间垂直间距
#define Default_UnderButtonToTabbarBtnTopH 40.f  //按钮距离tabar顶部间距
#define TabbarNums 5//tabbarItem个数
#import "TreeView.h"

@interface TreeView ()<UITabBarControllerDelegate,CAAnimationDelegate>
@property(nonatomic,strong)NSMutableArray* arrayimages;  //items
@property(nonatomic,strong)UITabBarController* tabC;
@property(nonatomic)BOOL BtnifClickAgain;  //记录中间按钮重复点击
@property(nonatomic,strong)UIControl* middleTabbarBtn;
@property(nonatomic,strong)UIImageView* backgroundView;  //蒙层view


@property(nonatomic,strong)UIView* midIMV;
@end

static TreeView* _treeview;
static UIImageView* _tabbarBackViewLeft;
static UIImageView* _tabbarBackViewRight;

@implementation TreeView


+ (instancetype)shareTreeView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _treeview = [[TreeView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H)];
        _tabbarBackViewLeft = [[UIImageView alloc] init] ;
        _tabbarBackViewRight = [[UIImageView alloc] init];
    });
    return _treeview;
}
-(void)AllHiden:(BOOL)hidden
{
    _treeview.hidden = hidden;
    _tabbarBackViewLeft.hidden  = hidden;
    _tabbarBackViewRight.hidden = hidden;
    
}
-(void)clickUI
{
    //添加视图,并修正层级
    [self.tabC.view addSubview:[TreeView shareTreeView]];
    [self.tabC.view bringSubviewToFront:self.tabC.tabBar]; //
    [self.tabC.view addSubview:_tabbarBackViewLeft];
    [self.tabC.view addSubview:_tabbarBackViewRight];
    
//    _tabbarBackViewLeft.backgroundColor = [UIColor purpleColor];
//    _tabbarBackViewRight.backgroundColor = [UIColor purpleColor];
//    _tabbarBackViewLeft.alpha = 0.4;
//    _tabbarBackViewRight.alpha = 0.3;
    
    

}
-(void)removeFromSuperviewAll
{
    [self removeFromSuperview];
    [_tabbarBackViewLeft removeFromSuperview];
    [_tabbarBackViewRight removeFromSuperview];
}
//－－－－－－
-(void)addSelfToTabbarController:(UITabBarController*)tabC WithArrayImages:(NSArray *)arrayimages
{
    self.tabC = tabC;

    //获取tabBar中间那个按钮
    [self HuoQuMiddleTabbarBtn:tabC];
    
    CGFloat Size_W = SCR_W*(TabbarNums-1)/TabbarNums/2;
    _tabbarBackViewLeft.frame = CGRectMake(0, tabC.tabBar.frame.origin.y, Size_W, tabC.tabBar.frame.size.height);
    _tabbarBackViewRight.frame = CGRectMake(SCR_W-Size_W, tabC.tabBar.frame.origin.y, Size_W, tabC.tabBar.frame.size.height);

    [self clickUI];
    
    //根据str/images初始化TreeItem
    self.arrayimages = [NSMutableArray array];
    for (int  i = 0; i<arrayimages.count; ++i) {
        TreeItem *sub = [[TreeItem alloc] initWithFrame:CGRectZero];
        NSObject* ob = arrayimages[i];
        if ([ob isKindOfClass:[UIImage class]]) {
            [sub.treeBtn setBackgroundImage:(UIImage*)ob forState:UIControlStateNormal];
        }else if ([ob isKindOfClass:[NSString class]]){
            [sub.treeBtn setBackgroundImage:[UIImage imageNamed:arrayimages[i]] forState:UIControlStateNormal];
        }
        [self.arrayimages addObject:sub];
    }
    
    //TreeItem重新布局
    [self setArrayWithTreeItems:self.arrayimages];
    
    //给背景添加手势点击移除/隐藏
    [self addBackgroundViewGestureRecognizer];
    //隐藏
    [self AllHiden:YES];

    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H-49)];
         self.backgroundView.backgroundColor = [UIColor blackColor];
         self.backgroundView.alpha = 0.35;
        [self addSubview: self.backgroundView];
        
    }
    return self;
}
#pragma mark - 给背景添加点击手势隐藏
-(void)addBackgroundViewGestureRecognizer
{
    UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    UITapGestureRecognizer *tapGes2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    UITapGestureRecognizer *tapGes3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];

    self.backgroundView.userInteractionEnabled = YES;
    _tabbarBackViewLeft.userInteractionEnabled = YES;
    _tabbarBackViewRight.userInteractionEnabled = YES;
    
    [self.backgroundView addGestureRecognizer:tapGes1];
    [_tabbarBackViewLeft addGestureRecognizer:tapGes2];
    [_tabbarBackViewRight addGestureRecognizer:tapGes3];

    
}
-(void)AllBackViewUserInteractionEnabled:(BOOL)bo
{
    self.backgroundView.userInteractionEnabled = bo;
    _tabbarBackViewLeft.userInteractionEnabled = bo;
    _tabbarBackViewRight.userInteractionEnabled = bo;
}
- (void)tapGes:(UITapGestureRecognizer *)sender
{
    //X重复点击
    [self AllBackViewUserInteractionEnabled:NO];
    
    [self addAnimation:NO];
    [self expend:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
       
        [self AllBackViewUserInteractionEnabled:YES];
        //延迟等动画加载完
        [self AllHiden:YES];
        self.backgroundView.alpha = 0.35;
        
    }];
    self.clickbackgroundViewBlock(YES);
}
#pragma mark - 获取tabbar中间按钮
-(void)HuoQuMiddleTabbarBtn:(UITabBarController*)tabC
{
    CGFloat www = 1000000000000000000;
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    for (UIControl *tabBarButton in tabC.tabBar.subviews){
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            CGFloat b  = tabBarButton.frame.origin.x;
            CGFloat w = b>SCR_W/2?b-SCR_W/2:SCR_W/2-b;
            if (w<www) {
                www = w;
                [tabbarbuttonArray addObject:tabBarButton];
            }
            
        }
    }
    if (tabbarbuttonArray.lastObject) {
        
        self.middleTabbarBtn = tabbarbuttonArray.lastObject;

//        NSLog(@"%@--",NSStringFromCGRect(tabBarButton.frame));
        //可以给他添加点击方法
//        [self.middleTabbarBtn addTarget:self action:@selector(autoShowWihtBo:) forControlEvents:UIControlEventTouchUpInside];
        
    }

}
#pragma mark - 自动展示
//show
-(void)autoShowWihtBo:(BOOL)sameClick ifOther:(BOOL)isother
{
    
    self.middleTabbarBtn.userInteractionEnabled = NO;

    if (sameClick) {
        [self AllHiden:NO];
        [self addAnimation:YES];
        [self expend:YES];

    }else{
        if (isother) {
            _BtnifClickAgain = NO;
            self.middleTabbarBtn.userInteractionEnabled = YES;

            return;
        }
        if (!_BtnifClickAgain) {
            _BtnifClickAgain = YES; //
            self.middleTabbarBtn.userInteractionEnabled = YES;

            return;
        }
        
        [self addAnimation:NO];
        [self expend:NO];
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            //延迟等动画加载完
            [self AllHiden:YES];
            self.backgroundView.alpha = 0.35;

        }];
        
    }

}



-(void)addAnimation:(BOOL)FromTo
{

    for (UIView *imageView in self.middleTabbarBtn.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
        
            //1.创建动画并指定动画属性
            CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            
            basicAnimation.delegate = self;
            //2.设置动画属性初始值、结束值
            if (FromTo) {
                basicAnimation.fromValue=[NSNumber numberWithInt:0];
                basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_4*3];
            }else{
                basicAnimation.fromValue=[NSNumber numberWithFloat:M_PI_4*3];
                basicAnimation.toValue=[NSNumber numberWithInt:0];

            }
            
            //设置其他动画属性
            if (FromTo) {
                basicAnimation.duration= 0.27;
            }else{
                basicAnimation.duration= 0.33;
            }
            //basicAnimation.autoreverses= YES;//旋转后再旋转到原来的位置
            basicAnimation.removedOnCompletion = NO;
            basicAnimation.fillMode = kCAFillModeForwards;
            
            //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
            [imageView.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
        }
    }

}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.middleTabbarBtn.userInteractionEnabled = YES;
}
#pragma mark - TreeItm－－－点击－－－－代理方法
-(void)ClickTreeItmBtn:(UIButton*)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(jl_TreeItems:treeItemsNSInteger:)]){
        [self.delegate jl_TreeItems:(TreeItem*)sender.superview treeItemsNSInteger:sender.tag-20000];
    }
    [self addAnimation:NO];
    [self expend:NO];
    [self AllHiden:YES]; //复位隐藏
    self.clickbackgroundViewBlock(YES);

}
#pragma mark -------UI---------
-(void)setArrayWithTreeItems:(NSArray *)ArrayWithTreeItems
{
        
        CGFloat Btn_X = Default_left_rightW;
        CGFloat Btn_WH = (SCR_W-Default_left_rightW*2-Default_button_V_W*(ArrayWithTreeItems.count-1))/ArrayWithTreeItems.count;
        CGFloat Btn_Y = SCR_H-49-Default_UnderButtonToTabbarBtnTopH-Btn_WH;

        for (int i= 0; i<ArrayWithTreeItems.count; ++i) {
            TreeItem *item = [ArrayWithTreeItems objectAtIndex:i];
//            item.tag = 10000+i;
            item.treeBtn.tag = 20000+i;
            
            CGRect sizeZeroFrame =  item.frame;
            sizeZeroFrame.size = CGSizeMake(Btn_WH, Btn_WH);
            item.frame = sizeZeroFrame;
            item.center = CGPointMake(SCR_W/2,SCR_H-Btn_WH/2);  //
            //动画起点
            item.startPoint = CGPointMake(self.middleTabbarBtn.center.x, SCR_H-self.middleTabbarBtn.frame.size.height/2);;
            
            //point
            item.endPoint = CGPointMake(Btn_X+Btn_WH/2, Btn_Y+Btn_WH/2);
            item.nearPoint = CGPointMake(Btn_X+Btn_WH/2, Btn_Y+Btn_WH/2);
            item.farPoint = CGPointMake(Btn_X+Btn_WH/2, Btn_Y+Btn_WH/2);
            
            Btn_X += Btn_WH+Default_button_V_W;
            if (ArrayWithTreeItems.count%2 == 0) {
                if (i == ArrayWithTreeItems.count/2-1) {
                    
                }else if (i<ArrayWithTreeItems.count/2){
                    Btn_Y -= Default_button_H_H;
                }else{
                    Btn_Y += Default_button_H_H;
                }
            }else{
                if (i<ArrayWithTreeItems.count/2) {
                    Btn_Y -= Default_button_H_H;
                }else{
                    Btn_Y += Default_button_H_H;
                }
            }
                       
            [item.treeBtn addTarget:self action:@selector(ClickTreeItmBtn:) forControlEvents:UIControlEventTouchUpInside];
            item.layer.cornerRadius = Btn_WH/2;
            [item setTreeBtnSize:item.frame.size];

            [self addSubview:item];
            
        }
}
#pragma mark -------动画---------
- (void)expend:(BOOL)isExpend {

    
    [self.arrayimages enumerateObjectsUsingBlock:^(TreeItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self addCAAnimationGroupForItem:obj toShow:isExpend];
//        if (self.scale) {
//            if (isExpend) {
//                obj.transform = CGAffineTransformIdentity;
//
//            } else {
//                obj.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
//            }
//        }
//        [self addRotateAndPostisionForItem:obj toShow:isExpend];
    }];
}

- (void)addRotateAndPostisionForItem:(TreeItem *)item toShow:(BOOL)show {
    if (show) {
        CASpringAnimation *springAnimation = nil;
        if (self.scale) {
            springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
            springAnimation.damping = 5;
            springAnimation.stiffness = 100;
            springAnimation.mass = 1;
            springAnimation.duration = 0.3f;
            springAnimation.fromValue = [NSNumber numberWithFloat:0.2];
            springAnimation.toValue = [NSNumber numberWithFloat:1.0];
        }
        
        CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation.values = @[@(M_PI), @(0.0)];
        rotateAnimation.duration = 0.3f;
        rotateAnimation.keyTimes = @[@(0.3), @(0.4)];
        
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration = 0.3f;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
        CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
        CGPathAddLineToPoint(path, NULL, item.nearPoint.x, item.nearPoint.y);
        CGPathAddLineToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
        positionAnimation.path = path;
        CGPathRelease(path);
        
        
        CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
        if (self.scale) {
//            animationgroup.animations = @[positionAnimation, rotateAnimation,springAnimation];
            animationgroup.animations = @[positionAnimation,springAnimation];

        } else {
//            animationgroup.animations = @[positionAnimation, rotateAnimation];
            animationgroup.animations = @[positionAnimation,springAnimation];

        }
        animationgroup.duration = 0.3f;
        animationgroup.fillMode = kCAFillModeForwards;
        animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [item.layer addAnimation:animationgroup forKey:@"Expand"];
        item.center = item.endPoint;
    } else {
        CASpringAnimation *springAnimation = nil;
        if (self.scale) {
            springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
            springAnimation.damping = 5;
            springAnimation.stiffness = 100;
            springAnimation.mass = 1;
            springAnimation.duration = 0.3f;
            springAnimation.fromValue = [NSNumber numberWithFloat:1.0];
            springAnimation.toValue = [NSNumber numberWithFloat:0.7];
        }
        
        CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation.values = @[@0, @(M_PI * 2), @(0)];
        rotateAnimation.duration = 0.3f;
        rotateAnimation.keyTimes = @[@0, @(0.4), @(0.5)];
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration = 0.3f;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
        CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
        CGPathAddLineToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
        positionAnimation.path = path;
        CGPathRelease(path);
        
        CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
        if (self.scale) {
            animationgroup.animations = @[positionAnimation, rotateAnimation,springAnimation];
//            animationgroup.animations = @[positionAnimation,springAnimation];

        } else {
            animationgroup.animations = @[positionAnimation, rotateAnimation];
//            animationgroup.animations = @[positionAnimation];

        }
        
        animationgroup.duration = 0.3f;
        animationgroup.fillMode = kCAFillModeForwards;
        animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [item.layer addAnimation:animationgroup forKey:@"Close"];
        item.center = item.startPoint;


    }
}
- (void)addCAAnimationGroupForItem:(TreeItem *)item toShow:(BOOL)show
{
    if (show) {
        item.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    }
//    item.transform = CGAffineTransformIdentity;

    [UIView animateWithDuration:2.0 animations:^{
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -100);
        //在缩放基础上叠加平移
        CGAffineTransform scaleTranslation = CGAffineTransformScale(translation, 1, 1);
        item.transform = scaleTranslation;
    }];
    
}
@end

