//
//  ViewController.m
//  socket通信
//
//  Created by neuracle on 16/8/2.
//  Copyright © 2016年 neuracle. All rights reserved.
//

//  思路和慨念的总结:
//  socket 又成为 "套接字";
//  socket是网络上的两个程序通过一个双向的通信连接实现数据的交换,,这个连接的一端成为一个 socket
//  应用程序通过"套接字"向网络发出请求或者应答网络请求,就是通过 socket!
//  网络上的请求就是通过 socket来建立连接然后互相通信的
//  IP 地址: 就是来寻找服务器的主机,就是通过ip地址来寻找主机和域名的!(比如说是: 196.168.1.11 )一般的 有 web的应用程序;80(提供 HTTP服务的)
//  一台服务器,就是一台电脑,这台电脑里面有很多的应用的程序,然后还有一个 MySQL:3306 MySQLServer(就是数据库应用程序)
//  所以说通过的这个这个对应的 端口号: 来标识进程的逻辑地址, 不同进程的标示;
//  有效的端口: 0~65535,,其中 0~ 1024又系统使用 或者保留端口  开发中建议使用的端口号是: 1024 以上的端口
//  传输协议:(是使用什么样的方式来通过网络传输的) 包括: TCP   UDP
//  我们的HTTP 的请求就是 基于 TCP 的通行协议来封装实现完成. http 的通信方式就是TCP的一种方式...(包括 其中的 三次握手的 通信) 要求建立连接的方式就是 TCP 的方式!
//  (传输控制协议) TCP
//  TCP 的传输的数据是不限传输的...在连接中(数据不受限)
//  TCP 通过的三次握手完成连接的,是可靠的协议,能够安全的送达,,,,,每次都必须建立连接,相对来说的话效率会降低!

//  (用户数据报协议)UDP
//  将数据 及 源和 目的封装成数据包中, 不需要建立连接(直接的通过广播:)接受没有接受就过了...会出现卡顿的效果(绝对是实时的进行的传输的)
//  每个数据包的 大小限制 在 64k 之内
//  目的是:快速而 小的包来进行的传输!
//  数据传输的方式是: 有 TCP 和 UDP 的两种方式; 类比那个发快递是有很都的选择的(顺丰和 中通 圆通...)


//  socket通信的流程图
//  socket() 包括的是TCP客户端 和 TCP服务器端:
//  注意的是: TCP服务器端 中有 ---> bind()--->是要监听我的IP (3306 :80)地址的 端口号

//  sokect()客户端: 通过的write ---> read   ----> close 有在进一步的是http 的底层是通过sokect 建立通信管道,实现数据的传输!
//  http 是一个 TCP 的传输方式..他是一个可靠的安全的协议

//  sokect 是有两块的情况sokect的服务器端监听的; 还有的是: 有sokect的客户端的监听的!
//  有一个 cocoAsyncSockect的框架是 专门用来 异步socket的服务器端的监听的

//  下面通过什么群聊来进行的客户端的socket来进行操作和连接!
#define MAX_PackageLength 1024
#define Max_PayloadLength 1000

#import "ViewController.h"
#import <CFNetwork/CFNetwork.h>
#import <CoreFoundation/CoreFoundation.h>
#import "GCDAsyncSocket.h"
#import "CommandOrganization.h"
#import "acpEnum.h"

#import "baseFrame.h"
#import "AcpAlert.h"
#import "AcpCommandResponese.h"
#import "CRC16_CCITT_H.h"

static NSInteger Testcount = 0;

@interface ViewController ()<GCDAsyncSocketDelegate>

@property(nonatomic, strong)GCDAsyncSocket * clientSocket;

@property (weak, nonatomic) IBOutlet UITextField *Text;

//定义的全局的循环数组
//@property(nonatomic, strong)NSMutableData * dataTotalArray;

//定义的缓存的buffer数组
@property(nonatomic, strong)NSMutableData * dataBufferArray;
//定义的一个buffer缓存的index
@property(nonatomic, assign)NSInteger bufferIndex;


