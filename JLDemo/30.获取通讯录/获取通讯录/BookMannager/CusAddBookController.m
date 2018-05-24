//
//  CusAddBookController.m
//  YiShangbao
//
//  Created by 杨建亮 on 2018/1/8.
//  Copyright © 2018年 com.Microants. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

#import "CusAddBookController.h"
#import "SMCustomerModel.h"
#import "SMAddCustomerCell.h"

#import "WYPinYin.h"

@interface CusAddBookController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *AllSelectBtn;

@property(nonatomic,strong)NSMutableArray *addBookArrayM;
@property(nonatomic,strong)NSMutableArray *indexTitleArrayM;
@end

static NSString *cellReuse_SMAddCustomerCell = @"SMAddCustomerCell";
@implementation CusAddBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [WYUISTYLE colorF3F3F3];
    self.navigationItem.title = @"从通讯录导入";
    
    [self buildUI];
    
    [self requestAuthorizationForAddressBook];
    
}
#pragma mark - 导入数据
-(void)requestImportData
{
    NSArray *indexPathArr = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i=0; i<indexPathArr.count; ++i) {
        NSIndexPath *indexpath = indexPathArr[i];
        SMCusArrdessBookModel *smcModel = _addBookArrayM[indexpath.item];
        [arrayM addObject:smcModel];
    }
    NSArray * parm = [MTLJSONAdapter JSONArrayFromModels:arrayM error:nil];
    NSString *json = [NSString zhGetJSONSerializationStringFromObject:parm];
    [MBProgressHUD zx_showLoadingWithStatus:nil toView:self.view];
    [[[AppAPIHelper shareInstance] getMakeBillAPI] postkBillBatchNewCustomerInfoArr:json success:^(id data) {
        [self.navigationController popViewControllerAnimated:NO];
        [MBProgressHUD zx_showSuccess:@"导入成功"  toView:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD zx_showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)buildUI
{
    _AllSelectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_AllSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
    [_AllSelectBtn setTitle:@"取消" forState:UIControlStateSelected];
    _AllSelectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _AllSelectBtn.userInteractionEnabled = NO; //_AllSelectBtn.enabled = NO没效果
    [_AllSelectBtn setTitleColor:[WYUISTYLE colorWithHexString:@"#FF5434"] forState:UIControlStateNormal];
    [_AllSelectBtn addTarget:self action:@selector(clickAllSelect:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_AllSelectBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.rowHeight = 40;
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = 60.f;
    self.tableView.contentInset = inset;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.sectionIndexColor = [WYUISTYLE colorWithHexString:@"#FF5434"]; //右侧索引
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SMAddCustomerCell" bundle:nil] forCellReuseIdentifier:cellReuse_SMAddCustomerCell];
    
    UIView *bottonView = [[UIView alloc] initWithFrame:CGRectMake(0, LCDH-60-HEIGHT_TABBAR_SAFE, LCDW, 60+HEIGHT_TABBAR_SAFE)]; //iphoneX
    bottonView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:bottonView];
    UIButton *importBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 7.5, LCDW-30, 45)];
    [importBtn setBackgroundImage:[WYUISTYLE imageWithStartColorHexString:@"#FD7953" EndColorHexString:@"#FE5147"  WithSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [importBtn setTitle:@"导入" forState:UIControlStateNormal];
    importBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    importBtn.layer.masksToBounds = YES;
    importBtn.layer.cornerRadius = 22.5;
    [importBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [importBtn addTarget:self action:@selector(clickImport:) forControlEvents:UIControlEventTouchUpInside];
    [bottonView addSubview:importBtn];
}
-(void)clickAllSelect:(UIButton*)sender
{
    sender.userInteractionEnabled = NO;//大量数据耗时操作需控制
    for (int i=0; i<_addBookArrayM.count; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        if (!sender.selected) {
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }else{
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }
    sender.userInteractionEnabled = YES;
    sender.selected = !sender.selected;
}
-(void)clickImport:(UIButton*)sender
{
    NSArray *indexPathArr = [self.tableView indexPathsForSelectedRows];
    if (indexPathArr.count>0) {
        [self requestImportData];
    }else{
        [MBProgressHUD zx_showError:@"请选择联系人" toView:self.view];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addBookArrayM.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMAddCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuse_SMAddCustomerCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SMCusArrdessBookModel *model = self.addBookArrayM[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.phoneLabel.text = model.phone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSArray *indexPathArr = [self.tableView indexPathsForSelectedRows];
    if (indexPathArr.count == _addBookArrayM.count) {
        _AllSelectBtn.selected  = YES;
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *indexPathArr = [self.tableView indexPathsForSelectedRows];
    if (indexPathArr.count == 0) {
        _AllSelectBtn.selected  = NO;
    }
}
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView.indexPathsForVisibleRows.count>=self.addBookArrayM.count) { //数据不足不展示,visibleCells在iOS8读取为nil
        return nil;
    }
    return _indexTitleArrayM;
}

#pragma mark 索引列点击事件
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger indexxx = [self getIndexByTitle:title];
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexxx inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [MBProgressHUD zx_showSuccess:title toView:self.view];
    return index;
}
-(NSInteger)getIndexByTitle:(NSString *)title
{
    for (int i=0; i<_addBookArrayM.count; ++i) {
        SMCusArrdessBookModel *smcModel = _addBookArrayM[i];
        if (smcModel.pinyin.length>0) {
            if ([smcModel.pinyin isEqualToString:@"[]"]) {
                return i;
            }else{
                NSString *indexTitle = [smcModel.pinyin substringToIndex:1];
                if ([indexTitle isEqualToString:title]) {
                    return i;
                }
            }
            
        }
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestAuthorizationForAddressBook
{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0){
        CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus == CNAuthorizationStatusNotDetermined) { //首次授权
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {//当前不在主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) { // 获取权限提醒只会在第一次使用的时候出现，获取权限之后可马上遍历通讯录
                        [self getAddressbookData_afterIOS9];
                    } else {
                        [MBProgressHUD zx_showError:[error localizedDescription] toView:self.view];
                    }
                });
            }];
        }
        else if (authorizationStatus == CNAuthorizationStatusAuthorized) {
            [self getAddressbookData_afterIOS9];
        }else{
            [UIAlertController zx_presentGeneralAlertInViewController:self withTitle:@"需要打开通讯录权限" message:nil cancelButtonTitle:@"取消" cancleHandler:nil doButtonTitle:@"去设置" doHandler:^(UIAlertAction * _Nonnull action) {
                NSURL *openUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication]respondsToSelector:@selector(openURL:options:completionHandler:)])
                {
                    [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:nil];
                }
                else
                {
                    [[UIApplication sharedApplication] openURL:openUrl];
                }
            }];
        }
    }else
    {
        ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
        if (authorizationStatus == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        [self getAddressBookData_beforeIOS9];
                    } else {
                        [MBProgressHUD zx_showError:@"需要打开您的通讯录权限" toView:self.view];
                    }
                });
            });
        }
        else if (authorizationStatus == kABAuthorizationStatusAuthorized){
            [self  getAddressBookData_beforeIOS9];
        }else{
            [UIAlertController zx_presentGeneralAlertInViewController:self withTitle:@"需要打开通讯录权限" message:nil cancelButtonTitle:@"取消" cancleHandler:nil doButtonTitle:@"去设置" doHandler:^(UIAlertAction * _Nonnull action) {
                NSURL *openUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:openUrl];
            }];
        }
    }
}

