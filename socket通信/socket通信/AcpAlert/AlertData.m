//
//  AlertData.m
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "AlertData.h"

@implementation AlertData

#pragma mark - 懒加载数组的属性
-(NSMutableData *)ParaList{
    if(!_ParaList){
        
        _ParaList = [NSMutableData data];
    }
    return _ParaList;
}

-(NSMutableData *)DataArray{
    if(!_DataArray){
        _DataArray = [NSMutableData data];
        
    }
    return _DataArray;
}



@end
