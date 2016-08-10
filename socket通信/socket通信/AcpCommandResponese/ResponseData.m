//
//  ResponseData.m
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "ResponseData.h"

@implementation ResponseData

#pragma mark - 懒加载属性
-(MESPara *)MESPara{
    if(!_MESPara){
        
        _MESPara = [MESPara new];
    }
    return _MESPara;
}

-(EEGPara *)EEGPara{
    if(!_EEGPara){
        
        _EEGPara = [EEGPara new];
    }
    return _EEGPara;
}

-(NSMutableData *)ParaArray{
    if(!_ParaArray){
        _ParaArray = [NSMutableData data];
    }
    
    return _ParaArray;
}

@end
