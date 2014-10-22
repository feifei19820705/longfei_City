//
//  AddressBookData.m
//  navidog4x
//
//  Created by feifei on 13-1-9.
//
//

#import "AddressBookData.h"
#import "JSONKit.h"
#import "RegexKitLite.h"
#import "MainViewControllor.h"
#import "AppDelegate.h"

@implementation AddressBookData


+(void)AddressBookCreateAndGetData      //首先创建通讯录
{
    MainViewControllor* pViewControllor = [MainViewControllor ShareMainControllorInstance];
    NSMutableArray* pSaveDataArray = [[NSMutableArray alloc] init];
//    ABAddressBookRef addressBook = ABAddressBookCreate();
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    pViewControllor.accessGranted = YES;
    //ABAddressBookRef addressBook = NULL;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        
        // we're on iOS 6
        //NSLog(@"on iOS 6 or later, trying to grant access permission");
//        NSLog(@"dispatch_semaphore_create -- 1");
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            pViewControllor.accessGranted = granted;
            dispatch_semaphore_signal(sema);
//            NSLog(@"dispatch_semaphore_signal -- 2");
        });
//        NSLog(@"ABAddressBookRequestAccessWithCompletion -- 3");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        NSLog(@"dispatch_semaphore_wait -- 4");
        dispatch_release(sema);
    }
    
    if (pViewControllor.accessGranted)     //表示正确得到了通讯录的数据
    {
        CFArrayRef mresults = ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        CFMutableArrayRef results=CFArrayCreateMutableCopy(kCFAllocatorDefault,
                                                            CFArrayGetCount(mresults),
                                                            mresults);
        
        //将结果按照拼音排序，将结果放入mresults数组中
        CFArraySortValues(results,
                          CFRangeMake(0, CFArrayGetCount(mresults)),
                          (CFComparatorFunction) ABPersonComparePeopleByName,
                          (void*) ABPersonGetSortOrdering());

        for(int i = 0; i < CFArrayGetCount(results); i++)
        {
            ABRecordRef person = CFArrayGetValueAtIndex(results, i);

            //得到通讯录中每个联系人的全名
            NSString* abFullName = (NSString*)(ABRecordCopyCompositeName(person));
            NSString* pGetPhoneString = nil;
            //读取多个电话值
            ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
            int phoneNumber = ABMultiValueGetCount(phone);
            for (int k = 0; k < phoneNumber; k++)
            {
                //获取該Label下的电话值
                NSString* pTmepPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);

                NSString* temp = @"-";
                NSString* pPhoneTempString = [AddressBookData SetAddressBookString:pTmepPhone subString:temp];
                //NSLog(@"pPhoneTempString = %@",pPhoneTempString);
                
                
                
                temp = @" ";
                NSString* pPhoneString = [AddressBookData SetAddressBookString:pPhoneTempString subString:temp];
                //NSLog(@"pPhoneString = %@",pPhoneString);
                
                NSRange range = [abFullName rangeOfString:temp];
                if (range.length > 0)
                {
                    NSString* pNameString = [AddressBookData SetAddressBookString:abFullName subString:temp];
                    abFullName = pNameString;
                }
                
                temp = @"+86";
                pGetPhoneString = [AddressBookData SetAddressBookString:pPhoneString subString:temp];
                //NSLog(@"pGetPhoneString = %@",pGetPhoneString);
                
                if (!abFullName)     //如果没有名字则电话就是名字
                {
                    abFullName = pGetPhoneString;
                }

                
                //存储一条通讯录中的信息到字典中
                NSDictionary* ptempDir = [NSDictionary dictionaryWithObjectsAndKeys:abFullName, @"name",
                                          pGetPhoneString, @"phone",
                                          nil];
                
                //使用了正则表达式来判断是否是手机号，其中因为在RegexKitLite.h文件中有一个警告 因此注释掉了rkl_handleDelayedAssert 函数，rkl_handleDelayedAssert功能是Assert的功能
                NSString* MobileMatchStr = @"^1[3,5,8]\\d{9}$";
                if ([pGetPhoneString isMatchedByRegex:MobileMatchStr])
                {
                    //NSLog(@"********************符合的手机号 ====== %@",pGetPhoneString);
                    //电话符合标准才添加到数组中
                    [pSaveDataArray addObject:ptempDir];   
                }
                else
                {
                    //NSLog(@"不符合的手机号 ====== %@",pGetPhoneString);
                }
                //[pTmepPhone release];
            }
            //[abFullName release];
            //abFullName = nil;
            CFRelease(phone);
        }
        
        NSString* pAddressBook_String = [pSaveDataArray JSONString];
        //存储通讯录数据

        //存储完数据仓库后更新
//        NSUserDefaults* pUser = [NSUserDefaults standardUserDefaults];
//        BOOL bIsOpen = [pUser boolForKey:@"BIsOpenAddressBook"];
        
        AppDelegate* pApp = [UIApplication sharedApplication].delegate;
        if (!pApp._pSaveDataString) {
            pApp._pSaveDataString = [[NSString alloc] init];
        }
        pApp._pSaveDataString = pAddressBook_String;
        //NSLog(@"通讯录 ------------ \n %@",pApp._pSaveDataString);
        
        if (pSaveDataArray)
        {
            [pSaveDataArray removeAllObjects];
            [pSaveDataArray release];
        }
        
        CFRelease(mresults);
        CFRelease(results);
        CFRelease(addressBook);
    }
}


+(NSString*)SetAddressBookString:(NSString*)pString subString:(NSString*)pSubString   //截取字符串
{
    NSString* pNameStr = [NSString stringWithString:pString];
    NSString* pheadStr = nil;
    NSString* pBodyStr = nil;
    NSString* pEndStr = nil;
    NSString* personPhone = nil;
    
    int num = 0;
    if ([pSubString isEqualToString:@"+86"])
    {
        num = 3;
    }
    else
    {
        num = 1;
    }
    //获取該Label下的电话值
    NSRange range = [pString rangeOfString:pSubString];
    if (range.length > 0){
        pheadStr = [pString substringToIndex:(range.location)];
        
        pString = [pString substringFromIndex:(range.location + num)];
        range = [pString rangeOfString:pSubString];
        if (range.length > 0)
        {
            pBodyStr = [pString substringToIndex:(range.location)];
            pEndStr = [pString substringFromIndex:(range.location + 1)];
        }
        else
        {
            pBodyStr = pString;
        }
        
    }
    
    if (pheadStr != NULL && pBodyStr != NULL && pEndStr != NULL)
    {
        personPhone = [NSString stringWithFormat:@"%@%@%@",pheadStr,pBodyStr,pEndStr];
    }
    else if (pheadStr != NULL && pBodyStr != NULL && pEndStr == NULL)
    {
        personPhone = [NSString stringWithFormat:@"%@%@",pheadStr,pBodyStr];
    }
    else if (pheadStr != NULL && pBodyStr == NULL && pEndStr == NULL)
    {
        personPhone = [NSString stringWithFormat:@"%@",pheadStr];
    }
    else
    {
        personPhone = pNameStr;
    }
    

    return personPhone;

}




@end
