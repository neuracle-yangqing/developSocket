//
//  ProcessData.h
//  socket通信
//
//  Created by neuracle on 16/8/19.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessData : NSObject

@property(nonatomic, strong)NSMutableArray * packeageData;

//定义一个块代码的属性:(在被调用方来定义)(调用方来进行的执行)
//block 是一块预先准备的代码块,在需要的时候才会来进行的执行的!
//@property(nonatomic, copy)void * <#address#>;


/**
 *  传递的重要的设置的参数
    这个是: EEG Parameter
 uint16_t simplingrate
 */

@property(nonatomic,assign)UInt8 gain;

@property(nonatomic,assign)UInt8 workMode;

@property(nonatomic,assign)UInt16 channelNum;

@property(nonatomic,assign)uint16_t simplingrate ;

@property(nonatomic,assign)uint8_t points;

@end
