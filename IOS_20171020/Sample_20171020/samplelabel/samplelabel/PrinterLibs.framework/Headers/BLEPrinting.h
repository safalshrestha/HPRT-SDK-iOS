//
//  BLEPrinting.h
//  PrinterLibs
//
//  Created by 彭书旗 on 15/12/18.
//  Copyright © 2015年 开聪电子. All rights reserved.
//

#ifndef BLEPrinting_h
#define BLEPrinting_h

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>

#import "IO.h"

@protocol BLEPrintingOpenDelegate;
@protocol BLEPrintingDiscoverDelegate;
@protocol BLEPrintingReceiveDelegate;
@protocol BLEPrintingDisconnectDelegate;

// 类的声明
@interface BLEPrinting : IO<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (weak, nonatomic) id<BLEPrintingOpenDelegate> myOpenDelegate;
@property (weak, nonatomic) id<BLEPrintingDiscoverDelegate> myDiscoverDelegate;
@property (weak, nonatomic) id<BLEPrintingReceiveDelegate> myReceiveDelegate;
@property (weak, nonatomic) id<BLEPrintingDisconnectDelegate> myDisconnectDelegate;

- (instancetype)init;

- (void) scan;

- (void) stopScan;

// 阻塞，连接ble设备
- (bool) Open:(CBPeripheral *) peripheral;

// 断开ble设备。设备正常断开或异常断开，都会调用didDisconnect
- (void) Close;

- (bool) IsOpened;

// 阻塞 写数据
- (int) Write:(Byte * ) buffer offset:(int) offset count:(int) count;

// 阻塞 读取缓冲区数据
- (int) Read:(Byte *)buffer offset:(int)offset count:(int)count timeout:(int)timeout;

- (void) SkipAvailable;

// Set Before Open
- (void) SetWriteHighSpeed:(bool)highSpeed packetSize:(int)packetSize packetTimeout:(int)packetTimeout packetMaxRetry:(int)packetMaxRetry;

@end


@protocol BLEPrintingDiscoverDelegate <NSObject>

@required

@optional

- (void) didDiscoverBLE:(CBPeripheral *) peripheral address:(NSString *)address rssi:(int)rssi;

@end


@protocol BLEPrintingOpenDelegate <NSObject>

@required

@optional
// Open成功会调用
- (void) didBleOpen:(CBPeripheral *) peripheral;

@end


@protocol BLEPrintingReceiveDelegate <NSObject>

@required

@optional
// 注意：收到数据之后，会将数据放到缓冲区。并调用didReceive。
- (void) didBleReceive:(unsigned char * ) buffer length:(unsigned long) length;

@end


@protocol BLEPrintingDisconnectDelegate <NSObject>

@required

@optional

- (void) didBleDisconnect;

@end

#endif /* BLEPrinting_h */
