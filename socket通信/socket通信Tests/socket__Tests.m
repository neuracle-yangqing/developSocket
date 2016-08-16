//
//  socket__Tests.m
//  socket通信Tests
//
//  Created by neuracle on 16/8/11.
//  Copyright © 2016年 neuracle. All rights reserved.
//  实现的思路:通过的那个测试对应的类: 这个的方法是:包括的测试的类...和被测试的类!!!注意的是: 测试的方法必须以test开头!注意的是: 在测试类 运行的生命周期中,这两个方法可能的是多次运行的. 每一个单元测试用例 对应着测试类中的一个方法!
//  实用的方法是: 必须要求的拥有这个类的实用的属性: 才能来进行的实际的操作!
//  现在的是:测试的实际是当前的viewCon中的解包的情况:

#import <XCTest/XCTest.h>
#import "ViewController.h"
//导入枚举类
#import "acpEnum.h"


@interface socket__Tests : XCTestCase

@property(nonatomic, strong)ViewController * viewController;

@end

@implementation socket__Tests

- (void)setUp {//这个是初始化的方法! 这个是调用测试方法之前调用!
    
    [super setUp];
    //初始化这个,测试的方法!
    self.viewController = [[ViewController alloc]init];
    
}

- (void)tearDown {//这个是释放资源的方法! 这个是调用测试方法之后调用
    //测试完了,进行释放的方法!
    self.viewController = nil;
    
    [super tearDown];
    
}



#pragma mark - 测试用例的方法实现:
/**
 *  这个是测试用例的方法一:
 analysis的解包,header 和 token的检验!
 */
- (void)testExample1 {
    
    //定义的一个字节数组
    Byte test1[] = {0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0};
    int length =  sizeof(test1);
    NSMutableData * data = [NSMutableData data];
    [data appendBytes:&test1 length:length];
    
    //通过的是断言来进行的打印的判断的结果!
    [self.viewController AnalysisWithDataPackage:data];
    //进行调用的外接的赋值的属性:来通过传值的属性来进行的校验!
    //最后的是:通过断言的方式来进行最后的校验!
    XCTAssertTrue(self.viewController.tailToken == 0xF00F,@"期望值是: 0xF00F 实际的值是: %hu",self.viewController.tailToken);
    XCTAssertTrue(self.viewController.headerToken == 0x0FF0,@"期望值是: 0x0FF0 实际的值是: %hu",self.viewController.headerToken);
}

/**
 *  这个是测试用例的方法二:
 实现的是测试seek的截取包的长度的正确性!
 1.实现的过程的情况是:有 完整的成功的组包Success情况
 2.实现的是 包头不可用的情况:HeadUnavailable
 3.实现的是 找不到包尾的情况:需要的是添加到缓存的情况
 4.实现的是 错配的token  MisMacthToken
 5.实现的是 错配的CRC的错包的情况 MisMacthCRC
 */
- (void)testExample2_0 {
    //定义一个字节数组的值
    //测试的是:成功的数组seek方法!
    Byte test2[] = {0x09, 0x00, 0x00, 0x01, 0x50, 0x05, 0x09, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x96, 0xb8, 0x05, 0x50 };
    int length =  sizeof(test2);
    NSMutableData * data = [NSMutableData data];
    [data appendBytes:&test2 length:length];
    Byte * test3 = (Byte *)[data bytes];
    
    [self.viewController SeekDataPacket:data];
    
    //得到的结果是当前的byte数组了!
    Byte * Verification =  (Byte *)[self.viewController.dataSuccess bytes];
    
    //断言的判断:
    //注意的是:这里的都是byte *的指针的比较是不对的,要求的遍历值来进行的比较
    for (int i = 0; i < data.length; i++) {
        
        XCTAssertTrue(Verification[i] == test3[i],@"期望的值是: { 0x50, 0x05, 0x09, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x96, 0xb8, 0x05, 0x50 }  实际得到的值是:%hhu",Verification[i]);
    }
    
}

/**
 *  测试header的HeadUnavailable
 */
- (void)testExample2_1{
    //测试的是 包头不可用的情况
    Byte test2[] = { 0x09, 0x00, 0x00, 0x01,0x05, 0x09, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x96, 0xb8, 0x05, 0x50 };
    int length =  sizeof(test2);
    NSMutableData * data = [NSMutableData data];
    [data appendBytes:&test2 length:length];
    //Byte * test3 = (Byte *)[data bytes];
    
    [self.viewController SeekDataPacket:data];

    //有包的情况,不为空的情况是错的!
    XCTAssertTrue(self.viewController.HeadUnavailable == nil,@"期望的值是 : nil 实际的值是: %@",self.viewController.HeadUnavailable);
    
}

/**
 *  测试header的 等待的情况waiting,一共的测试的两组的数据
 */
