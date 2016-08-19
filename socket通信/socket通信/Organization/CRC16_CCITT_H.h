//
//  CRC16_CCITT_H.h
//  socket通信
//
//  Created by neuracle on 16/8/17.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRC16_CCITT_H : NSObject

//定义的一个全局的crc的函数
//extern unsigned short int crc16_ccitt(unsigned char  *block,unsigned int blockLength,unsigned short int crc);

-(unsigned short int)testCRC:(unsigned char *)testByte andDataLength:(int)length;

@end
