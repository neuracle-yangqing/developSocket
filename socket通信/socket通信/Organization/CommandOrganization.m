//
//  CommandOrganization.m
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import "CommandOrganization.h"
#import "acpEnum.h"


#define CRC_SEED   0xFFFF   // 该位称为预置值，使用人工算法（长除法）时 需要将除数多项式先与该与职位 异或 ，才能得到最后的除数多项式
#define POLY16 0x1021  // 该位为简式书写 实际为0x11021


@interface CommandOrganization ()
/**
 *  外接的命令行的数据流
 */
@property(nonatomic,strong)NSMutableData * data;

/**
 *  发命令的16进制的索引
 */
@property(nonatomic,assign)UInt8 Sequence;

/**
 *  缓存的字节数组
 */
@property(nonatomic, strong)NSMutableArray * byteArray;

@end


@implementation CommandOrganization

#pragma mark - 懒加载属性
-(NSMutableData *)data{
    if(!_data){
        
        _data = [NSMutableData dataWithCapacity:13];
    }
    return _data;
}

-(UInt8)Sequence{
    if(_Sequence == 0){
        
        _Sequence = 0x01;
    }
    return _Sequence;
}


#pragma mark - 重写get方法来进行的取值
-(Byte *)sendHello{
    //实现的思路是:通过一个NSdata 来进行的转化成一个字节的数组来进行的操作!
    //就是把一个十六进制的数来转换成一个数组来进行的操作!
    if(!_sendHello){
        
        //注意的是:这个是FrameHeader里面的:
        UInt16 frameToken = 0x0550;//本身就是字节
        UInt16 payloadLength = 0x0000;
        UInt8  headerLength = 0x09;
        UInt8  packageType = Command;
        
        //转成data
        //要求的是我们可以来进行的拼接的成一个data来进行的操作
        NSMutableData * data = [NSMutableData dataWithBytes:&frameToken length:2];
        NSMutableData * data1 = [NSMutableData data];
        
        [data appendBytes:&headerLength length:1];
        [data1 appendBytes:&headerLength length:1];
        [data appendBytes:&payloadLength length:2];
        [data1 appendBytes:&payloadLength length:2];
        [data appendBytes:&packageType length:1];
        [data1 appendBytes:&packageType length:1];
        
        NSLog(@"data==%@",data);
        //添加拼接这个FrameHeader
        //[self.data appendData:data];
        
        
        //FrameSubHeader 的拼包的情况!
        UInt8 Module = Device;
        UInt8 CommandType = Hello ;
        UInt8 CommandSequence = self.Sequence;
        
        [data appendBytes:&Module length:1];
        [data appendBytes:&CommandType length:1];
        [data appendBytes:&CommandSequence length:1];
        
        [data1 appendBytes:&Module length:1];
        [data1 appendBytes:&CommandType length:1];
        [data1 appendBytes:&CommandSequence length:1];
        //添加拼接这个FrameSubHeader
        //[self.data appendData:data];
        
        NSLog(@"crc16:data1 = %@",data1);
        //FrameTail 的拼包的情况
        //CRC
        UInt16 CRC16 = [self crc16:data1];
        UInt16 FrameTailToken = 0x5005;
        
        [data appendBytes:&CRC16 length:2];
        [data appendBytes:&FrameTailToken length:2];
        [self.data appendData:data];
        
        NSLog(@"最后生成的添加CRC的情况: %@",self.data);
        
        
        /*
         
         NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF16StringEncoding];
         NSData * data1 = [string dataUsingEncoding:NSUTF16StringEncoding];
         
         
         Byte * testbyte = (Byte *)[data bytes];
         
         self.byteArray = [NSMutableArray array];
         
         for (int i = 0; i < [data length]; i++) {
         if(i == 0 || i == 1){
         break;
         }
         UInt8 tempByte = testbyte[i];
         //转成字节数组
         [self.byteArray addObject:@(tempByte)];
         }
         
         }
         NSLog(@"byteArray = %@",byteArray);
         
         */
        //发送的成功之后的命令要求的是加一的情况!
        
    }
    
    return _sendHello;
}

