//
//  NSObject+NETPrinting.h
//  PrinterLibs
//
//  Created by 彭书旗 on 16/3/22.
//  Copyright © 2016年 开聪电子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

#include <stdio.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#import "IO.h"

@protocol NETPrintingOpenDelegate;
@protocol NETPrintingDisconnectDelegate;

@interface NETPrinting : IO

@property (weak, nonatomic) id<NETPrintingOpenDelegate> myOpenDelegate;
@property (weak, nonatomic) id<NETPrintingDisconnectDelegate> myDisconnectDelegate;

- (instancetype) init;

- (bool) Open:(NSString *)ipAddress portNumber:(UInt16)portNumber;

- (void) Close;

- (bool) IsOpened;

// 阻塞 写数据
- (int) Write:(Byte * ) buffer offset:(int) offset count:(int) count;

// 阻塞 读取缓冲区数据
- (int) Read:(Byte *)buffer offset:(int)offset count:(int)count timeout:(int)timeout;

- (void) SkipAvailable;

@end



@protocol NETPrintingOpenDelegate <NSObject>

@required

@optional
// Open成功会调用
- (void) didNetOpen:(NSString *)ipAddress portNumber:(UInt32)portNumber;

@end


@protocol NETPrintingDisconnectDelegate <NSObject>

@required

@optional

- (void) didNetDisconnect;

@end
