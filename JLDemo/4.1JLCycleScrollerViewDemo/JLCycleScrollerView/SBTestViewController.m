//
//  SBTestViewController.m
//  JLCycleScrollerView
//
//  Created by 杨建亮 on 2017/8/2.
//  Copyright © 2017年 杨建亮. All rights reserved.
//

#import "SBTestViewController.h"
#import "JLLunBoView.h"

#import "JLCycleScrollerView.h"
@interface SBTestViewController ()<JLLunBoViewDatasource>
@property (weak, nonatomic) IBOutlet JLLunBoView *jllunboView;


@property (strong, nonatomic) JLLunBoView *ShoudongjllunboView;

@end

@implementation SBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.automaticallyAdjustsScrollViewInsets = NO;
   
    //由于当controller上的第一个子视图是scrollview以及其子类(tableView，collectionView)的时候，就会自动设置相应的内边距偏移，导致cell向下偏移一定像素，所有当cell发生偏移时，要么在添加scrollview类之前添加一个其他控件，要么self.automaticallyAdjustsScrollViewInsets = NO;关闭自动偏移
    NSArray* array = @[@"1",@"2",@"3"];

//    [self.jllunboView setData:array datasource:self];
//    self.jllunboView.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.jllunboView.datasource  = self;
    [self.jllunboView reloadDataWithArray:array];
    [self.jllunboView resumeTimerAfterDuration:0];

}
-(id)jl_LunBoCollectionViewCell:(JLLunBoCollectionViewCell *)lunboCollectionViewCell cellForItemAtInteger:(NSInteger)integer sourceArray:(NSArray *)sourceArray
{
    return [NSString stringWithFormat:@"%@.jpg", sourceArray[integer]];
}

- (IBAction)reloadclick:(id)sender {
    
    NSArray* array = @[@"1",@"2",@"3",@"4",@"5"];
    self.jllunboView.scrollDirection = UICollectionViewScrollDirectionVertical;

    [self.jllunboView reloadDataWithArray:array];
}

- (IBAction)removeClick:(id)sender {
    
    [self.jllunboView removeFromSuperview];
    
    if (self.jllunboView) {
        NSLog(@"还没立即销毁");
    }
}




//
- (IBAction)shoudongadd:(id)sender {
    self.ShoudongjllunboView = [[JLLunBoView alloc] initWithFrame:CGRectMake(30, 400, self.view.frame.size.width-60, 80)];
    NSArray* array = @[@"1",@"2"];
    [self.ShoudongjllunboView setData:array datasource:self];
    [self.view addSubview:self.ShoudongjllunboView];
}
- (IBAction)shoudongreload:(id)sender {
    NSArray* array = @[@"1",@"2",@"3",@"4",@"5"];
    
    [self.ShoudongjllunboView reloadDataWithArray:array];

}
- (IBAction)shoudongremove:(id)sender {
    [self.ShoudongjllunboView removeFromSuperview];
    
    if (self.ShoudongjllunboView) {
        NSLog(@"点击创建的还没立即销毁");
    }
}




-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
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
