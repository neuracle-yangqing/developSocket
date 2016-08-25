//
//  AlertSubHeader.m
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "AlertSubHeader.h"
static  NSInteger indexxxx = 0;
static UInt8 oldPacketID  = 0x00;

@interface AlertSubHeader ()



@end

@implementation AlertSubHeader


#pragma mark - 测试验证数据的连续性的依据
//应用的监听的是set方法的验证
-(void)setPacketID:(UInt8)PacketID{
    _PacketID = PacketID;
    
    if(indexxxx == 0){
        
        oldPacketID = PacketID;
        indexxxx++;
        
    }else{
        
        if( (int)(PacketID - oldPacketID) != 1){
            
            NSLog(@"发现的是数据包的不连续的情况!");
            NSLog(@"%d",(int)PacketID);
            NSLog(@"%d",(int)oldPacketID);
            
        }
        
        //重新来进行赋新值
       oldPacketID = PacketID;
    }
    
    
}

@end
