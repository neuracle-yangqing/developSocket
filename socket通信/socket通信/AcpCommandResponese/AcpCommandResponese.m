//
//  AcpCommandResponese.m
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "AcpCommandResponese.h"

@implementation AcpCommandResponese

-(FrameHeader *)frameHeader{
    if(!_frameHeader){
        
        _frameHeader = [FrameHeader new];
    }
    return _frameHeader;
}

-(FrameTail *)frameTail{
    if(!_frameTail){
        
        _frameTail = [FrameTail new];
    }
    return _frameTail;
}

-(ResponseSubHeader *)FrameSubHeader{
    if(!_FrameSubHeader){
        
        _FrameSubHeader = [ResponseSubHeader new];
    }
    return _FrameSubHeader;
}

-(ResponseData *)ResponseData{
    if(!_ResponseData){
        
        _ResponseData = [ResponseData new];
    }
    return _ResponseData;
}

@end