//定义记录一个解包是否为真的全局属性
@property(nonatomic,assign)int reallyPackage;

/**
 *  定义取出每包的 headerLength 和 payloadLength
 */
@property(nonatomic,assign)UInt8 headerLength;
@property(nonatomic,assign)UInt16 payloadLength;

/**
 *  定义的frame 整块的结构体的属性
 */
@property(nonatomic, strong)baseFrame * baseFrame;

@property(nonatomic, strong)AcpAlert * lert;

@end

@implementation ViewController

#pragma mark - 懒加载属性
-(NSMutableData *)dataBufferArray{
    if(!_dataBufferArray){
        
        _dataBufferArray = [NSMutableData data];
        
    }
    return _dataBufferArray;
}

-(baseFrame *)baseFrame{
    
    if(!_baseFrame){
        
        _baseFrame = [baseFrame new];
    }
    return _baseFrame;
}

#pragma mark - 控制器的生命周期的方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //实现聊天室
    //1.连接到群聊服务器
    //1.1 创建一个客户端的socket 对象
    GCDAsyncSocket * clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    self.clientSocket = clientSocket;
    
    //1.2 发送连接的clientSocket
    NSError * error = nil;
    [clientSocket connectToHost:@"192.168.1.62" onPort:8080 error:&error];
    
    if(!error){
        
        NSLog(@"%@",error);
    }
    
    //发送聊天消息和接受聊天消息
    CommandOrganization * command = [CommandOrganization new];
    //调用的是懒加载的test 的情况!
    //NSLog(@"sendHello == %s",command.sendHello);
    //NSLog(@"sendreset == %s",command.sendReset);
    //NSLog(@"sendStart == %s",command.sendStart);
    
}

#pragma mark - socket的代理的方法:
//连接成功服务器的判断是:都是通过我们的socket的 代理方法来实现的
-(void)socket:(GCDAsyncSocket *)clientsock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
    NSLog(@"与服务器连接成功!");
    //监听读取数据
    //注意的是:这里实现的是,每次的从buffer中来进行的取值1000个数来进行的处理
    //有可能的是这个方法没有自己来做缓存的buffer 会有数据的丢失的情况!
    #warning (添加警告的内容) 可能会有数据的不连续的情况!
    [clientsock readDataToLength:1000 withTimeout:-1 tag:0];
    
}

//Disconnect 断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
    NSLog(@"与服务器断开");
    if(err != nil){
        
        NSLog(@"%@",err);
    }
    
}

//通过socket来接收消息(read操作)
-(void)socket:(GCDAsyncSocket *)clientsock didReadData:(NSData *)data withTag:(long)tag{
    //这个是json的格 式来进行的操作!
    //才会通过字符串的形式来进行的转换
    //NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF16StringEncoding];
    
    NSUInteger partialLength = data.length;
    NSLog(@"新来一包了partialLength = %zd",partialLength);
    //通过的 test 的索引来进行的
    Testcount++;
    NSLog(@"记录的是当前对应的第几包的数据 %ld",Testcount);
    
    if(data.length == 1000){
        //要求的是每次只拿出一千个数来进行使用,不要进行的是:多拿的情况
        //先要求判断的buffer的缓存里面是否有数据
        NSMutableData * dataArray = [NSMutableData data];
        if(self.dataBufferArray.length != 0){
            //判断的是:当前的记录的索引之后的来取值
            if(self.bufferIndex != 0){
                Byte * tempbuffer = (Byte *)[self.dataBufferArray bytes];
                NSUInteger length = self.dataBufferArray.length - self.bufferIndex;//每次去截那个buffer里面的索引之后的所有的数据!
                
                //取地址的来进行的拼接
                dataArray = [NSMutableData dataWithBytes:&tempbuffer[(int)self.bufferIndex] length:length];
                [dataArray appendData:data];
                self.bufferIndex += length;
                
                
                
                }else{
                    
                //先拼接buffer里面的数值!
                [dataArray appendData:self.dataBufferArray];
                [dataArray appendData:data];
                self.bufferIndex += self.dataBufferArray.length;
            }
            
        }else{
            //最开始的第一次的产生的拼接的data的分支情况!
            [dataArray appendData:data];
        }
        //NSLog(@"self.dataArray.length = %ld",self.dataArray.length);
        //进行的是数据包的处理和解析查找:
        [self SeekDataPacket:dataArray];
        
        //NSLog(@"接受来的数据 self.dataArray = %@",self.dataArray);
        //要求的是:总是从最开头的数据来拿
        NSRange range = NSMakeRange(0, dataArray.length);
        
        [dataArray resetBytesInRange:range];
        
        //NSLog(@"接受来的数据 self.dataArray = %@",self.dataArray);
        //要求的是read之后继续的,继续的监听,继续的来进行从buffer中来拼接字节和数据
        [clientsock readDataToLength:1000 withTimeout:-1 tag:0];
        //要求进行的处理是:需要进行添加到一个队列中来进行的先进先出的循环的取值和删除数据!
        dataArray = nil;
    }
}

