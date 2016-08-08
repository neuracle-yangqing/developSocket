//
//  AcpCommandFrame.m
//  socket通信
//
//  Created by neuracle on 16/8/3.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "AcpCommandFrame.h"

@implementation AcpCommandFrame

#pragma mark - 进行的初始值的设定
-(CommandSubHeader *)subHeader{
    if(!_subHeader){
        
        _subHeader = [CommandSubHeader new];
    }
    return _subHeader;
}

-(CommandData *)CommandData{
    if(!_CommandData){
        
        _CommandData = [CommandData new];
    }
    return _CommandData;
}


@end
