//
//  FrameSubHeader.h
//  socket通信
//
//  Created by neuracle on 16/8/9.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 [FieldOffset(0)]
 public byte ModuleType;
 
 [FieldOffset(1)]
 public byte CommandType;
 
 [FieldOffset(2)]
 public byte PacketID;
 
 [FieldOffset(3)]
 public byte CommandSequence;
 
 [FieldOffset(4)]
 public byte Result;
 
 [FieldOffset(5)]
 public byte ErrorCode;
 
 [FieldOffset(6)]
 public uint TimeStamp;
 
 [FieldOffset(10)]
 public uint TimeStampFromPowerOn;
 

 */

@interface FrameSubHeader : NSObject

@property(nonatomic,assign)UInt8 ModuleType;

@property(nonatomic,assign)UInt8 CommandType;

@property(nonatomic,assign)UInt8 PacketID;

@property(nonatomic,assign)UInt8 CommandSequence;

@property(nonatomic,assign)UInt8 Result;

@property(nonatomic,assign)UInt8 ErrorCode;

@property(nonatomic,assign)int TimeStamp;

@property(nonatomic,assign)int TimeStampFromPowerOn;

@end
