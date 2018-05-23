//
//  AddressBookModel.h
//  获取通讯录
//
//  Created by 杨建亮 on 2018/5/23.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *pinyin;
@end

@interface AddressBookMainModel : NSObject
@property(nonatomic,strong)NSMutableArray *addressBook;
@property(nonatomic,strong)NSMutableArray *indexTitleArrayM;
@property(nonatomic,strong)NSMutableArray *addressBookGroupe;
@end
