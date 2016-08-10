//
//  ResponseData.h
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MESPara.h"
#import "EEGPara.h"

/*
 public MESPara MesPara { get; set; }
 
 public EEGPara EEGPara { get; set; }
 public byte[] ParaArray { get; set; }
 */

@interface ResponseData : NSObject

@property(nonatomic, strong)MESPara * MESPara;

@property(nonatomic, strong)EEGPara * EEGPara;

@property(nonatomic, strong)NSMutableData * ParaArray;

@end
