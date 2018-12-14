//
//  POSPrinting.h
//  PrinterLibs
//
//  Created by 彭书旗 on 15/12/18.
//  Copyright © 2015年 开聪电子. All rights reserved.
//

#ifndef POSPrinting_h
#define POSPrinting_h

#import <Foundation/Foundation.h>

#import <UIKit/UIImage.h>

#import "IO.h"

// 类的声明
@interface POSPrinting : NSObject

- (instancetype) init;

/**
 * 读写方式和打印指令分离，给该类设置一个io即可实现打印。
 */
- (void) SetIO:(IO *) io;

- (IO *) GetIO;

/**
 * 按照一定的格式打印字符串
 *
 * @param pszString
 *            需要打印的字符串
 * @param x
 *            指定 X 方向（水平）的起始点位置离左边界的点数。 一般为0。2寸打印机一行384点，3寸打印机一行576点。
 * @param nWidthTimes
 *            指定字符的宽度方向上的放大倍数。可以为 0到 1。
 * @param nHeightTimes
 *            指定字符高度方向上的放大倍数。可以为 0 到 1。
 * @param nFontType
 *            指定字符的字体类型。 (0x00 标准 ASCII 12x24) (0x01 压缩ASCII 9x17)
 * @param nFontStyle
 *            指定字符的字体风格。可以为以下列表中的一个或若干个。 (0x00 正常) (0x08 加粗) (0x80 1点粗的下划线)
 *            (0x100 2点粗的下划线) (0x200 倒置、只在行首有效) (0x400 反显、黑底白字) (0x1000
 *            每个字符顺时针旋转 90 度)
 */
- (bool) POS_PrintText:(char *)pszString x:(int)x nWidthTimes:(int)nWidthTimes nHeightTimes:(int)nHeightTimes nFontType:(int)nFontType nFontStyle:(int)nFontStyle;

- (bool) POS_PrintBarcode:(char *)pszString x:(int)x nType:(int)nType nUnitWidth:(int)nUnitWidth nHeight:(int)nHeight nHriFontType:(int)nHriFontType nHriFontPosition:(int)nHriFontPosition;

- (bool) POS_PrintQRcode:(char *)pszString x:(int)x nUnitWidth:(int)nUnitWidth nVersion:(int)nVersion nECCLevel:(int)nECCLevel;

- (bool) POS_PrintPicture:(UIImage *)mImage x:(int)x nWidth:(int)nWidth nHeight:(int)nHeight nBinaryAlgorithm:(int)nBinaryAlgorithm nCompressMethod:(int)nCompressMethod;

- (bool) POS_FeedLine;

- (bool) POS_SetLineHeight:(int)nHeight;

- (bool) POS_SetRightSpacing:(int)nDistance;

- (bool) POS_Reset;

/***
 * 切纸
 */
- (bool) POS_CutPaper;

/***
 * 蜂鸣器鸣叫
 * @param nBeepCount 鸣叫次数
 * @param nBeepMillis 每次鸣叫的时间 = 100 * nBeemMillis ms
 */
- (bool) POS_Beep:(int)nBeepCount nBeepMillis:(int)nBeepMillis;

/***
 * 打开钱箱
 * @param nDrawerIndex 0表示：脉冲发送到钱箱输出引脚2  1表示：脉冲发送到钱箱输出引脚5
 * @param nPulseTime 脉冲时间 高电平时间：nPulseTime*2ms 低电平时间：nPulseTime*2ms
 */
- (bool) POS_KickDrawer:(int)nDrawerIndex nPulseTime:(int)nPulseTime;

/***
 * 设置打印速度 注：如果打印速度大于发送速度，打印会有卡顿感。
 * @param nSpeed 打印速度（mm/s）
 */
- (bool) POS_SetPrintSpeed:(int)nSpeed;

/***
 * 查询状态
 * 		打印机忙时，该命令会一直阻塞
 * 		返回的状态保存在status中
 * @param status 该值目前无意义
 * @param timeout 单次查询状态的超时毫秒时间
 * @param MaxRetry 失败重试次数
 * @return true表示查询到了状态，也即打印机当前不忙。
 */
- (bool) POS_QueryStatus:(int)type status:(Byte *)status timeout:(int)timeout MaxRetry:(int)MaxRetry;

/***
 * 实时状态查询
 * 		无论打印机处于何种状态，只要打印机收到该命令就立刻回送状态
 * 		返回的状态保存在status中
 * @param type type可取值 [1,4] 参考指令集中针对实时状态的描述
 * @param timeout 单次查询状态的超时毫秒时间
 * @param MaxRetry 失败重试次数
 * @return true表示查询到了状态，也即打印机当前通讯正常。
 */
- (bool) POS_RTQueryStatus:(int)type status:(Byte *)status timeout:(int)timeout MaxRetry:(int)MaxRetry;

/***
  * 查询单据打印结果
  *     可以识别出因缺纸，过热，或其他错误导致单据打印不完整的情况。
  * 返回 0，表示单据打印成功。
  * 返回-1，表示单据查询指令失败。失败原因：连接断开或已关闭。
  * 返回-2，表示单据查询指令失败。失败原因：发送失败。
  * 返回-3，表示单据查询指令失败。失败原因：打印机无响应。
  * 返回-4，表示单据打印失败。原因：打印机脱机。
  * 返回-5，表示单据打印不完整。原因：打印机因缺纸而中断打印。
  * 返回-6，表示单据打印失败。原因：其他原因。
  */
- (int)  POS_TicketSucceed:(int)dwSendIndex timeout:(int)timeout;

@end

#endif /* POSPrinting_h */
