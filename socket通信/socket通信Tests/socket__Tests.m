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
    XCTAssertTrue(self.viewController.tailToken == 0xF00F);
    XCTAssertTrue(self.viewController.headerToken == 0x0FF0,@"期望值是: 0x0ff0 实际的值是: %hu",self.viewController.headerToken);
    
}

/**
 *  这个是测试用例的方法二:
 */
- (void)testExample2 {
    
    
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
