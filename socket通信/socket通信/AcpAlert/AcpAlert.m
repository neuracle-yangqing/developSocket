//
//  AcpAlert.m
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "AcpAlert.h"

@implementation AcpAlert


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

-(AlertData *)alertData{
    if(!_alertData){
        
        _alertData = [AlertData new];
    }
    return _alertData;
}

-(AlertSubHeader *)alertSubHeader{
    if(!_alertSubHeader){
        
        _alertSubHeader = [AlertSubHeader new];
    }
    return _alertSubHeader;
}

@end
