//
//  NSObject+IO.h
//  PrinterLibs
//
//  Created by 彭书旗 on 16/3/22.
//  Copyright © 2016年 开聪电子. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IO : NSObject

- (instancetype)init;

/***
  * 空实现，继承该类的子类需要实现这个函数
  */
- (bool) IsOpened;

/***
 * 空实现，继承该类的子类需要实现这个函数
 */
- (int) Write:(Byte * ) buffer offset:(int) offset count:(int) count;

/***
 * 空实现，继承该类的子类需要实现这个函数
 */
- (int) Read:(Byte *)buffer offset:(int)offset count:(int)count timeout:(int)timeout;

/***
 * 空实现，继承该类的子类需要实现这个函数
 */
- (void) SkipAvailable;

@end
