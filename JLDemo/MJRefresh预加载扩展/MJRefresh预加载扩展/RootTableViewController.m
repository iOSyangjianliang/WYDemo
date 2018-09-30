//
//  RootTableViewController.m
//  MJRefresh预加载扩展
//
//  Created by 杨建亮 on 2018/9/4.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "RootTableViewController.h"

#import "MJRefresh.h"
#import "JLMJRefreshFooterPreload.h"

@interface RootTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *arrayDataSource;

@property(nonatomic, strong) NSMutableArray *arrayCurryPage;

@property(nonatomic, assign) NSInteger curryPage;

@end

//static  NSString const *identifier = @"identifier";
@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self setData];
    
    
    [self buildUI];
    
    
    [self requestData];

}
- (void)setData
{
    self.arrayDataSource = [NSMutableArray array];
    
    self.arrayCurryPage = [NSMutableArray array];
    
    _curryPage = 1;
}
- (void)buildUI
{
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Identifier"];
    self.tableView.rowHeight = 88;
  
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -44.f, 0);
    
    

    

}
-(void)requestData
{
    NSArray *arr =  [self getDataWithPage:1];
    self.arrayDataSource = [NSMutableArray arrayWithArray:arr];
    
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self footerWithRefreshing_1111];

            [self footerWithRefreshing];

    });
}
static int SinglePage = 15;//每页数据个数
- (NSArray *)getDataWithPage:(NSInteger)page
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i=1; i<=SinglePage; ++i) {
        NSString *title = [NSString stringWithFormat:@"这是第%ld条数据",SinglePage*(page-1)+i];
        [arrayM addObject:title];
    }
    
    _curryPage ++;
    return arrayM;
}
- (void)footerWithRefreshing
{
    __weak __typeof(&*self)weakSelf = self;
    JLMJRefreshFooterPreload *re = [[JLMJRefreshFooterPreload alloc] initWithScrollerView:self.tableView];
    [re footerWithRequestBlock:^{
        
        [re endRefreshing_setReloadHeight];

        NSArray *arr = [weakSelf getDataWithPage:weakSelf.curryPage];
        weakSelf.arrayCurryPage = [NSMutableArray arrayWithArray:arr];
        
        NSLog(@"AAA请求数据");
        
    } reload:^{
        [re endRefreshing_setRequestHeight];

        
//
        [weakSelf.arrayDataSource addObjectsFromArray:weakSelf.arrayCurryPage];
        [weakSelf.tableView reloadData];
        NSLog(@"刷新数据BBB");
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [re endRefreshing_setRequestHeight];
//            [self stopProductCollectionView];

            
//            [weakSelf.arrayDataSource addObjectsFromArray:weakSelf.arrayCurryPage];
//            [weakSelf.tableView reloadData];
//            NSLog(@"刷新数据成功BBB");
        });
        
        
    }];
    
    re.requestDataHeight = 88*7;
    re.reloadDataHeight  = 88*3;


}
//立即停止滚动）
-(void)stopProductCollectionView
{
    CGPoint offset = self.tableView.contentOffset;
    (self.tableView.contentOffset.y > 0) ? offset.y-- : offset.y++;
    [self.tableView setContentOffset:offset animated:NO];
}
- (void)footerWithRefreshing_1111
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestPageNumAdd_1)];

//控制底部控件(默认高度44)出现百分比(0.0-1.0,默认1.0)来预加载，此处设置表示距离底部上拉控件顶部5*44高度即提前加载数据
    footer.triggerAutomaticallyRefreshPercent = -2*5; //2*44

    footer.stateLabel.font = [UIFont systemFontOfSize:12.5];
    self.tableView.mj_footer = footer;

}
-(void)requestPageNumAdd_1
{
    NSArray *arr = [self getDataWithPage:self.curryPage];
    [self.arrayDataSource addObjectsFromArray:arr];
    [self.tableView reloadData];
    
    NSLog(@"刷新数据");
    [self.tableView.mj_footer endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.arrayDataSource[indexPath.row];
    return cell;
}

-(void)dealloc
{
    NSLog(@"dealloc Success");
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
