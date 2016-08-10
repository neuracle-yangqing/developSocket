//
//  AcpCommandResponese.h
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrameHeader.h"
#import "FrameTail.h"
#import "ResponseSubHeader.h"
#import "ResponseData.h"

@interface AcpCommandResponese : NSObject

@property(nonatomic, strong)FrameHeader * frameHeader;

@property(nonatomic, strong)FrameTail * frameTail;

@property(nonatomic, strong)ResponseSubHeader * FrameSubHeader;

@property(nonatomic, strong)ResponseData * ResponseData;

@end