#pragma mark - ios 9 before
-(void)getAddressBookData_beforeIOS9
{
    self.addBookArrayM = [[NSMutableArray alloc]init];

    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
    for(int i = 0; i < CFArrayGetCount(peopleArray); i++){
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        NSString *firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSString *lastName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int j = 0; j < ABMultiValueGetCount(phones); j++){
            NSString *phoneNumber = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j);
            
            NSString *lastNameSafe = lastName?lastName:@"";
            NSString *firstNameSafe = firstName?firstName:@"";
            NSString *completeName =  [NSString stringWithFormat:@"%@%@",lastNameSafe,firstNameSafe];
            if (![completeName isEqualToString:@""]) {
                SMCusArrdessBookModel *smcModel = [[SMCusArrdessBookModel alloc] init];
                NSString *NAME = completeName.length>=20?[completeName substringToIndex:20]:completeName; //20
                smcModel.name = NAME;
                NSString *pinyin = [WYFirstLetter firstLetters:completeName];
                pinyin =  [pinyin hasPrefix:@"#"]?@"[]":pinyin;//#的ASCII码比字母对应ASCII码小,换个比字母大的ASCII码[方便排序最后
                smcModel.pinyin = [pinyin uppercaseString];
                NSString *phone = [NSString stringWithFormat:@"%@",phoneNumber];
                smcModel.phone = [self getPhoneNumber:phone];
                [self.addBookArrayM addObject:smcModel];
            }
           
        }
    }
    [self sortArrayData];
}
#pragma mark - ios 9 later
- (void)getAddressbookData_afterIOS9
{
    self.addBookArrayM = [[NSMutableArray alloc]init];
    
    NSArray *keysToFetch = @[CNContactGivenNameKey,CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSString *familyName = contact.familyName;
        NSString *givenName = contact.givenName;
        NSArray *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phoneNumbers) {
            CNPhoneNumber *phoneNumber = labelValue.value;
            
            NSString *familyNameSafe = familyName?familyName:@"";
            NSString *givenNameSafe = givenName?givenName:@"";
            NSString *completeName = [NSString stringWithFormat:@"%@%@",familyNameSafe,givenNameSafe];
            if (![completeName isEqualToString:@""]) {
                SMCusArrdessBookModel *smcModel = [[SMCusArrdessBookModel alloc] init];
                NSString *pinyin = [WYFirstLetter firstLetters:completeName];
                pinyin =  [pinyin hasPrefix:@"#"]?@"[]":pinyin; //#的ASCII码比字母对应ASCII码小,换个比字母大的ASCII码[方便排序最后
                NSString *NAME = completeName.length>=20?[completeName substringToIndex:20]:completeName;
                smcModel.name = NAME;
                smcModel.pinyin = [pinyin uppercaseString];
                NSString *phone = [NSString stringWithFormat:@"%@",phoneNumber.stringValue];
                smcModel.phone = [self getPhoneNumber:phone];
                [self.addBookArrayM addObject:smcModel];
            }
            
        }
    }];
    [self sortArrayData];
}
#pragma mark 只读取通讯录所有数字
-(NSString *)getPhoneNumber:(NSString *)phone
{
    NSString *pureNumbers = [[phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    return pureNumbers;
}
-(void)sortArrayData
{
    for (int i=0; i<_addBookArrayM.count; ++i) {
        for (int j=0; j<_addBookArrayM.count-1; ++j) {
            SMCusArrdessBookModel *smcModel_j = _addBookArrayM[j];
            NSString *pinyin_j = smcModel_j.pinyin;
            
            SMCusArrdessBookModel *smcModel_jj = _addBookArrayM[j+1];
            NSString *pinyin_jj = smcModel_jj.pinyin;
            NSComparisonResult restlt = [pinyin_j compare:pinyin_jj];
            if (restlt == NSOrderedDescending ) { //左边大
                [_addBookArrayM exchangeObjectAtIndex:j+1 withObjectAtIndex:j];
            }
        }
    }
    self.indexTitleArrayM = [NSMutableArray array]; //初始化检索数据
    for (int i=0; i<_addBookArrayM.count; ++i) {
        SMCusArrdessBookModel *smcModel = _addBookArrayM[i];
        if (smcModel.pinyin.length>0) {
            if ([smcModel.pinyin isEqualToString:@"[]"]) {
                if (![self isExisting:_indexTitleArrayM Title:@"#"]) {
                    [_indexTitleArrayM addObject:@"#"];
                }
            }else{
                NSString *indexTi = [smcModel.pinyin substringToIndex:1];
                if (![self isExisting:_indexTitleArrayM Title:indexTi]) {
                    [_indexTitleArrayM addObject:indexTi];
                }
            }
        }
    }
    [self.tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        _AllSelectBtn.userInteractionEnabled = YES; //刷新完成后
    });

    NSLog(@"_addBookArrayM==== %@",_addBookArrayM);
}
-(BOOL)isExisting:(NSArray*)arr Title:(NSString*)title
{
    NSArray *indexTitleArr = [NSArray arrayWithArray:arr];
    for (int i=0; i<indexTitleArr.count; ++i) {
        NSString *str = indexTitleArr[i];
        if ([title isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
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