- (void)testExample2_2{
    
    Byte test[] = { 0x50, 0x05, 0x09, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x96, 0xb8, 0x05 };
    int length =  sizeof(test);
    NSMutableData * data = [NSMutableData data];
    [data appendBytes:&test length:length];
    //测试 缓存和这个通道的添加没有数据!,实际的测试的结果是:缓存的buffer的里面的数据要求和test的来进行的对应!实际的分支里面没有数据的显示!
    
    [self.viewController SeekDataPacket:data];
    
    Byte * Verification =  (Byte *)[self.viewController.testBuffer bytes];
    //测速缓存的两种的不同的情况
    for (int i = 0; i < data.length; i++) {
    
        XCTAssertTrue(Verification[i] == test[i],@"期望的值是:{ 0x50, 0x05, 0x09, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x96, 0xb8, 0x05 }  实际得到的值为%hhu ",Verification[i]);
    
    }
    
    Byte test1[] = { 0x50, 0x05, 0x09, 0x03, 0x00, 0x01, 0x01, 0x01, 0x01, 0x96, 0xb8, 0x05, 0x50 };
    int length1 =  sizeof(test1);
    NSMutableData * data1 = [NSMutableData data];
    [data1 appendBytes:&test1 length:length1];
    //测试 缓存和这个通道的添加没有数据!
    [self.viewController SeekDataPacket:data1];
    
    Byte * Verification1 =  (Byte *)[self.viewController.testBuffer bytes];
    
    //测速缓存的两种的不同的情况
    for (int i = 0; i < data1.length; i++) {
        
        XCTAssertTrue(Verification1[i + data.length ] == test1[i],@"期望的值是:{ 0x50, 0x05, 0x09, 0x03, 0x00, 0x01, 0x01, 0x01, 0x01, 0x96, 0xb8, 0x05, 0x50 }  实际得到的值为%hhu ",Verification1[i + data.length]);
        
    }
    
    //最终的test 其他的通知的情况:
    XCTAssertTrue(self.viewController.testBranch.length == 0,@"期望得到的值是: nil 实际得到的值为 %@",self.viewController.testBranch);
}

/**
 *  测试header的 错误MisMacthToken 错误错配的token的值
 */
- (void)testExample2_3{
    //计算一个错误的token的情况!
    Byte test[] = { 0x50, 0x05, 0x09, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x96, 0xb8, 0x0F, 0x50 };
    int length =  sizeof(test);
    NSMutableData * data = [NSMutableData data];
    [data appendBytes:&test length:length];
    
    //错配的token的要求的是,舍弃那个包头的token的情况来进行的重新的来设定!
    [self.viewController SeekDataPacket:data];
    
    XCTAssertTrue(self.viewController.MisMacthToken == nil,@"期望值得到的值是: nil 实际的到的值为 %@",self.viewController.MisMacthToken);
}


/**
 *  测试header的 错误MisMacthCRC 错配的CRC的值!
 */
- (void)testExample2_4{
    Byte test[] = { 0x50, 0x05, 0x09, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x95, 0xb8, 0x05, 0x50 };
    int length =  sizeof(test);
    NSMutableData * data = [NSMutableData data];
    [data appendBytes:&test length:length];
    
    //传入的是:校验那个CRC的可选的情况!
    //等待CRC的校验的情况:
    [self.viewController SeekDataPacket:data];
    XCTAssertTrue(self.viewController.MisMacthCRC == nil,@"期望值得到的值是: nil 实际的到的值为 %@",self.viewController.MisMacthCRC);

}


/**
 *  测试用例的 PackageType 是包的属性的情况 分为两种的情况类型 CommandResponse
 要求实现的是:里面的所有的response的属性都要求正确的检测和确定的传值的成功!
 */
