//
//  MemoryIO+MemoryIO.h
//  PrinterLibs
//
//  Created by 彭书旗 on 2017/7/15.
//  Copyright © 2017年 Caysn. All rights reserved.
//

#ifndef DSLIBRARY_OS_IOS_MEMORYIO_H
#define DSLIBRARY_OS_IOS_MEMORYIO_H

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#import "IO.h"

@interface MemoryIO : IO

- (instancetype) init;

- (instancetype) initWithSize:(long)size;

- (void) dealloc;

- (bool) Open;

- (void) Close;

- (bool) IsOpened;

// 阻塞 写数据
- (int) Write:(Byte * ) buffer offset:(int) offset count:(int) count;

// 阻塞 读取缓冲区数据
- (int) Read:(Byte *)buffer offset:(int)offset count:(int)count timeout:(int)timeout;

- (void) SkipAvailable;

- (void*) GetBufferLength:(long *)length;

- (void) ResetBuffer;

@end

#endif
