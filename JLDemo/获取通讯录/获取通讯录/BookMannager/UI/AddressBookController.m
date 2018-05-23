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

#import "UIView+Log.h"

@interface AddressBookController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;

@property(nonatomic,strong)NSArray *addBooksArray;
@property(nonatomic,strong)NSArray *indexTitleArray;

@property(nonatomic,assign)NSInteger lastInteger;
@property(nonatomic,assign)NSInteger lastMinY;

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
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.rowHeight = 40;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.sectionIndexColor = [UIColor colorWithRed:60/255.f green:160/255.f blue:255/255.f alpha:1]; //右侧索引色
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressBookTableCell" bundle:nil] forCellReuseIdentifier:cellReuse_AddressBookTableCell];
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
//    [MBProgressHUD zx_showSuccess:title toView:self.view];
    
    
    //eg: CGPoint P2 = [A convertPoint:P1 toView:B];
    //A:被转坐标系的视图
    //B:要转到的指定视图
    //P1:A上的点坐标
    //P2:转到B上后的点坐标
    
    [UIView zhNSLogSubviewsFromView:self.tableView andLevel:0];
    NSLog(@"\n====");
    return index;
}

- (void)showView
{
    NSArray *arr = [self.tableView indexPathsForVisibleRows];
    
    for (int i=0; i<arr.count; ++i) {
        NSIndexPath *indexPath = arr[i];
        UITableViewHeaderFooterView *view = [self.tableView headerViewForSection:indexPath.section];

        if (i==0) {
            CGFloat minY = CGRectGetMinY(view.frame);

            BOOL bo = minY == self.lastMinY && indexPath.section==self.lastInteger;

            NSLog(@"\n===============\n");

            NSLog(@"======%ld",indexPath.section);
            NSLog(@"%f==%f",minY, self.tableView.contentOffset.y);
            
            NSLog(@"\n===============\n");

            self.lastInteger = indexPath.section;
            self.lastMinY = minY;
            
//            if (bo) {
                view.textLabel.textColor = [UIColor colorWithRed:60/255.f green:160/255.f blue:255/255.f alpha:1]; //右侧索引色
//            }
        }else{

//            [view.textLabel setTextColor:[UIColor colorWithRed:47/255.f green:47/255.f blue:47/255.f alpha:1]];
        }
       

    }
   
    
//    CGPoint Point = [view convertPoint:CGPointMake(0, CGRectGetMinY(view.frame)) toView:self.view];
//    NSLog(@"666==%@",NSStringFromCGPoint(self.tableView.contentOffset));
//
//    if (Point.y == CGRectGetMinY(self.tableView.frame)-self.tableView.contentOffset.y) {
//        view.textLabel.textColor = [UIColor colorWithRed:255/255.f green:84/255.f blue:52/255.f alpha:1];
//    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self showView];
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
