//
//  AlertData.m
//  socket通信
//
//  Created by neuracle on 16/8/10.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "AlertData.h"
#import "ProcessData.h"

@interface AlertData ()

//定义的缓存数据的队列来进行的缓存!
@property(nonatomic,strong)NSMutableArray * dataQueue;

//定义processDATA的缓存的数据:
@property(nonatomic,strong)ProcessData * processClass;

@end

@implementation AlertData

#pragma mark - 懒加载数组的属性
-(NSMutableData *)ParaList{
    if(!_ParaList){
        
        _ParaList = [NSMutableData data];
    }
    return _ParaList;
}

-(NSMutableArray *)dataQueue{
    if(!_dataQueue){
        
        _dataQueue = [NSMutableArray array];
    }
    return _dataQueue;
}

-(ProcessData *)processClass{
    if(!_processClass){
        
        _processClass = [ProcessData new];
    }
    return _processClass;
}

#pragma mark - 重写数据data的set方法
-(void)setDataArray:(NSMutableData *)DataArray{
    _DataArray = DataArray;
    //每次的dataArray传递过来之后的,进行组包解析!
    //创建一个先进先出的队列来进行保存数据,注意的是这里的数据不能多次进行的传递!对性能的消耗和使用是比较大的!
    //直接的进行data的处理:
    NSInteger length = DataArray.length;
    Byte * int24Array = (Byte *)[DataArray bytes];
    
    //调用得到 uint24 --> int 的方法!
    //根据的是 point 的属性的值来通过截取对应的长度!  eg:  10 ---> 对应的是 10*3 = 30个byte
    //实现的原理是:通过的 应用的 3个 byte 来进行的 拼接成一个 int
    for (int j = 0; j < length; j+=self.processClass.points * 3 ) {
        //要求实现的有n 个通道,每个的通道放十个数据!
        for(int i= j;i < j + self.processClass.points * 3; i+=3){
            //注意的是,这样的完全的是为了提高数据传输的性能!
            int reallyInt =  int24Array[i] + (int24Array[i + 1]<<8) +(int24Array[i +2] << 16);
            //还有的是:要求判断相应的符号的情况!
            //原理是:通过byte的最高位的大小来进行的判断出相应的int 的符号!
            
        }
        
    }
    
    
//    [_dataQueue addObject:DataArray];
//    #warning (添加警告的内容) 这里进行的打印的校验:
//    NSLog(@"_dataQueue = %@",_dataQueue);

}





@end
