//
//  AppDelegate.m
//  longfeiApp
//
//  Created by yangcf on 14-10-22.
//  Copyright (c) 2014年 yangcf. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"
#import "AddressBookData.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize pMainViewControllor;
@synthesize _pSaveDataString;
@synthesize nPhoneType = _nPhoneType;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AddressBookData AddressBookCreateAndGetData];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor clearColor];
    
    pMainViewControllor = [[MainViewControllor alloc] initWithNibName:@"MainViewControllor" bundle:nil];
    
    
    if (IOS_Greater_Or_Equal(__IOS_6_0))
        self.window.rootViewController = pMainViewControllor;
    else
        [self.window addSubview:pMainViewControllor.view];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
