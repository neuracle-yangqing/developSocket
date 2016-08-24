//
//  AlertSubHeader.m
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "AlertSubHeader.h"

@interface AlertSubHeader ()
//记录传递数据的int ---> index 的索引
@property(nonatomic,assign)int index;

@property(nonatomic,assign)UInt8 oldPacketID;

@end

@implementation AlertSubHeader

#pragma mark - 测试验证数据的连续性的依据
//应用的监听的是set方法的验证
-(void)setPacketID:(UInt8)PacketID{
    _PacketID = PacketID;
    if(self.index == 0){
        self.oldPacketID = PacketID;
        
    }else{
        
        if( PacketID - self.oldPacketID != 1){
            NSLog(@"发现的是数据包的不连续的情况!");
            
            
        }
        
        //重新来进行赋新值
        self.oldPacketID = PacketID;
    }
    self.index ++;
}

@end
