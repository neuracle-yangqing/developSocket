//
//  CommandSubHeader.h
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 [FieldOffset(0)]
 public byte ModuleType;
 
 [FieldOffset(1)]
 public byte CommandType;
 
 [FieldOffset(2)]
 public byte CommandSequence;
 
 */

@interface CommandSubHeader : NSObject

@property(nonatomic,assign)UInt8 ModuleType;

@property(nonatomic,assign)UInt8 CommandType;

@property(nonatomic,assign)UInt8 CommandSequence;

@end
