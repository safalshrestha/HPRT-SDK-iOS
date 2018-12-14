//
//  AppDelegate.h
//  samplepos
//
//  Created by 彭书旗 on 2017/7/17.
//  Copyright © 2017年 Caysn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PrinterLibs/PrinterLibs.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BLEPrintingOpenDelegate,BLEPrintingDisconnectDelegate,NETPrintingOpenDelegate,NETPrintingDisconnectDelegate>

@property (strong, nonatomic) UIWindow *window;

@property NETPrinting * myNet;
@property BLEPrinting * myBle;
@property POSPrinting * myPos;
@property LabelPrinting * myLabel;

@property dispatch_queue_t myQueue;

@end