#pragma mark - 查找,拿出数据包的重要方法
-(void)SeekDataPacket:(NSData *)data{
    
    //通过token来进行的seek出来的一个整包:
    //实现的思路是:通过循环遍历整个data来进行的查找包头,直接通过的字节的数值来比较,如果发现是token的相同的值,我们就要求找headerLength和payloadLength还有的是packageType!合理的组成一包来进行传递下去
    //如果缓存buffer不为空的情况,要求拼接缓存
    Byte * tempAllByte = (Byte *)[data bytes];
    
    for (int i = 0; i < data.length; i++) {
        //如果i超过data.length - 2 就要求添加到缓存中来进行的等待的是下一包的数据
        if (i > data.length - 2)
        {
            //取字节存数组
            [self.dataBufferArray appendBytes:&tempAllByte[i] length:1];
            [self.dataBufferArray appendBytes:&tempAllByte[i +1] length:1];
            break;
        }
        NSLog(@"line381 I ZHI = %d",i);
        
        //进行的拿出每一个字节,进行的比较测试查找包头
        UInt8 tempByte = tempAllByte[i];
        UInt8 tempByte1 = tempAllByte[i + 1];
        
        if((tempByte == 0x50 && tempByte1 == 0x05) || (tempByte == 0xf0  && tempByte1 == 0x0f)){
            
            NSLog(@"line391 I ZHI = %d",i);
            //要求的进行的判断的token不对的情况下的逻辑的判断:
            NSMutableData * dataTotalArray = [NSMutableData data];
            
            //基本上是确定的找到token
            //然后的是:通过的是后四个字节来进行的判断的是否是真正的包头的内容信息!
            if(i+4 >= data.length ){
                //要求的是直接的将剩余的所有尾巴放入缓存中
                NSInteger tailLength = data.length - i;
                //循环的 buffer 的添加
                [self.dataBufferArray appendBytes:&tempAllByte[i] length:tailLength];
                break;
            }
            
            //可以进行的取出的 包的headerLength 和 payloadLength 的属性
            //数据的类型都是byte的类型
            self.headerLength = tempAllByte[i +2];
            self.payloadLength = tempAllByte[i +3] + (tempAllByte[i +4]<<8);
            
            
            int headerLength = (int) self.headerLength;
            int payloadpayLength = tempAllByte[i +3] + (tempAllByte[i +4]<<8);
            
            NSLog(@"header = %d,payloadLength = %d",headerLength,payloadpayLength);
            
            self.dataSuccess   = [NSMutableData data];
            self.HeadUnavailable = [NSMutableData data];
            [self.HeadUnavailable appendData:data];
            self.testBranch = [NSMutableData data];
            //新添加的逻辑的判断:
            if(headerLength + payloadpayLength + 4 > MAX_PackageLength){
                //直接的判断的是这个包是错误的类型,要求的是舍弃包头的操作
                break;//重新开始查找包头!
            }
            
            //接下来的是从data的字节流的情况:来进行的查找整个包的内容来进行的组包!
            //判断的情况是有三种的情况:
            if(i + headerLength + payloadpayLength + 4 < data.length){//一包的数据在这次的情况:
                //截取整个的数据包:
                NSInteger tailLength = headerLength + payloadpayLength + 4;
                
                //                for(int j = 0;j < tailLength;j ++){
                //                    //循环的 buffer 的添加
                //                    [self.dataTotalArray appendBytes:&tempAllByte[i +j] length:1];
                //                }
                
                [dataTotalArray appendBytes:&tempAllByte[i] length:tailLength];
                //test 打印测试拼接出来的数据正确性
                NSLog(@"test-->dataTotalArray=%@",dataTotalArray);
                
                //接下来的话:就是通过这个数据的解析来完成这个判断!
                [self AnalysisWithDataPackage:dataTotalArray];
                
                //通过解析的结果来进行的对这个i的值来处理
                if (self.reallyPackage == 0 ){//代表的是包头的查找的错误!
                    
                    i++;//Ignore The WrongPackage HeaderToken
                    
                }else{
                    i = i + headerLength + payloadpayLength + 4 - 1;
                }
                
                [self.testBranch appendData: self.dataBufferArray];
                
            }else if(i + headerLength + payloadpayLength + 4 == data.length){//数据整好是一包的情况:
                //截取整个的数据包:完成之后的话就可以返回来进行接收下一包的socket的了!
                NSInteger tailLength = i + headerLength + payloadpayLength + 4;
                
                //                for(int j = 0;j < tailLength;j ++){
                //                    //循环的 buffer 的添加
                //                    [self.dataTotalArray appendBytes:&tempAllByte[i +j] length:1];
                //                }
                [dataTotalArray appendBytes:&tempAllByte[i] length:tailLength];
                
                [self.dataSuccess appendData:data];
                
                NSLog(@"test+dataTotalArray=%@",dataTotalArray);
                //接下来的话:就是通过这个数据的解析来完成这个判断!
                [self AnalysisWithDataPackage:dataTotalArray];
                //通过解析的结果来进行的对这个i的值来处理
                if (self.reallyPackage == 0 ){//代表的是包头的查找的错误!
                    
                    i++;//Ignore The WrongPackage HeaderToken
                }
                
                [self.testBranch appendData: self.dataBufferArray];
                i = (int)data.length ;
                
            }else{//整体的都是不够一包的情况:全部的进行的缓存!
                
                NSInteger tailLength = data.length - i;
                //                for(int j = 0;j < tailLength;j ++){
                //                    //循环的 buffer 的添加
                //                    [self.dataBufferArray appendBytes:&tempAllByte[i +j] length:1];
                //                }
                [self.dataBufferArray appendBytes:&tempAllByte[i] length:tailLength];
                
                //测试添加的那个实际的 buffer 的情况!
                self.testBuffer = [NSMutableData data];
                [self.testBuffer appendData:self.dataBufferArray];
                i = (int)data.length;
            }
            
            dataTotalArray = nil;
        }
        
        //如果的是token是假的话,就逻辑的是自动的过滤掉这部分的操作来进行
        //测试的是缓存,溢出的情况!
        if (self.dataBufferArray.length > 2 * MAX_PackageLength) {
            //进行的是对buffer的整个的前移的情况;要求的是内存的空间的整体的前移:
            NSInteger bufferLength =  MAX_PackageLength;
            NSRange range = NSMakeRange(0, bufferLength);
            //前移1M 的数据:
            //data 的数据的删除,就是要求的是删除1M的数据
            [self.dataBufferArray replaceBytesInRange:range withBytes:NULL length:0];
            //[self.dataBufferArray appendBytes:&tempAllByte1[ MAX_PackageLength] length:bufferLength];
            //buffer 的前移补位完成!要求的是复位的操作!同样的也需要的是前移1M的数据情况!
            self.bufferIndex -= MAX_PackageLength;
            
        }
        
        NSLog(@"line502  I ZHI = %d",i);
    }
}

