//
//  AppDelegate.m
//  samplebarcode
//
//  Created by 彭书旗 on 16/4/23.
//  Copyright © 2016年 开聪电子. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


@synthesize myBle,myNet,myPos,myLabel,myQueue;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    myBle = [[BLEPrinting alloc] init];
    myBle.myOpenDelegate = self;
    myBle.myDisconnectDelegate = self;
    myNet = [[NETPrinting alloc] init];
    myNet.myOpenDelegate = self;
    myNet.myDisconnectDelegate = self;
    myPos = [[POSPrinting alloc] init];
    myLabel = [[LabelPrinting alloc] init];
    myQueue = dispatch_queue_create("BLEPrinting IO Queue", DISPATCH_QUEUE_SERIAL);
    
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

/**
 * BLEPrintingDelegate
 */

- (void) didBleOpen:(CBPeripheral *) peripheral
{
    // 更新状态栏
    // StatusBarNotification
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableString * str = [NSMutableString stringWithString:@"CONNECTED:"];
        [str appendString:peripheral.name];
        [JDStatusBarNotification showWithStatus:str];
    });
}

- (void) didBleDisconnect
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [JDStatusBarNotification showWithStatus:@"DISCONNECTED!!!" dismissAfter:2 styleName:JDStatusBarStyleWarning];
    });
}

/**
 * NETPrintingDelegate
 */
- (void)didNetOpen:(NSString *)ipAddress portNumber:(UInt32)portNumber
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableString * str = [NSMutableString stringWithString:@"CONNECTED:"];
        [str appendString:ipAddress];
        [JDStatusBarNotification showWithStatus:str];
    });
}

- (void) didNetDisconnect
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [JDStatusBarNotification showWithStatus:@"DISCONNECTED!!!" dismissAfter:2 styleName:JDStatusBarStyleWarning];
    });
}


@end
