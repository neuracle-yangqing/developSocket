//
//  ProcessData.m
//  socket通信
//
//  Created by neuracle on 16/8/19.
//  Copyright © 2016年 neuracle. All rights reserved.
//

/*
 //注意的是: 这个类的核心的功能是: 拿到相应的data流的操作,来将其封装成一个 "32"导的数据的array的二维的数据包!传到相应的视图来进行的绘制
 //此类的功能和作用是: 开启一个线程来把 传递的数据data流:开启一个线程来进行的 uint24 位数值转化成 int 的数据!
 //然后的进行的组包: 成为一个 二维的数组来传递给 绘图的view
*/
#import "ProcessData.h"

@interface ProcessData ()



@end

@implementation ProcessData

#pragma mark - 添加懒加载int-->pointArray
-(NSMutableArray *)packeageData{
    if(!_packeageData){
        
        _packeageData = [NSMutableArray array];
    }
    return _packeageData;
}

//自定义的points
-(uint8_t)points{
    if(!_points){
        
        _points = 0X0A;
    }
    return _points;
}

//通道的数量(自己的手动的设置)
-(UInt16)channelNum{
    if (!_channelNum) {
        _channelNum = 0X20; //代表的是 32通道的数量  // 0x10 代表的是 16的通道的数量!
    }
    return _channelNum;
}

//接受数据:怎么来进行的接受!


@end
