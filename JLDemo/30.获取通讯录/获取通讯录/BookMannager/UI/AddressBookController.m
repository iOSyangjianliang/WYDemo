//
//  AddressBookController.m
//  获取通讯录
//
//  Created by 杨建亮 on 2018/5/23.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "AddressBookController.h"
#import "AddressBookTableCell.h"
#import "AddressBookManager.h"

@interface AddressBookController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)UILabel *indexLabel;

@property(nonatomic,strong)NSArray *addBooksArray;
@property(nonatomic,strong)NSArray *indexTitleArray;


@property(nonatomic,strong)NSMutableArray *indexTitleFrameArrayM;

@end
static NSString *cellReuse_AddressBookTableCell = @"AddressBookTableCell";
@implementation AddressBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"通讯录";
    
    [self buildUI];
    
    [self requestData];
    
}
-(void)requestData
{
    [[AddressBookManager shareInstance] requestAuthorizationForAddressBook:^(AddressBookMainModel *model) {
        self.addBooksArray = [NSArray arrayWithArray:model.addressBookGroupe];
        self.indexTitleArray = [NSArray arrayWithArray:model.indexTitleArrayM];
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        NSLog(@"%@",message);
    }];
}

-(void)buildUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.rowHeight = 40;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.sectionIndexColor = [UIColor colorWithRed:60/255.f green:160/255.f blue:255/255.f alpha:1]; //右侧索引色
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressBookTableCell" bundle:nil] forCellReuseIdentifier:cellReuse_AddressBookTableCell];
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior  = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.indexTitleFrameArrayM = [NSMutableArray array];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.addBooksArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.addBooksArray[section];
    return array.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = _indexTitleArray[section];
    return title;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor=[UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1];
    header.textLabel.font = [UIFont systemFontOfSize:15];
    [header.textLabel setTextColor:[UIColor colorWithRed:47/255.f green:47/255.f blue:47/255.f alpha:1]];
    
    if (section ==self.indexTitleFrameArrayM.count) {
        NSNumber *minY = @(CGRectGetMinY(view.frame));
        [self.indexTitleFrameArrayM addObject:minY];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressBookTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuse_AddressBookTableCell forIndexPath:indexPath];
    AddressBookModel *model = self.addBooksArray[indexPath.section][indexPath.row];
    cell.nameLabel.text = model.name;
    cell.phoneLabel.text = model.phone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark 索引列
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _indexTitleArray;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self showIndexTitleView:title];
    return index;
}
- (void)showIndexTitleView:(NSString *)text
{
    if (self.indexLabel) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeIndexLabel) object:self];
        self.indexLabel.text = text;
        [self performSelector:@selector(removeIndexLabel) withObject:nil afterDelay:1.5];
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        label.layer.cornerRadius = 25.f;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor colorWithRed:47/255.f green:47/255.f blue:47/255.f alpha:0.55];
        label.textColor = [UIColor colorWithRed:60/255.f green:160/255.f blue:255/255.f alpha:1]; //右侧索引色
        label.textAlignment = NSTextAlignmentCenter;
        label.center = self.view.center;
        label.text = text;
        [self.indexLabel removeFromSuperview];
        self.indexLabel = label;
        [self.view addSubview:self.indexLabel];
    }
//    CGPoint point = [self.tableView.panGestureRecognizer locationInView:self.view];
//    NSLog(@"__%@__%@",text,NSStringFromCGPoint(point));
}
- (void)removeIndexLabel
{
    [self.indexLabel removeFromSuperview];
    self.indexLabel = nil;
}
- (void)showView
{
    NSLog(@"==\n%@",self.indexTitleFrameArrayM);
    NSLog(@"==%f" ,self.tableView.contentOffset.y);
    
    CGFloat contentOffsetY  = self.tableView.contentOffset.y;
    NSInteger section = 0;
    for (int i=0; i<self.indexTitleFrameArrayM.count-1; ++i) {
        NSNumber *minY = self.indexTitleFrameArrayM[i];
        NSNumber *minYY = self.indexTitleFrameArrayM[i+1];
        if (minY.floatValue <=contentOffsetY && contentOffsetY <= minYY.floatValue) {
            section = i;
            break;
        }
    }
    NSArray *arr = [self.tableView indexPathsForVisibleRows];
    for (int i=0; i<arr.count; ++i) {
        NSIndexPath *indexPath = arr[i];
        UITableViewHeaderFooterView *view = [self.tableView headerViewForSection:indexPath.section];
        if (indexPath.section == section) {
            view.textLabel.textColor = [UIColor colorWithRed:60/255.f green:160/255.f blue:255/255.f alpha:1]; //右侧索引色
        }else{
            [view.textLabel setTextColor:[UIColor colorWithRed:47/255.f green:47/255.f blue:47/255.f alpha:1]];

        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self showView];
    
//    CGPoint point = [self.tableView.panGestureRecognizer locationInView:self.view];
//    NSLog(@"___%@",NSStringFromCGPoint(point));
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
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
