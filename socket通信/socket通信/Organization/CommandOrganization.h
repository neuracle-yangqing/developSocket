//
//  CommandOrganization.h
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandOrganization : NSObject
/*
 所有的命令行的属性的表
 */
@property(nonatomic, assign)Byte * sendHello;

@property(nonatomic, assign)Byte * sendReset;

@property(nonatomic,assign)Byte * sendStart;

//定义的一个全局的crc的函数
//extern unsigned short int crc16_ccitt(unsigned char  *block,unsigned int blockLength,unsigned short int crc);

/**
 *  test command 的属性参数
 */
@property(nonatomic,assign)UInt16 token;

@property(nonatomic,assign)UInt16 tailToken;

@property(nonatomic,assign)UInt8 headerLength;

@property(nonatomic,assign)UInt16 payLoadLength;

@property(nonatomic,assign)UInt8 packageType;

@property(nonatomic,assign)UInt8 ModuleType;

@property(nonatomic,assign)UInt8 CommandType;

@end