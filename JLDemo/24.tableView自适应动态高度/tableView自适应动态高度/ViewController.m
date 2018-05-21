//
//  ViewController.m
//  tableView自适应动态高度
//
//  Created by 杨建亮 on 2018/5/7.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import "ViewController.h"
#import "AATableViewCell.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;


@end

static NSString *AATableViewCell_reuse = @"AATableViewCell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self buildUI];

}
-(void)buildUI
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.separatorColor = [UIColor redColor];
   
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AATableViewCell" bundle:nil] forCellReuseIdentifier:AATableViewCell_reuse];
    
    self.tableView.allowsSelectionDuringEditing = YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
static int m =0;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AATableViewCell_reuse forIndexPath:indexPath];
    
    cell.jltextView.sizeToFitHight = YES;
    if (indexPath.row==2) {
        cell.jltextView.minNumberOfLines = 3;
        
    }else{
        cell.jltextView.minNumberOfLines = 1;
    }
    cell.jltextView.maxNumberOfLines = 5;

    cell.textViewHeightLayout.constant = 100;
    [cell.jltextView addTextHeightDidChangeHandler:^(JLTextView *view, CGFloat textHeight) {
        
        if (indexPath.row==2) {
            cell.textViewHeightLayout.constant = textHeight;
            
            [cell sizeToFit];
            
//            [tableView reloadData];
    
            [tableView performBatchUpdates:^{
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            } completion:^(BOOL finished) {

            }];
        }
       
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
