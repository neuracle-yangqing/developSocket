//
//  FrameTail.h
//  socket通信
//
//  Created by neuracle on 16/8/3.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrameTail : NSObject

@property(nonatomic,assign)UInt16 CRC;

@property(nonatomic,assign)UInt16 TailToken;

@end
