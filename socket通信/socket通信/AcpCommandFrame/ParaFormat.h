//
//  ParaFormat.h
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 byte ParaID;
 byte ParaLength;
 byte[] ParaArray;
 */

@interface ParaFormat : NSObject

@property(nonatomic,assign)UInt8 ParaID;

@property(nonatomic,assign)UInt8 ParaLength;

@property(nonatomic,assign)UInt8 ParaArray;

@end
