//
//  AlertSubHeader.m
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "AlertSubHeader.h"
/**
 *  注意的是: 这里的对象都是临时释放的,只能是用动态类来解决的!
 */
static  NSInteger indexxxx = 0;
static UInt8 oldPacketID  = 0x00;
static float oldTimeStamp;
static NSInteger index2222 = 0;

@interface AlertSubHeader ()



@end

@implementation AlertSubHeader


#pragma mark - 测试验证数据的连续性的依据
//应用的监听的是set方法的验证
-(void)setPacketID:(UInt8)PacketID{
    _PacketID = PacketID;
    
    if(indexxxx == 0){
        
        oldPacketID = PacketID;
        indexxxx = 1;
    }else{
        
        if( (int)(PacketID - oldPacketID) != 1){
            //通过packetID来进行的测试,验证的数据的是否是连续的实现
            NSLog(@"发现的是数据包的不连续的情况!");
            NSLog(@"%d",(int)PacketID);
            NSLog(@"%d",(int)oldPacketID);
        }
        
        //重新来进行赋新值
        oldPacketID = PacketID;
    }
}

-(void)setTimeStamp:(float)TimeStamp{
    
    _TimeStamp = TimeStamp;
    if(index2222 == 0){
        oldTimeStamp = TimeStamp;
        index2222 = 1;
        
    }else{
        //校验的公式是:记录的是,下一秒和上一秒的时间差来,通过当前的采样率来判断生成的数据的点数和反馈出来的数据,之间的映射的关系!
        //现在的是,根据的points 的参数来进行的传递
        //根据的是我们的采样率是:1k/s 的话,那么的是我们的每秒生成的点数是: 就是1000个点来进行的实现的!
        //我们是每包10个点,就是 30个byte  要求测试的速度是:30ms的速度来进行的测试的话!
        if(TimeStamp - oldTimeStamp > 0.5){
            //
            NSLog(@"发现数据生成的超时!!!");
            NSLog(@"时间的差值是: %f",TimeStamp - oldTimeStamp);
            NSLog(@"now time = %f",TimeStamp );
            NSLog(@"old time = %f",oldTimeStamp);
        }
        oldTimeStamp = TimeStamp;
    }
    
}
@end
