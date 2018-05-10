//
//  ViewController.m
//  Masory使用Demo
//
//  Created by 杨建亮 on 2017/8/15.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property(nonatomic,strong)UILabel *blueView;
@property(nonatomic,strong)UIView *redColor;
@property(nonatomic,strong)UIView *purpleColor;

@property(nonatomic,strong)UIView *Line;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubViews];
    
    [self addMasory];
    
    
}
-(void)addMasory
{
    //1.添加约束必须在addSubview之后执行
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-50); //右，下需要使用负数，父视图左上角坐标为(0,0)
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
       
        make.left.greaterThanOrEqualTo(self.view).offset(15);
        make.height.equalTo(@100);
       
// 推荐mas_equalTo，它可以使用用基本数据类型或者结构体来创建约束:
//        make.height.mas_equalTo(100);
//        make.left.mas_greaterThanOrEqualTo(self.view).offset(15);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 10, 0));

    }];

}
-(void)addSubViews
{
    _blueView = [[UILabel alloc] init];
//     _blueView.text = @"大胆的说大师的label";
    _blueView.text = @"大胆的说大师的label大胆的说大师的label大胆的说大师的label大胆的说大师的label大胆的说大师的label大胆的说大师的label大胆的说大师的label";
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_blueView];
    
    _redColor = [[UIView alloc] init];
    _redColor.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redColor];
    
    
    _purpleColor = [[UIView alloc] init];
    _purpleColor.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_purpleColor];
    
    
    _Line = [[UIView alloc] init];
    _Line.backgroundColor = [UIColor redColor];
    [self.view addSubview:_Line];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
