//
//  CommandData.h
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MESPara.h"
#import "EEGPara.h"

/*
 public MESPara MESPara;
 public EEGPara EEGPara;
 public byte[] ParaList;
 */

@interface CommandData : NSObject

@property(nonatomic,assign)UInt8 ParaList;

@property(nonatomic, strong)EEGPara * EEGPara;

@property(nonatomic, strong)MESPara * MESPara;

@end
