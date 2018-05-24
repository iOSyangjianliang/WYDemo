//
//  AddressBookManager.m
//  获取通讯录
//
//  Created by 杨建亮 on 2018/5/23.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

#import "AddressBookManager.h"

@interface AddressBookManager ()

@property(nonatomic, strong) NSMutableArray *addressBook;
@property(nonatomic, strong) NSMutableArray *addressBookGroupe;
@property(nonatomic, strong) NSMutableArray *indexTitleArrayM;
@end

static NSString *const authorizationFailureMessage = @"用户拒绝授权，读取通讯录失败";
@implementation AddressBookManager
+ (instancetype)shareInstance
{
    static id sharedHelper = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedHelper = [[AddressBookManager alloc] init];
    });
    return sharedHelper;
}
- (void)requestAuthorizationForAddressBook:(ABSuccessBlock)success failure:(ABFailureBlock)failure
{
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus == CNAuthorizationStatusNotDetermined) { //首次授权
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {//当前不在主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) { // 获取权限提醒只会在第一次使用的时候出现，获取权限之后可马上遍历通讯录
                        [self getAddressbookData_afterIOS9];
                        if (success) {
                            AddressBookMainModel *model = [[AddressBookMainModel alloc] init];
                            model.addressBook = self.addressBook;
                            model.addressBookGroupe = self.addressBookGroupe;
                            model.indexTitleArrayM = self.indexTitleArrayM;
                            success(model);
                        }
                    } else {
                        if (failure) {
                            failure(authorizationFailureMessage);
                        }
                    }
                });
            }];
        }
        else if (authorizationStatus == CNAuthorizationStatusAuthorized) {
            [self getAddressbookData_afterIOS9];
            if (success) {
                AddressBookMainModel *model = [[AddressBookMainModel alloc] init];
                model.addressBook = self.addressBook;
                model.addressBookGroupe = self.addressBookGroupe;
                model.indexTitleArrayM = self.indexTitleArrayM;
                success(model);
            }
        }else{
            [self showAlertController];
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
                        if (success) {
                            AddressBookMainModel *model = [[AddressBookMainModel alloc] init];
                            model.addressBook = self.addressBook;
                            model.addressBookGroupe = self.addressBookGroupe;
                            model.indexTitleArrayM = self.indexTitleArrayM;
                            success(model);
                        }
                    } else {
                        if (failure) {
                            failure(authorizationFailureMessage);
                        }
                    }
                });
            });
        }
        else if (authorizationStatus == kABAuthorizationStatusAuthorized){
            [self  getAddressBookData_beforeIOS9];
            if (success) {
                AddressBookMainModel *model = [[AddressBookMainModel alloc] init];
                model.addressBook = self.addressBook;
                model.addressBookGroupe = self.addressBookGroupe;
                model.indexTitleArrayM = self.indexTitleArrayM;
                success(model);
            }
        }else{
            [self showAlertController];
        }
    }
}
-(void)showAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"需要打开通讯录权限才能访问您的通讯录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *openUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:openUrl];
        }
    }];
    [alertController addAction:doAction];
    UIViewController *VC = [UIApplication sharedApplication].delegate.window.rootViewController;
    [VC presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - ios 9 before
-(void)getAddressBookData_beforeIOS9
{
    _addressBook = [[NSMutableArray alloc]init];
    
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
                AddressBookModel *smcModel = [[AddressBookModel alloc] init];
                NSString *NAME = completeName.length>=20?[completeName substringToIndex:20]:completeName; //20
                smcModel.name = NAME;
                NSString *pinyin = [WYFirstLetter firstLetters:completeName];
                pinyin =  [pinyin hasPrefix:@"#"]?@"[]":pinyin;//#的ASCII码比字母对应ASCII码小,换个比字母大的ASCII码[方便排序最后
                smcModel.pinyin = [pinyin uppercaseString];
                NSString *phone = [NSString stringWithFormat:@"%@",phoneNumber];
                smcModel.phone = [self getPhoneNumber:phone];
                [_addressBook addObject:smcModel];
            }
        }
    }
    [self sortArrayData];
    [self logAddressBookModel:YES];
}
#pragma mark - ios 9 later
- (void)getAddressbookData_afterIOS9
{
    _addressBook = [[NSMutableArray alloc]init];
    if (@available(iOS 9.0, *)) {

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
                    AddressBookModel *smcModel = [[AddressBookModel alloc] init];
                    NSString *pinyin = [WYFirstLetter firstLetters:completeName];
                    pinyin =  [pinyin hasPrefix:@"#"]?@"[]":pinyin; //#的ASCII码比字母对应ASCII码小,换个比字母大的ASCII码[方便排序最后
                    NSString *NAME = completeName.length>=20?[completeName substringToIndex:20]:completeName;
                    smcModel.name = NAME;
                    smcModel.pinyin = [pinyin uppercaseString];
                    NSString *phone = [NSString stringWithFormat:@"%@",phoneNumber.stringValue];
                    smcModel.phone = [self getPhoneNumber:phone];
                    [self.addressBook addObject:smcModel];
                }
            }
        }];
        [self sortArrayData];
    }
    [self logAddressBookModel:YES];
    
}
#pragma mark 只读取通讯录电话中所有数字(iOS8中+有157-8888-8888 +41449)
-(NSString *)getPhoneNumber:(NSString *)phone
{
    NSString *pureNumbers = [[phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    return pureNumbers;
}
-(void)sortArrayData
{
    //按姓氏首字母排序-不分组联系人数据@[model，model]
    for (int i=0; i<_addressBook.count; ++i) {
        for (int j=0; j<_addressBook.count-1; ++j) {
            AddressBookModel *smcModel_j = _addressBook[j];
            NSString *pinyin_j = smcModel_j.pinyin;
            
            AddressBookModel *smcModel_jj = _addressBook[j+1];
            NSString *pinyin_jj = smcModel_jj.pinyin;
            NSComparisonResult restlt = [pinyin_j compare:pinyin_jj];
            if (restlt == NSOrderedDescending ) { //左边大
                [_addressBook exchangeObjectAtIndex:j+1 withObjectAtIndex:j];
            }
        }
    }
    //初始化-分组联系人数据@[@[model],@[model]]
    _addressBookGroupe = [NSMutableArray array];
    NSMutableString *lastFirstChar = nil;
    NSMutableArray *arrGroup = [NSMutableArray array];
   
    //初始化-检索数据@[A,B,C,D,#]
    _indexTitleArrayM = [NSMutableArray array];
    
    for (int i=0; i<_addressBook.count; ++i) {
        AddressBookModel *smcModel = _addressBook[i];
        if (smcModel.pinyin.length>0) {
            if ([smcModel.pinyin isEqualToString:@"[]"]) {
                if (![self isExisting:_indexTitleArrayM Title:@"#"]) {
                    [_indexTitleArrayM addObject:@"#"];
                }
                
                NSString *indexTi = [smcModel.pinyin substringToIndex:1];
                if (![lastFirstChar isEqualToString:indexTi]) {
                    arrGroup = [NSMutableArray array];
                    [arrGroup addObject:smcModel];
                    [_addressBookGroupe addObject:arrGroup];
                    lastFirstChar = [indexTi copy];
                }else{
                    [arrGroup addObject:smcModel];
                }
            }else{
                NSString *indexTi = [smcModel.pinyin substringToIndex:1];
                
                if (![self isExisting:_indexTitleArrayM Title:indexTi]) {
                    [_indexTitleArrayM addObject:indexTi];
                }
                
                if (![lastFirstChar isEqualToString:indexTi]) {
                    arrGroup = [NSMutableArray array];
                    [arrGroup addObject:smcModel];
                    [_addressBookGroupe addObject:arrGroup];
                    lastFirstChar = [indexTi copy];
                }else{
                    [arrGroup addObject:smcModel];
                }
            }
        }
    }
    
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
-(void)logAddressBookModel:(BOOL )log
{
    if (log) {
        for (int j=0; j<_addressBook.count; ++j) {
            AddressBookModel *smcModel = _addressBook[j];
            NSLog(@"name=%@ phone=%@ pinyin=%@",smcModel.name,smcModel.phone,smcModel.pinyin);
        }
    }
}

@end
