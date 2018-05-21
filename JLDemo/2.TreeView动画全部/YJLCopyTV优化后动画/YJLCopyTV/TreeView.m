//
//  TreeView.m
//  YJLCopyTV
//
//  Created by 海狮 on 17/6/16.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#define SCR_W     [UIScreen mainScreen].bounds.size.width
#define SCR_H     [UIScreen mainScreen].bounds.size.height
#define Default_left_rightW 40.f  //按钮距离左右边界间距
#define Default_button_V_W 0.f  //按钮之间水平间距
#define Default_button_H_H 0.f   //按钮之间垂直间距
#define Default_UnderButtonToTabbarBtnTopH 40.f  //按钮距离tabar顶部间距
#define TabbarNums 5//tabbaritem个数
#import "TreeView.h"

@interface TreeView ()<CAAnimationDelegate>
@property(nonatomic,strong)UIView* backgroundView;  //灰蒙层view
@property(nonatomic,strong)UIView* TabBarbackgroundView;
@property(nonatomic,strong)UIButton* TabBarCopyBtn;
@property(nonatomic,strong)UIImageView* imageViewCopy;//X

@property(nonatomic,strong)NSMutableArray* arrayMTreeItems;
@property(nonatomic,assign)BOOL isTouch;//动画期间不让打断

@end


static TreeView* _treeview;
@implementation TreeView
+ (instancetype)shareTreeView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _treeview = [[TreeView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H)];
    });
    return _treeview;
}

-(void)addToTabbarController:(UITabBarController*)tabC WithTreeItemsArrayImages:(NSArray*)arrayimages;
{
    [tabC.view addSubview:self];

    [self buildTabBarCopyBtnWithTabBarC:tabC];
    
    [self addTreeItemsWithArray:arrayimages];
    
    [self expend:YES];
    [self expendTabBarCopyRotation:YES];
}
-(void)expendTabBarCopyRotation:(BOOL)isExtend
{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")

    
//    basicAnimation.delegate = self;
    //2.设置动画属性初始值、结束值
    if (isExtend) {
        basicAnimation.fromValue=[NSNumber numberWithInt:0];
        basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_4*3];
    }else{
        basicAnimation.fromValue=[NSNumber numberWithFloat:M_PI_4*3];
        basicAnimation.toValue=[NSNumber numberWithInt:0];
    }    
    //3.设置其他动画属性
    if (isExtend) {
        basicAnimation.duration= 10.3;
    }else{
        basicAnimation.duration= 10.3;
    }
    //basicAnimation.autoreverses= YES;//旋转后再旋转到原来的位置
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self.imageViewCopy.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}
-(void)animationDidStart:(CAAnimation *)anim
{
    //动画期间禁止交互
    self.isTouch = YES;
    self.TabBarCopyBtn.userInteractionEnabled = NO;
    [self.arrayMTreeItems enumerateObjectsUsingBlock:^(TreeItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.userInteractionEnabled = NO;
    }];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.isTouch = NO;
    self.TabBarCopyBtn.userInteractionEnabled = YES;
    [self.arrayMTreeItems enumerateObjectsUsingBlock:^(TreeItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.userInteractionEnabled = YES;
    }];
    
    TreeItem* it = self.arrayMTreeItems.lastObject;
    if ([anim isEqual:[it.layer animationForKey:@"groupAnimation_End"]]) {
        NSLog(@"TreeView动画组要收缩移除------");
        
//            CAAnimation* an1 = [it.layer animationForKey:@"groupAnimation_Start"];
//            CAAnimation* an2 = [it.layer animationForKey:@"groupAnimation_End"];
//            an1.delegate = nil;//动画组设置成全局变量会循环引用
//            an2.delegate = nil;
            [it.layer removeAllAnimations];
            [self.imageViewCopy.layer removeAllAnimations];
        if (self.superview) {
            [self removeFromSuperview];
        }

    }
    //Note:1.把动画存储为一个属性然后再回调中比较，用来判定是哪个动画是不可行的。应为委托传入的动画参数是原始值的一个深拷贝，不是同一个值
    //2.方法中的flag参数表明了动画是自然结束还是被打断,比如调用了removeAnimationForKey:方法或removeAnimationForKey方法，flag为NO，如果是正常结束，flag为YES，http://www.jianshu.com/p/02c341c748f9
}
-(void)dealloc
{
    NSLog(@"treeView要dealloc");
}
#pragma mark -------动画---------
- (void)expend:(BOOL)isExpend
{
    
    [self.arrayMTreeItems enumerateObjectsUsingBlock:^(TreeItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addAnimationWithTreeItems:obj toShow:isExpend];
//        NSLog(@"%ld-----",idx);
    }];
}
-(void)addAnimationWithTreeItems:(TreeItem *)item toShow:(BOOL)show
{
    if (show) {
        CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        NSValue *value0 = [NSValue valueWithCGPoint:item.startPoint];
//            NSValue *value1 = [NSValue valueWithCGPoint:item.farPoint];
//            NSValue *value2 = [NSValue valueWithCGPoint:item.nearPoint];
        NSValue *value3 = [NSValue valueWithCGPoint:item.endPoint];
        anima1.values = [NSArray arrayWithObjects:value0,value3, nil];
        
        //缩放动画
        CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anima2.fromValue = [NSNumber numberWithFloat:0.4f];
        anima2.toValue = [NSNumber numberWithFloat:1.0f];
        
        //旋转动画
        CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anima3.toValue = [NSNumber numberWithFloat:M_PI];
        
        //组动画
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
        groupAnimation.duration = 19.3f;
        
        if ([item isEqual:self.arrayMTreeItems.lastObject ]) {
            groupAnimation.delegate = self;  //只给最后一个设置代理，方便解决循环引用内存释放
        }

        // 动画匀速
        //    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
        
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.fillMode = kCAFillModeForwards;
        
        [item.layer addAnimation:groupAnimation forKey:@"groupAnimation_Start"];
        item.center = item.endPoint;//
    }else{
        CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        NSValue *value0 = [NSValue valueWithCGPoint:item.startPoint];
        //    NSValue *value1 = [NSValue valueWithCGPoint:item.farPoint];
        //    NSValue *value2 = [NSValue valueWithCGPoint:item.nearPoint];
        NSValue *value3 = [NSValue valueWithCGPoint:item.endPoint];
        anima1.values = [NSArray arrayWithObjects:value3,  value0 ,nil];
        
        //缩放动画
        CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anima2.fromValue = [NSNumber numberWithFloat:1.0f];
        anima2.toValue = [NSNumber numberWithFloat:0.1f];
        
        //旋转动画
        CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anima3.toValue = [NSNumber numberWithFloat:M_PI];
        
        //组动画
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
        groupAnimation.duration = 3.3f;
        
        if ([item isEqual:self.arrayMTreeItems.lastObject ] ) {
            groupAnimation.delegate = self;  //只给最后一个设置代理，方便解决循环引用内存释放
        }
        // 动画匀速
        //    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
        
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.fillMode = kCAFillModeForwards;

        [item.layer addAnimation:groupAnimation forKey:@"groupAnimation_End"];
        item.center = item.DefaultPoint;//
        
    }

}

