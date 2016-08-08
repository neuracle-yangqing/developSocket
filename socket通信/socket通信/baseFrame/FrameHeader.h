//
//  FrameHeader.h
//  socket通信
//
//  Created by neuracle on 16/8/3.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 [FieldOffset(0)]
 public ushort CRC;
 [FieldOffset(2)]
 public ushort TailToken;
 */

@interface FrameHeader : NSObject

@property(nonatomic,assign)UInt16 PayloadLength;

@property(nonatomic,assign)UInt16 Token;

@property(nonatomic,assign)UInt8 PackageType;

@property(nonatomic,assign)UInt8 HeaderLength;

@end
