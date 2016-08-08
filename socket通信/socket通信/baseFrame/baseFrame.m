//
//  baseFrame.m
//  socket通信
//
//  Created by neuracle on 16/8/3.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "baseFrame.h"

@implementation baseFrame

#pragma mark - 全部的进行初始化
-(FrameHeader *)frameHeader{
    if(!_frameHeader){
        
        _frameHeader = [[FrameHeader alloc]init];
    }
    
    return _frameHeader;
}

-(FrameTail *)frameTail{
    if(!_frameTail){
        
        _frameTail = [[FrameTail alloc]init];
    }
    return _frameTail;
}


@end