#pragma mark - -----------UI--------------
-(void)addTreeItemsWithArray:(NSArray*)arrayimages
{
    //初始化TreeItem
    if (self.arrayMTreeItems.count>0) {
        for (UIView *v in self.arrayMTreeItems) {
            [v removeFromSuperview];
        }
    }
    self.arrayMTreeItems = [NSMutableArray array];
    for (int  i = 0; i< arrayimages.count; ++i) {
        TreeItem *sub = [[TreeItem alloc] initWithFrame:CGRectZero];
       
        NSObject* ob = arrayimages[i];
        if ([ob isKindOfClass:[UIImage class]]) {
            [sub.treeBtn setBackgroundImage:(UIImage*)ob forState:UIControlStateNormal];
        }else if ([ob isKindOfClass:[NSString class]]){ //
            [sub.treeBtn setBackgroundImage:[UIImage imageNamed:arrayimages[i]] forState:UIControlStateNormal];
        }
        [self.arrayMTreeItems addObject:sub];
    }
    
    [self autoBuildTreeItesFrame];
}
-(void)autoBuildTreeItesFrame
{
        
        CGFloat Btn_X = Default_left_rightW;
        CGFloat Btn_WH = (SCR_W-Default_left_rightW*2-Default_button_V_W*(self.arrayMTreeItems.count-1))/self.arrayMTreeItems.count;
        CGFloat Btn_Y = SCR_H-49-Default_UnderButtonToTabbarBtnTopH-Btn_WH;
        
        for (int i= 0; i<self.arrayMTreeItems.count; ++i) {
            TreeItem *item = [self.arrayMTreeItems objectAtIndex:i];
//            item.tag = 10000+i;
            item.treeBtn.tag = 20000+i;
            
            CGRect sizeZeroFrame =  item.frame;
            sizeZeroFrame.size = CGSizeMake(Btn_WH, Btn_WH);
            item.frame = sizeZeroFrame;
            item.center = CGPointMake(SCR_W/2,SCR_H+Btn_WH/2);  //
            
            item.DefaultPoint = item.center; //初始化点
            //动画起点终点
            item.startPoint = CGPointMake(SCR_W/2.f, SCR_H-self.TabBarCopyBtn.frame.size.height);;
            item.endPoint = CGPointMake(Btn_X+Btn_WH/2, Btn_Y+Btn_WH/2);
            item.nearPoint = CGPointMake(Btn_X+Btn_WH/2, Btn_Y+Btn_WH/2);
            item.farPoint = CGPointMake(Btn_X+Btn_WH/2, Btn_Y+Btn_WH/2);
            
            Btn_X += Btn_WH+Default_button_V_W;
            //奇偶中心对称处理
            if (self.arrayMTreeItems.count%2 == 0) {
                if (i == self.arrayMTreeItems.count/2-1) {
                    
                }else if (i<self.arrayMTreeItems.count/2){
                    Btn_Y -= Default_button_H_H;
                }else{
                    Btn_Y += Default_button_H_H;
                }
            }else{
                if (i<self.arrayMTreeItems.count/2) {
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
        
    [self bringSubviewToFront:self.TabBarbackgroundView];
    
}
#pragma mark - 代理方法
-(void)ClickTreeItmBtn:(UIButton*)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(jl_TreeItems:treeItemClickNSInteger:)]){
        [self.delegate jl_TreeItems:(TreeItem*)sender.superview treeItemClickNSInteger:sender.tag-20000];
    }
    
}
#pragma mark - 覆盖相同按钮
-(void)buildTabBarCopyBtnWithTabBarC:(UITabBarController*)tabC
{
    CGFloat www = 10000;
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
        
        UIControl *tabBarButton = tabbarbuttonArray.lastObject;
        self.TabBarCopyBtn = [[UIButton alloc] initWithFrame:tabBarButton.frame];
        [self.TabBarbackgroundView addSubview:self.TabBarCopyBtn];
        [self.TabBarCopyBtn addTarget:self action:@selector(clickTabBarCopyBtn:) forControlEvents:UIControlEventTouchUpInside];

        self.TabBarCopyBtn.backgroundColor = [UIColor whiteColor];
        
        
        for (UIView *imageView in tabBarButton.subviews) {
            if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                self.imageViewCopy = [[UIImageView alloc] initWithFrame:imageView.frame];
                [self.TabBarCopyBtn addSubview:self.imageViewCopy];
                self.imageViewCopy.image = [[UIImage imageNamed:@"toolbar_+"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            }
        }
        
//        UIControl* tabBarButton = tabbarbuttonArray.lastObject;
//        NSLog(@"%f--->%@",SCR_W,NSStringFromCGRect(tabBarButton.frame));
//可以给他添加点击方法
//        [tabBarButton addTarget:self action:@selector(autoShowWihtBo:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
-(void)clickTabBarCopyBtn:(UIButton*)sender
{
    [self expend:sender.selected];
    [self expendTabBarCopyRotation:sender.selected];
    
    sender.selected = !sender.selected;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H-49)];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.35;
        [self addSubview: self.backgroundView];
        self.TabBarbackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,SCR_H-49, SCR_W,49)];
//        self.TabBarbackgroundView.backgroundColor = [UIColor whiteColor];

        [self addSubview: self.TabBarbackgroundView];
        
        self.backgroundView.userInteractionEnabled = NO;
        self.TabBarbackgroundView.userInteractionEnabled = YES;

    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder]) {
        self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H-49)];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.35;
        [self addSubview: self.backgroundView];
        self.TabBarbackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,SCR_H-49, SCR_W,49)];
//        self.TabBarbackgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview: self.TabBarbackgroundView];
        
        self.backgroundView.userInteractionEnabled = NO;
        self.TabBarbackgroundView.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"______");
    if (!self.isTouch) {
        [self expend:NO];
    }
}
@end
