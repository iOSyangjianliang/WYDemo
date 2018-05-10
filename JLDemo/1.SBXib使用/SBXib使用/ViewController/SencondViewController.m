//
//  SencondViewController.m
//  SBXib使用
//
//  Created by 杨建亮 on 2017/8/15.
//  Copyright © 2017年 海狮. All rights reserved.
//

#import "SencondViewController.h"

#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "MainViewController.h"

#import "ThirdTableViewCell.h"


@interface SencondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)FirstTableViewCell *First;


@end

@implementation SencondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    //直接SB上注册
//    [self.tableview registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"FIRST"];
//    [self.tableview registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"SECOND"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"ThirdTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellThird"];
    
    //Cell动态高度
    self.First =  [self.tableview dequeueReusableCellWithIdentifier:@"FIRST"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CGFloat H = [self.First getCellHeightWithData:nil]; 
        return H;
    }
    return 200;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FirstTableViewCell * cell_one = [tableView dequeueReusableCellWithIdentifier:@"FIRST"];
        
        return cell_one;
    }else if (indexPath.row ==1){
        SecondTableViewCell * cell_two = [tableView dequeueReusableCellWithIdentifier:@"SECOND"];
        return cell_two;
    }else{
        ThirdTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellThird"];
        
        return cell;
    }
}





- (IBAction)clickbtn:(id)sender {
    //
    [self performSegueWithIdentifier:@"GuanggaoViewControllerID" sender:self];
}

#pragma mark - Navigation
//StoryBoard传值
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


    UIViewController *viewController= segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"GuanggaoViewControllerID"])
    {
        MainViewController* vc = (MainViewController*)viewController;
        vc.isbo = YES;
        
        [viewController setValue:@"KVC赋值hello word!" forKey:@"ssssss"];
        
    }
}


@end

