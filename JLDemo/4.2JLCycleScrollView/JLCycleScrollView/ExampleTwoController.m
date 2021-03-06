//
//  ExampleTwoController.m
//  JLCycleScrollView
//
//  Created by 杨建亮 on 2017/12/7.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "ExampleTwoController.h"

#import "JLCycleScrollerView.h"
#import "JLCycScrCustomCell.h"
#import "ExampleModel.h"

@interface ExampleTwoController ()<JLCycleScrollerViewDatasource,JLCycleScrollerViewDelegate>
@property (weak, nonatomic) IBOutlet JLCycleScrollerView *firstJLView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstright;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLeft;


@property(nonatomic,strong)NSMutableArray *arrayData;
@end

@implementation ExampleTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *array =  @[
                        @"http://public-read-bkt.microants.cn/app/market/face/f_m1.png",
                        @"http://public-read-bkt.microants.cn/app/market/face/f_m2.png",
                        @"http://public-read-bkt.microants.cn/app/market/face/f_m3.png",
                        @"http://public-read-bkt.microants.cn/app/market/face/f_m4.png",
                        @"http://public-read-bkt.microants.cn/app/market/face/f_m5.png",
                        
                        ];
    //NSArray<ExampleModel *>
    self.arrayData = [NSMutableArray array];
    for (int i=0; i<array.count; ++i) {
        ExampleModel *model = [[ExampleModel alloc] init];
        model.url = array[i];
        model.title = array[i];
        [self.arrayData addObject:model];
    }
   
    self.firstJLView.datasource = self;
     self.firstJLView.delegate = self;
    self.firstJLView.sourceArray = @[self.arrayData.firstObject];
    
    self.firstJLView.pageControl.pageIndicatorTintColor = [UIColor purpleColor];
    self.firstJLView.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
//    self.firstJLView.pageControl.jl_norImage = [UIImage imageNamed:@"nor"];
//    self.firstJLView.pageControl.jl_selImage = [UIImage imageNamed:@"sel"];
//    self.firstJLView.pageControl.allowChangeFrame = YES;
}
- (IBAction)firstClcik:(id)sender {
//    self.firstheight.constant = 350;
//    self.firstLeft.constant = 35;
//    self.firstright.constant = 35;
    self.firstJLView.sourceArray = self.arrayData;
}
- (IBAction)secondClick:(id)sender {
    self.firstJLView.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.firstJLView.scrollEnabled = NO;
    
    self.firstJLView.pageControl.jl_selDotSize = CGSizeMake(14, 14);
    self.firstJLView.pageControl.jl_norDotSize = CGSizeMake(14, 14);
    self.firstJLView.pageControl.jl_norMagrin = 6;
    self.firstJLView.pageControl.jl_selMagrin = 6;
    self.firstJLView.pageControl.jl_selDotCornerRadius = 0;
    self.firstJLView.pageControl.jl_norDotCornerRadius = 0;
    self.firstJLView.pageControl.allowChangeFrame = YES;

    self.firstJLView.pageControl_botton = 25;
    self.firstJLView.pageControl_right = 25;
//    self.firstJLView.pageControl_centerX = -10;

    self.firstJLView.sourceArray = self.arrayData;
    
    self.firstJLView.pageControlNeed = YES;

    
}
- (IBAction)threeClcik:(id)sender {
    self.firstheight.constant = 350;
    self.firstLeft.constant = 35;
    self.firstright.constant = 35;
    
    self.firstJLView.cellsOfLine = 5;
    [self.firstJLView useCustomCell:[JLCycScrCustomCell new] isXibBuild:YES];//cell协议赋值;使用自定义cell的话self.firstJLView.datasource = self; 这个不再需要设置，设置了也没什么用
    
    self.firstJLView.pageControl_centerY = 0;
    self.firstJLView.pageControl_centerX = 0;
    
    self.firstJLView.pageControlNeed = NO;

}

//使用系统cell才需要
-(id)jl_cycleScrollerView:(JLCycleScrollerView *)view defaultCell:(JLCycScrollDefaultCell *)cell cellForItemAtInteger:(NSInteger)integer sourceArray:(NSArray *)sourceArray
{
//    id 类型支持NSString、NSURL、UIImage
    ExampleModel *model = sourceArray[integer];
    return model.url;
}
-(void)jl_cycleScrollerView:(JLCycleScrollerView *)view didSelectItemAtInteger:(NSInteger)integer sourceArray:(NSArray *)sourceArray
{
    NSLog(@"%ld",integer);
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
