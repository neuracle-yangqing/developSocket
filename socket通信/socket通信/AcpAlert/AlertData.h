//
//  AlertData.h
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 //就是这两个的 data 的数组
 public byte[] ParaList { get; set; }
 public byte[] DataArray { get; set; }
 
 */
@interface AlertData : NSObject

@property(nonatomic, strong)NSMutableData * ParaList;

@property(nonatomic, strong)NSMutableData * DataArray;


@end
