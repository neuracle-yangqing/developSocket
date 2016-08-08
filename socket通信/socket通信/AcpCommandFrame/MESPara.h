//
//  MESPara.h
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 [FieldOffset(0)]
 public byte Gain;
 [FieldOffset(1)]
 public byte WorkMode;
 [FieldOffset(2)]
 public ushort ChannelNum;
 [FieldOffset(4)]
 public ushort SampleRate;
 [FieldOffset(6)]
 public byte Points;
 */

@interface MESPara : NSObject

@property(nonatomic,assign)UInt8 Gain;

@property(nonatomic,assign)UInt8 WorkMode;

@property(nonatomic,assign)UInt8 Points;

@property(nonatomic,assign)UInt16 ChannelNum;

@property(nonatomic,assign)UInt16 SampleRate;

@end