-(Byte *)sendReset{
    //添加reset的情况!
    //最终的是完整的将我们的reset的NSdata 来实现的!
    if(!_sendHello){
        //1.frameHeader 的包头
        UInt16 frameToken = 0x0ff0;
        UInt8  headerLength = 0x09;
        UInt16 payLoadLength = 0x0000;
        UInt8  packageType = Command;
        
        NSMutableData * data = [NSMutableData data];
        [data appendBytes:&frameToken length:2];
        [data appendBytes:&headerLength length:1];
        [data appendBytes:&payLoadLength length:2];
        [data appendBytes:&packageType length:Command];
        
        //2.frameSubHeader 的包头
        UInt8 module = Device;
        UInt8 commandType = Reset;
        UInt8 commandSequence = self.Sequence;
        [data appendBytes:&module length:1];
        [data appendBytes:&commandType length:1];
        [data appendBytes:&commandSequence length:1];
        
        //3.frameTail
        NSLog(@"计算crc之前的data == %@",data);
        UInt16 crc = [self crc16:data];
        UInt16 frameTailToken = 0xf00f;
        [data appendBytes:&crc length:2];
        [data appendBytes:&frameTailToken length:2];
        
        NSLog(@"reset data的数据的 = %@",data);
    }
    
    return _sendReset;
}


-(Byte *)sendStart{
    //添加sendStart的情况!
    //最终是完整的将我们的start的转化成 NSdata的情况!
    if(!_sendStart){
        NSMutableData * data = [NSMutableData data];
        
        //1.frameHeader 的包头
        UInt16 frameToken = 0x0ff0;
        UInt8  headerLength = 0x09;
        UInt16 payloadLength = 0x0000;
        UInt8  packageType = Command;
        
        [data appendBytes:&frameToken length:2];
        [data appendBytes:&headerLength length:1];
        [data appendBytes:&payloadLength length:2];
        [data appendBytes:&packageType length:1];
        
        //2.frameSubHeader 的包头
        UInt8 module = Device;
        UInt8 commandType = Start;
        UInt8 commandSequence = self.Sequence;
        [data appendBytes:&module length:1];
        [data appendBytes:&commandType length:1];
        [data appendBytes:&commandSequence length:self.Sequence];
        
        NSLog(@"data = crc 之前的数据包的情况: %@",data);
        
        //3.frameTail 的包
        //data 的传递是有问题的要求的是舍弃最前面的包头的情况;
        UInt16 crc16  = [self crc16:data];
        UInt16 frameTailToken = 0xf00f;
        [data appendBytes:&crc16 length:2];
        [data appendBytes:&frameTailToken length:2];
        
        NSLog(@"sendStart 的数据包的情况: %@",data);
        
    }
    
    return _sendStart;
}

//改变c 的crc 的校验的情况
//-(UInt16)CreateCRCviaBit:(unsigned char *)noTokenData andDataLength:(int)length{
//    
//    UInt16 shift,data,val;
//    int i;
//    
//    shift = CRC_SEED;
//    
//    
//    for(i=0;i<length;i++) {
//        
//        if((i % 8) == 0)
//            data = (*noTokenData++) <<8;
//        
//        val = shift ^ data;
//        shift = shift<<1;
//        data = data <<1;
//        
//        if(val&0x8000)
//            shift = shift ^ POLY16;
//    }
//    return shift;
//
//}

