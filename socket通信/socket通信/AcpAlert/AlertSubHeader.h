//
//  AlertSubHeader.h
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 [FieldOffset(0)]
 public byte ModuleType;
 
 [FieldOffset(1)]
 public byte AlertType;
 
 [FieldOffset(2)]
 public byte PacketID;
 
 [FieldOffset(3)]
 public uint TimeStamp;
 
 [FieldOffset(7)]
 public uint TimeStampFromPowerOn;
 
 */

@interface AlertSubHeader : NSObject

@property(nonatomic,assign)UInt8 ModuleType;

@property(nonatomic,assign)UInt8 AlertType;

@property(nonatomic,assign)UInt8 PacketID;

@property(nonatomic,assign)int TimeStamp;

@property(nonatomic,assign)int TimeStampFromPowerOn;

/**
 *  缓存的上一个的oldpacketID
 */
//@property(nonatomic,assign)UInt8 oldPacketID;


@end
