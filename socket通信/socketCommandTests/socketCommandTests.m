//
//  socketCommandTests.m
//  socketCommandTests
//
//  Created by neuracle on 16/8/17.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CommandOrganization.h"
#import "acpEnum.h"

@interface socketCommandTests : XCTestCase

//定义属性来进行的强引用属性
@property(nonatomic, strong)CommandOrganization * commandOrganization;

@end

@implementation socketCommandTests

- (void)setUp {
    [super setUp];
    self.commandOrganization = [[CommandOrganization alloc]init];

}

- (void)tearDown {
    [super tearDown];
    self.commandOrganization = nil;//对象的释放
    
}

/**
 *  test 测试command的组包的测试用例
 */
//测试组包的情况 command 的包:
- (void)testCommandToken{
    
    UInt16 token = 0x0550;
    UInt16 tailToken = 0x5005;
    //CommandType.Hello
    NSLog(@"sendHello == %s",self.commandOrganization.sendHello);
    XCTAssertTrue(self.commandOrganization.token == token,@"期望的值是: 0x0550 实际得到的值是 %hu",self.commandOrganization.token);
    XCTAssertTrue(self.commandOrganization.tailToken == tailToken,@"期望的值是: 0x5005 实际得到的值是 %hu",self.commandOrganization.tailToken);
    
    //重新的赋值和组包
    token = 0x0FF0;
    tailToken = 0xF00F;
    
    //commandType.Reset
    NSLog(@"sendReset == %s",self.commandOrganization.sendReset);
    XCTAssertTrue(self.commandOrganization.token == token,@"期望的值是: 0x0FF0 实际得到的值是 %hu",self.commandOrganization.token);
    XCTAssertTrue(self.commandOrganization.tailToken == tailToken,@"期望的值是: 0xF00F 实际得到的值是 %hu",self.commandOrganization.token);
    
    token = 0x0FF0;
    tailToken = 0xF00F;
    //commandType.Start
    NSLog(@"sendStart == %s",self.commandOrganization.sendStart);
    XCTAssertTrue(self.commandOrganization.token == token,@"期望的值是: 0x0FF0 实际得到的值是 %hu",self.commandOrganization.token);
    XCTAssertTrue(self.commandOrganization.tailToken == tailToken,@"期望的值是: 0x0FF0 实际得到的值是 %hu",self.commandOrganization.token);
    
}

- (void)testCommandLength{
    
    UInt8 headerlength = 0x09;
    
    //CommandType.Hello
    NSLog(@"sendHello == %s",self.commandOrganization.sendHello);
    XCTAssertTrue(self.commandOrganization.headerLength == headerlength,@"期望的值是: 0x09 实际得到的值是 %hu",self.commandOrganization.token);
    
    //commandType.Reset
    NSLog(@"sendReset == %s",self.commandOrganization.sendReset);
    XCTAssertTrue(self.commandOrganization.headerLength == headerlength,@"期望的值是: 0x09 实际得到的值是 %hu",self.commandOrganization.token);
    
    //commandType.Start
    NSLog(@"sendStart == %s",self.commandOrganization.sendStart);
    XCTAssertTrue(self.commandOrganization.headerLength == headerlength,@"期望的值是: 0x09 实际得到的值是 %hu",self.commandOrganization.token);
    
}

- (void)testCommandPayloadLength{
    UInt8 payLoadLength = 0x0000;
    
    NSLog(@"sendHello == %s",self.commandOrganization.sendHello);
    XCTAssertTrue(self.commandOrganization.payLoadLength == payLoadLength,@"期望的值是: 0x0000 实际得到的值是 %hu",self.commandOrganization.payLoadLength);
    
    NSLog(@"sendReset == %s",self.commandOrganization.sendReset);
    XCTAssertTrue(self.commandOrganization.payLoadLength == payLoadLength,@"期望的值是: 0x0000 实际得到的值是 %hu",self.commandOrganization.payLoadLength);
    
    payLoadLength = 0x0000;
    NSLog(@"sendStart == %s",self.commandOrganization.sendStart);
    XCTAssertTrue(self.commandOrganization.payLoadLength == payLoadLength,@"期望的值是: 0x0000 实际得到的值是 %hu",self.commandOrganization.payLoadLength);
}

- (void)testCommandPackageType{
    
    UInt8 packageType = Command;
    NSLog(@"sendHello == %s",self.commandOrganization.sendHello);
    XCTAssertTrue(self.commandOrganization.packageType == packageType,@"期望的值是: 0x01 实际得到的值是 %hhu",self.commandOrganization.packageType);
    
    NSLog(@"sendReset == %s",self.commandOrganization.sendReset);
    XCTAssertTrue(self.commandOrganization.packageType == packageType,@"期望的值是: 0x01 实际得到的值是 %hhu",self.commandOrganization.packageType);
    
    NSLog(@"sendStart == %s",self.commandOrganization.sendStart);
    XCTAssertTrue(self.commandOrganization.packageType == packageType,@"期望的值是: 0x01 实际得到的值是 %hhu",self.commandOrganization.packageType);
    
}

- (void)testCommandModuleType_Device{
    UInt8 ModuleType = Device;
    
    NSLog(@"sendHello == %s",self.commandOrganization.sendHello);
    XCTAssertTrue(self.commandOrganization.ModuleType == ModuleType,@"期望的值是: 0x01 实际得到的值是 %hhu",self.commandOrganization.ModuleType);
    NSLog(@"sendReset == %s",self.commandOrganization.sendReset);
    XCTAssertTrue(self.commandOrganization.ModuleType == ModuleType,@"期望的值是: 0x01 实际得到的值是 %hhu",self.commandOrganization.ModuleType);
    NSLog(@"sendStart == %s",self.commandOrganization.sendStart);
    XCTAssertTrue(self.commandOrganization.ModuleType == ModuleType,@"期望的值是: 0x01 实际得到的值是 %hhu",self.commandOrganization.ModuleType);
    
}

- (void)testCommand_CommandType{
    
    UInt8 commandType = Hello;
    NSLog(@"sendHello == %s",self.commandOrganization.sendHello);
    XCTAssertTrue(self.commandOrganization.CommandType == commandType,@"期望的值是: Hello 实际得到的值是 %hhu",self.commandOrganization.ModuleType);
    
    commandType = Reset;
    NSLog(@"sendReset == %s",self.commandOrganization.sendReset);
    XCTAssertTrue(self.commandOrganization.CommandType == commandType,@"期望的值是: Reset 实际得到的值是 %hhu",self.commandOrganization.ModuleType);
    
    commandType = Start;
    NSLog(@"sendStart == %s",self.commandOrganization.sendStart);
    XCTAssertTrue(self.commandOrganization.CommandType == commandType,@"期望的值是: Start 实际得到的值是 %hhu",self.commandOrganization.ModuleType);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