static const unsigned short crc16table[] =
{
    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50A5, 0x60C6, 0x70E7,
    0x8108, 0x9129, 0xA14A, 0xB16B, 0xC18C, 0xD1AD, 0xE1CE, 0xF1EF,
    0x1231, 0x0210, 0x3273, 0x2252, 0x52B5, 0x4294, 0x72F7, 0x62D6,
    0x9339, 0x8318, 0xB37B, 0xA35A, 0xD3BD, 0xC39C, 0xF3FF, 0xE3DE,
    0x2462, 0x3443, 0x0420, 0x1401, 0x64E6, 0x74C7, 0x44A4, 0x5485,
    0xA56A, 0xB54B, 0x8528, 0x9509, 0xE5EE, 0xF5CF, 0xC5AC, 0xD58D,
    0x3653, 0x2672, 0x1611, 0x0630, 0x76D7, 0x66F6, 0x5695, 0x46B4,
    0xB75B, 0xA77A, 0x9719, 0x8738, 0xF7DF, 0xE7FE, 0xD79D, 0xC7BC,
    0x48C4, 0x58E5, 0x6886, 0x78A7, 0x0840, 0x1861, 0x2802, 0x3823,
    0xC9CC, 0xD9ED, 0xE98E, 0xF9AF, 0x8948, 0x9969, 0xA90A, 0xB92B,
    0x5AF5, 0x4AD4, 0x7AB7, 0x6A96, 0x1A71, 0x0A50, 0x3A33, 0x2A12,
    0xDBFD, 0xCBDC, 0xFBBF, 0xEB9E, 0x9B79, 0x8B58, 0xBB3B, 0xAB1A,
    0x6CA6, 0x7C87, 0x4CE4, 0x5CC5, 0x2C22, 0x3C03, 0x0C60, 0x1C41,
    0xEDAE, 0xFD8F, 0xCDEC, 0xDDCD, 0xAD2A, 0xBD0B, 0x8D68, 0x9D49,
    0x7E97, 0x6EB6, 0x5ED5, 0x4EF4, 0x3E13, 0x2E32, 0x1E51, 0x0E70,
    0xFF9F, 0xEFBE, 0xDFDD, 0xCFFC, 0xBF1B, 0xAF3A, 0x9F59, 0x8F78,
    0x9188, 0x81A9, 0xB1CA, 0xA1EB, 0xD10C, 0xC12D, 0xF14E, 0xE16F,
    0x1080, 0x00A1, 0x30C2, 0x20E3, 0x5004, 0x4025, 0x7046, 0x6067,
    0x83B9, 0x9398, 0xA3FB, 0xB3DA, 0xC33D, 0xD31C, 0xE37F, 0xF35E,
    0x02B1, 0x1290, 0x22F3, 0x32D2, 0x4235, 0x5214, 0x6277, 0x7256,
    0xB5EA, 0xA5CB, 0x95A8, 0x8589, 0xF56E, 0xE54F, 0xD52C, 0xC50D,
    0x34E2, 0x24C3, 0x14A0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
    0xA7DB, 0xB7FA, 0x8799, 0x97B8, 0xE75F, 0xF77E, 0xC71D, 0xD73C,
    0x26D3, 0x36F2, 0x0691, 0x16B0, 0x6657, 0x7676, 0x4615, 0x5634,
    0xD94C, 0xC96D, 0xF90E, 0xE92F, 0x99C8, 0x89E9, 0xB98A, 0xA9AB,
    0x5844, 0x4865, 0x7806, 0x6827, 0x18C0, 0x08E1, 0x3882, 0x28A3,
    0xCB7D, 0xDB5C, 0xEB3F, 0xFB1E, 0x8BF9, 0x9BD8, 0xABBB, 0xBB9A,
    0x4A75, 0x5A54, 0x6A37, 0x7A16, 0x0AF1, 0x1AD0, 0x2AB3, 0x3A92,
    0xFD2E, 0xED0F, 0xDD6C, 0xCD4D, 0xBDAA, 0xAD8B, 0x9DE8, 0x8DC9,
    0x7C26, 0x6C07, 0x5C64, 0x4C45, 0x3CA2, 0x2C83, 0x1CE0, 0x0CC1,
    0xEF1F, 0xFF3E, 0xCF5D, 0xDF7C, 0xAF9B, 0xBFBA, 0x8FD9, 0x9FF8,
    0x6E17, 0x7E36, 0x4E55, 0x5E74, 0x2E93, 0x3EB2, 0x0ED1, 0x1EF0
};


//生成CRC的函数的情况!
- (UInt16)crc16: (NSData*) data
{
    UInt16 crc;
    
    crc = 0xFFFF;
    
    uint8_t byteArray[[data length]];
    [data getBytes:&byteArray];//方法过期了
    
    for (int i = 0; i<[data length]; i++) {
        Byte byte = byteArray[i];
        crc = (crc << 8) ^ crc16table[(crc^ byte) & 0xFF];
    }
    return crc;
}

@end
