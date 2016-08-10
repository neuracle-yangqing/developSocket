//
//  baseFrame.h
//  socket通信
//
//  Created by neuracle on 16/8/3.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrameHeader.h"
#import "FrameTail.h"
#import "FrameSubHeader.h"

/*
 
 [FieldOffset(0)]
 public ushort Token;
 [FieldOffset(2)]
 public byte HeaderLength;
 [FieldOffset(3)]
 public ushort PayloadLength;
 [FieldOffset(5)]
 public byte PackageType;
 
 */
@interface baseFrame : NSObject

@property(nonatomic, strong)FrameHeader * frameHeader;

@property(nonatomic, strong)FrameTail * frameTail;

@property(nonatomic, strong)FrameSubHeader * frameSubHeader;

@end
