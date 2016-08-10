//
//  AcpAlert.h
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrameHeader.h"
#import "FrameTail.h"
#import "AlertData.h"
#import "AlertSubHeader.h"

@interface AcpAlert : NSObject

@property(nonatomic, strong)FrameHeader * frameHeader;

@property(nonatomic, strong)FrameTail * frameTail;

@property(nonatomic, strong)AlertData * alertData;

@property(nonatomic, strong)AlertSubHeader * alertSubHeader;

@end
