//
//  AddressBookData.h
//  navidog4x
//
//  Created by feifei on 13-1-9.
//
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface AddressBookData : NSObject

+(void)AddressBookCreateAndGetData;      //创建通讯录

//pString   原本字符串       pSubString 子字符串     返回截取后的字符串
+(NSString*)SetAddressBookString:(NSString*)pString subString:(NSString*)pSubString;   //截取字符串

@end