- (void)testExample3 {
    
    //1.先从packeageType的值来进行的测试:
    //定义一个字节数组的值
    Byte test[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length =  sizeof(test);
    NSMutableData * data = [NSMutableData data];
    [data appendBytes:&test length:length];
    //专门的进行的解包的测试的情况
    [self.viewController AnalysisWithDataPackage:data];
    XCTAssertTrue(self.viewController.PackageType == CommandResponse,@"期望的值是: CommandResponse 实际得到的值为 %hhu",self.viewController.PackageType);
    
    //2.检测的是,模型类中对应的属性的赋值的正确性!
    //检测的是 commandType的赋值的正确性的all
    Byte test1[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length1 =  sizeof(test1);
    [self testWithCommandType:&test1 andReallyCommandType:Hello andbyteArrayLength:length1];
    
    Byte test2[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x02, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length2 =  sizeof(test2);
    [self testWithCommandType:&test2 andReallyCommandType:Reset andbyteArrayLength:length2];

    Byte test3[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x03, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length3 =  sizeof(test3);
    [self testWithCommandType:&test3 andReallyCommandType:SetModPara andbyteArrayLength:length3];
    
    Byte test4[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x04, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length4 =  sizeof(test4);
    [self testWithCommandType:&test4 andReallyCommandType:SetDevPara andbyteArrayLength:length4];
    
    Byte test5[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x05, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length5 =  sizeof(test5);
    [self testWithCommandType:&test5 andReallyCommandType:Start andbyteArrayLength:length5];
    
    Byte test6[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x06, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length6 =  sizeof(test6);
    [self testWithCommandType:&test6 andReallyCommandType:GetDevStatus andbyteArrayLength:length6];
    
    
    Byte test7[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x07, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length7 =  sizeof(test7);
    [self testWithCommandType:&test7 andReallyCommandType:GetModStatus andbyteArrayLength:length7];

}

// 封装进行的抽类的情况!
-(void)testWithCommandType:(const void *)byteArray andReallyCommandType:(UInt8 )type andbyteArrayLength:(int)length{
    
    NSMutableData * data7 = [NSMutableData data];
    [data7 appendBytes:byteArray length:length];
    //专门的进行的解包的测试的情况
    [self.viewController AnalysisWithDataPackage:data7];
    XCTAssertTrue(self.viewController.CommandType == type,@"期望的值是: type 实际得到的值为 %hhu",self.viewController.CommandType);
    
}

- (void)testExamplePackageType_ModuleType {
    
    //进行的对respones中的属性的 ModuleType来进行的属性的赋值的测试:
    Byte test1[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x96, 0xb8, 0x0F, 0xF0 };
    int length1 =  sizeof(test1);
    [self testWithModuleType:&test1 andReallyCommandType:Device andbyteArrayLength:length1];
    
    Byte test2[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc6, 0xe1, 0x0F, 0xF0 };
    int length2 = sizeof(test2);
    [self testWithModuleType:&test2 andReallyCommandType:EEG andbyteArrayLength:length2];
    
    Byte test3[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x03, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf6, 0xd6, 0x0F, 0xF0 };
    int length3 = sizeof(test3);
    [self testWithModuleType:&test3 andReallyCommandType:Impedance andbyteArrayLength:length3];
    
    Byte test4[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x04, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x53, 0x0F, 0xF0 };
    int length4 = sizeof(test4);
    [self testWithModuleType:&test4 andReallyCommandType:Sound andbyteArrayLength:length4];
    
    Byte test5[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56, 0x64, 0x0F, 0xF0 };
    int length5 = sizeof(test5);
    [self testWithModuleType:&test5 andReallyCommandType:Light andbyteArrayLength:length5];
    
    Byte test6[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x06, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x3d, 0x0F, 0xF0 };
    int length6 = sizeof(test6);
    [self testWithModuleType:&test6 andReallyCommandType:SpO2 andbyteArrayLength:length6];

    Byte test7[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x07, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x36, 0x0a, 0x0F, 0xF0 };
    int length7 = sizeof(test7);
    [self testWithModuleType:&test7 andReallyCommandType:MEMS_ACC andbyteArrayLength:length7];
    
    Byte test8[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x08, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0x26, 0x0F, 0xF0 };
    int length8 = sizeof(test8);
    [self testWithModuleType:&test8 andReallyCommandType:MEMS_GYR andbyteArrayLength:length8];
    
    Byte test9[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x09, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x37, 0x11, 0x0F, 0xF0 };
    int length9 = sizeof(test9);
    [self testWithModuleType:&test9 andReallyCommandType:MEMS_MAG andbyteArrayLength:length9];
    
    Byte test10[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x0a, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x67, 0x48, 0x0F, 0xF0 };
    int length10 = sizeof(test10);
    [self testWithModuleType:&test10 andReallyCommandType:Temperature andbyteArrayLength:length10];
    
    Byte test11[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x0b, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x57, 0x7f, 0x0F, 0xF0 };
    int length11 = sizeof(test11);
    [self testWithModuleType:&test11 andReallyCommandType:Humidity andbyteArrayLength:length11];
    
    Byte test12[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x0c, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc7, 0xfa, 0x0F, 0xF0 };
    int length12 = sizeof(test12);
    [self testWithModuleType:&test12 andReallyCommandType:EnviromentLight andbyteArrayLength:length12];

    Byte test13[] ={ 0xF0, 0x0F, 0x14, 0x00, 0x00, 0x02, 0x0d, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf7, 0xcd, 0x0F, 0xF0 };
    int length13 = sizeof(test13);
    [self testWithModuleType:&test13 andReallyCommandType:Event andbyteArrayLength:length13];

}

-(void)testWithModuleType:(const void *)byteArray andReallyCommandType:(UInt8 )type andbyteArrayLength:(int)length{
    
    NSMutableData * data7 = [NSMutableData data];
    [data7 appendBytes:byteArray length:length];
    //专门的进行的解包的测试的情况
    [self.viewController AnalysisWithDataPackage:data7];
    XCTAssertTrue(self.viewController.ModuleType == type,@"期望的值是: type 实际得到的值为 %hhu",self.viewController.ModuleType);
    
}

/**
 *  测试用例的 PackageType 是包的属性的情况 分为两种的情况类型 Alert
 */
- (void)testExample4 {
    //定义一个字节数组的值
    //Byte test2[] =
    
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
