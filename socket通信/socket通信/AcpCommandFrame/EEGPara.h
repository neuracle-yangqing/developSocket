//
//  EEGPara.h
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 [FieldOffset(0)]
 public byte PowerState;
 [FieldOffset(1)]
 public byte Points;
 [FieldOffset(2)]
 public byte Scale;
 [FieldOffset(3)]
 public ushort SampleRate;
 */

@interface EEGPara : NSObject

@property(nonatomic,assign)UInt8 PowerState;

@property(nonatomic,assign)UInt8 Points;

@property(nonatomic,assign)UInt8 Scale;

@property(nonatomic,assign)UInt16 SampleRate;

@end
