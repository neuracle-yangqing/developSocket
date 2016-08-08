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
#import "ViewController.h"
#import <CFNetwork/CFNetwork.h>
#import <CoreFoundation/CoreFoundation.h>

#import "GCDAsyncSocket.h"

#import "CommandOrganization.h"

@interface ViewController ()<GCDAsyncSocketDelegate>

@property(nonatomic, strong)GCDAsyncSocket * clientSocket;

@property (weak, nonatomic) IBOutlet UITextField *Text;

//接受数据的属性;
@property(nonatomic, strong)NSMutableData * dataArray;

@end

@implementation ViewController

#pragma mark - 懒加载属性
-(NSMutableData *)dataArray{
    if(!_dataArray){
        
        _dataArray = [NSMutableData data];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //实现聊天室
    //1.连接到群聊服务器
    //1.1 创建一个客户端的socket 对象
    GCDAsyncSocket * clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    self.clientSocket = clientSocket;
    
    //1.2 发送连接的clientSocket
    NSError * error = nil;
    [clientSocket connectToHost:@"192.168.1.61" onPort:8080 error:&error];
    
    if(!error){
        
        NSLog(@"%@",error);
    }
    
    //发送聊天消息和接受聊天消息
    CommandOrganization * command = [CommandOrganization new];
    NSLog(@"sendHello == %s",command.sendHello);
    NSLog(@"sendreset == %s",command.sendReset);
    NSLog(@"sendStart == %s",command.sendStart);
    
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
    //这个是json的格式来进行的操作!
    //才会通过字符串的形式来进行的转换
    //NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF16StringEncoding];
    
    NSUInteger partialLength = data.length;
    NSLog(@"partialLength = %zd",partialLength);
    if(data.length == 1000){
        //要求的是每次只拿出一千个数来进行使用,不要进行的是:多拿的情况
        //接受
        [self.dataArray appendData:data];
        NSLog(@"self.dataArray = %ld",self.dataArray.length);
        //NSLog(@"接受来的数据 self.dataArray = %@",self.dataArray);
        //要求的是read之后继续的,继续的监听,继续的来进行从buffer中来拼接字节和数据
        [clientsock readDataToLength:1000 withTimeout:-1 tag:0];
    }
    
    
}

/**
 *  读取本分的data的操作来进行的处理:
 */
//-(void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
//    
//    
//    if(partialLength == 1000){
//        
//    
//        
//    }
//    
//    
//}

//这个是写的方法(部分的写操作)
//-(void)socket:(GCDAsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{//写部分
//    
//    
//}

//关闭连接会执行的方法:
//-(void)socketDidCloseReadStream:(GCDAsyncSocket *)sock{
//    
//    
//}

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