#pragma mark - 分析解包,解析数据的重要方法
-(void)AnalysisWithDataPackage:(NSData *)dataTotalArray{
    //实现的要求是:要求的是来判断我的这个取出来的包是否是正确的!
    //实现的思路是:要求的是传递的是取值出来的buffer的情况!实现的是查找到tail的token来进行的校验是正确的话,就可以来给属性来赋值进行的解包!
    //取出 dataBuffter 中的tailToken的值,来进行判断!
    Byte * tempAllByte = (Byte *)[dataTotalArray bytes];
    
    NSInteger length = dataTotalArray.length;
    //判断包的长度情况:要求的是一个包的长度的不能超过2k的理论的计算的点,超过了就是假包的情况!
//    if(length >  MAX_PackageLength){
//        //得到是一个假包!
//        self.reallyPackage = 0;//这个包是为 假的;得到的为假的话..这样就去掉那个包头,i这里有一个重新设置包头的情况!
//        return;
//        
//    }
    
    //取出最后的字节数组的情况
    //这里的话:还需要的是前两个byte转化成 uint_16的情况
    //缓存属性frameHeader
    NSMutableData * tempData = [NSMutableData data];
    NSMutableData * CRCData = [NSMutableData data];
    [CRCData appendBytes:&tempAllByte[2] length:(length -6)];
    Byte * crcByte = (Byte *)[CRCData bytes];
    CRC16_CCITT_H * crcTest = [CRC16_CCITT_H new];
    UInt16 ReallyCRC = [crcTest testCRC:crcByte andDataLength:(int)(length -6 )];
    
    [tempData appendBytes:&tempAllByte[0] length:2];
    //[tempData appendBytes:&tempAllByte[1] length:1];
    Byte * tempByte = (Byte *)[tempData bytes];
    UInt16 temp = (tempByte[1]<<8) + tempByte[0];
    self.baseFrame.frameHeader.Token = temp;
    self.headerToken = self.baseFrame.frameHeader.Token;
    
    tempData = nil;
    tempData = [NSMutableData data];
    self.baseFrame.frameHeader.HeaderLength = tempAllByte[2];
//    [CRCData appendBytes:&tempAllByte[2] length:1];
    
    [tempData appendBytes:&tempAllByte[3] length:2];
//    [CRCData appendBytes:&tempAllByte[3] length:2];
    Byte * tempByte0 = (Byte *)[tempData bytes];
    temp = (tempByte0[1]<<8) + tempByte0[0];
    self.baseFrame.frameHeader.PayloadLength = (UInt16)temp;
    
    tempData = nil;
    tempData = [NSMutableData data];
    self.baseFrame.frameHeader.PackageType = tempAllByte[5];
//    [CRCData appendBytes:&tempAllByte[5] length:1];
    
    //缓存frameTail
    //缓存的检验的CRC的字符数组!
    [tempData appendBytes:&tempAllByte[length - 4] length:2];
    Byte * tempByte1 = (Byte *)[tempData bytes];
    temp = (tempByte1[1]<<8) + tempByte1[0];
    self.baseFrame.frameTail.CRC  = temp;
    self.MisMacthCRC = ReallyCRC;
    
    //重点的是验证一个数据包的crc的问题
    if (ReallyCRC != self.baseFrame.frameTail.CRC) {
        //出现错包的crc 的情况!
        self.reallyPackage = 0;//这个包是为 假的;得到的为假的话..这样就去掉那个包头,i这里有一个重新设置包头的情况!
        return;
    }
    
    tempData = nil;
    tempData = [NSMutableData data];
    [tempData appendBytes:&tempAllByte[length - 2] length:2];
    Byte * tempByte2 = (Byte *)[tempData bytes];
    temp = (tempByte2[1]<<8) + tempByte2[0];
    self.baseFrame.frameTail.TailToken = temp;
    self.tailToken = self.baseFrame.frameTail.TailToken;
    
    //进行的手动的内存的释放!
    tempData = nil;
    tempData = [NSMutableData data];
    
    //解包的逻辑处理和判断
    if ((int)self.baseFrame.frameHeader.PayloadLength > Max_PayloadLength)
    {
        self.reallyPackage = 0;//这个包是为 假的;得到的为假的话..这样就去掉那个包头,i这里有一个重新设置包头的情况!
        return;
        
    }else if((self.baseFrame.frameHeader.Token == 0x0FF0 && self.baseFrame.frameTail.TailToken != 0xF00F) || (self.baseFrame.frameHeader.Token == 0x0550 && self.baseFrame.frameTail.TailToken != 0x5005)){
        
        //这里的有检测到 包头 和 包尾的对应的值的情况:
        self.reallyPackage = 0;//这个包是为 假的;得到的为假的话..这样就去掉那个包头,i这里有一个重新设置包头的情况!
        return;
        
    }else{
        //token有问题的检测逻辑的正确性的
        self.MisMacthToken = [NSMutableData data];
        
        //这个硬包是正确的!来进行的取出那个 packageType的属性
        //通过的是,检测的是那个PackageType.CommandResponse  和那个 PackageType.Alert的两个的分支的类型:
        UInt8 PackageType = self.baseFrame.frameHeader.PackageType;
        
        switch (PackageType) {
            case CommandResponse:{
                self.PackageType = PackageType;
                
                AcpCommandResponese * Responese = [AcpCommandResponese new];
                Responese.frameHeader = self.baseFrame.frameHeader;
                Responese.frameTail = self.baseFrame.frameTail;
            
                Responese.FrameSubHeader.ModuleType = tempAllByte[6];
                Responese.FrameSubHeader.CommandType = tempAllByte[7];
                
                //多组的测试commandType的情况
                self.CommandType = Responese.FrameSubHeader.CommandType;
                self.ModuleType = Responese.FrameSubHeader.ModuleType;
                
                Responese.FrameSubHeader.PacketID = tempAllByte[8];
                //测试选项的packetID
                self.PacketID = Responese.FrameSubHeader.PacketID;
                
                Responese.FrameSubHeader.CommandSequence = tempAllByte[9];
                Responese.FrameSubHeader.Result = tempAllByte[10];
                Responese.FrameSubHeader.ErrorCode = tempAllByte[11];
                
                //测试command的富余的属性
                self.CommandSequence = Responese.FrameSubHeader.CommandSequence;
                self.Result = Responese.FrameSubHeader.Result ;
                self.ErrorCode = Responese.FrameSubHeader.ErrorCode;
                
                [tempData appendBytes:&tempAllByte[12] length:1];
                [tempData appendBytes:&tempAllByte[13] length:1];
                [tempData appendBytes:&tempAllByte[14] length:1];
                [tempData appendBytes:&tempAllByte[15] length:1];
                
                //实现的是小端传输的方式:
                Byte * temp = (Byte *)[tempData bytes];
                Responese.FrameSubHeader.TimeStamp = temp[0] + (temp[1]<<8) + (temp[2]<<16) + (temp[3]<< 24);
                
                tempData = [NSMutableData data];
                self.TimeStamp = Responese.FrameSubHeader.TimeStamp;
                
                [tempData appendBytes:&tempAllByte[16] length:1];
                [tempData appendBytes:&tempAllByte[17] length:1];
                [tempData appendBytes:&tempAllByte[18] length:1];
                [tempData appendBytes:&tempAllByte[19] length:1];
                
                //实现的是小端传输的方式:
                Byte * temp1 = (Byte *)[tempData bytes];
                Responese.FrameSubHeader.TimeStampFromPowerOn = temp1[0] + (temp1[1]<<8) + (temp1[2]<<16) + (temp1[3]<< 24);
                self.TimeStampFromPowerOn = Responese.FrameSubHeader.TimeStampFromPowerOn;
                
                tempData = [NSMutableData data];
                //传递那个 paraArray的值!
                //从这个headerLength是包的索引..这个payloadLength是这个包的长度!
                int i = (int)self.baseFrame.frameHeader.HeaderLength;
//                for(int i = (int)self.baseFrame.frameHeader.HeaderLength; i < (int)self.baseFrame.frameHeader.PayloadLength;i++ ){
//                    [Responese.ResponseData.ParaArray appendBytes:&tempAllByte[i] length:1];
//                }
                [Responese.ResponseData.ParaArray appendBytes:&tempAllByte[i] length:(int)self.baseFrame.frameHeader.PayloadLength];
                break;
            }
            case Alert:{
                
                self.PackageType = PackageType;
                
                AcpAlert * alert = [AcpAlert new];
                alert.frameHeader = self.baseFrame.frameHeader;
                alert.frameTail = self.baseFrame.frameTail;
                
                //测试的是alertToken的情况!
                self.alertHeaderToken = alert.frameHeader.Token;
                self.alertTailToken = alert.frameTail.TailToken;
                
                alert.alertSubHeader.ModuleType = tempAllByte[6];
                alert.alertSubHeader.AlertType = tempAllByte[7];
                alert.alertSubHeader.PacketID = tempAllByte[8];
                
                [tempData appendBytes:&tempAllByte[9] length:1];
                [tempData appendBytes:&tempAllByte[10] length:1];
                [tempData appendBytes:&tempAllByte[11] length:1];
                [tempData appendBytes:&tempAllByte[12] length:1];
                
                Byte * temp = (Byte *)[tempData bytes];
                alert.alertSubHeader.TimeStamp = temp[0] + (temp[1]<<8) +(temp[2]<<16) +(temp[3]<<24);
                
                tempData = nil;
                tempData = [NSMutableData data];
                
                [tempData appendBytes:&tempAllByte[13] length:1];
                [tempData appendBytes:&tempAllByte[14] length:1];
                [tempData appendBytes:&tempAllByte[15] length:1];
                [tempData appendBytes:&tempAllByte[16] length:1];
                Byte * temp1 = (Byte *)[tempData bytes];
                alert.alertSubHeader.TimeStampFromPowerOn = temp1[0] + (temp1[1]<<8) +(temp1[2]<<16) +(temp1[3]<<24);
                
                tempData = nil;
                tempData = [NSMutableData data];
                
                //传递那个 paraArray的值!
                //从这个headerLength是包的索引..这个payloadLength是这个包的长度!
//                for(int i = (int)self.baseFrame.frameHeader.HeaderLength; i < (int)self.baseFrame.frameHeader.PayloadLength;i++ ){
//                    
//                    [alert.alertData.DataArray appendBytes:&tempAllByte[i] length:1];
//                }
                
                //测试的是alertHeader的subHeader的里面的重要的属性
                self.alertSubHeader = alert.alertSubHeader;
            
                //拿到了那个alert的data的数据流的情况!
                //拿出的是一个 24位的int类型数据流,扔到模型中来进行处理和转化!
                int i = (int)self.baseFrame.frameHeader.HeaderLength;
                
                //注意的是: 这个data数组的拼接将会拼接很大!
                alert.alertData.DataArray = [NSMutableData dataWithBytes:&tempAllByte[i] length:(int)self.baseFrame.frameHeader.PayloadLength];
                //每次传过来的是一串的字符数组!
                //[alert.alertData.DataArray appendBytes:&tempAllByte[i] length:(int)self.baseFrame.frameHeader.PayloadLength];
                self.lert = alert;
                break;
            }
            default:
                break;
        }
        //最后的是要求返回一个 succes的成功的消息来提过个
        self.reallyPackage = 1;
    }
}

#pragma mark - 关闭连接的方法
- (IBAction)closeSocket:(id)sender {
    
    //点击断开连接了!
    [self.clientSocket disconnect];
    
}

#pragma mark - socket发送消息到server的方法!
- (IBAction)sendButtonClick:(id)sender {
    
    //要求的发数据到客户的另一端:
    NSString * str = self.Text.text;
    
    if(str.length == 0){//无数据的发送
        
        return;
    }
    //发数据
    //只要是发数据,就是write的方法
    [self.clientSocket writeData:[str dataUsingEncoding:NSUTF16StringEncoding] withTimeout:-1 tag:0];
    
    //发送完了之后,就清空text
    self.Text.text = nil;
}

@end
