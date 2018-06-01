//
//  AddressBookManager.h
//  获取通讯录
//
//  Created by 杨建亮 on 2018/5/23.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AddressBookModel.h"
#import "AddressBookPinYin.h"

typedef void(^ABSuccessBlock)(AddressBookMainModel *model);
typedef void(^ABFailureBlock)(NSString *message);
@interface AddressBookManager : NSObject
+ (instancetype)shareInstance;
- (void)requestAuthorizationForAddressBook:(ABSuccessBlock)success failure:(ABFailureBlock)failure;
@end
