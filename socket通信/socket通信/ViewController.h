//
//  ViewController.h
//  socket通信
//
//  Created by neuracle on 16/8/2.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 *  外部调用解包的方法!
 */
-(void)AnalysisWithDataPackage:(NSData *)dataTotalArray;

-(void)SeekDataPacket:(NSData *)data;


/**
 *  test 的相应的属性
 */
@property(nonatomic, assign)UInt16 headerToken;

@property(nonatomic, assign)UInt16 tailToken;

@property(nonatomic, strong)NSMutableData * dataSuccess;

@property(nonatomic, strong)NSMutableData * HeadUnavailable;

@property(nonatomic, strong)NSMutableData * testBuffer;

@property(nonatomic, strong)NSMutableData * testBranch;

@property(nonatomic, strong)NSMutableData * MisMacthToken;//进行的错包的,扔掉token的设置的情况!

@property(nonatomic, strong)NSMutableData * MisMacthCRC;//进行的CRC的运行的结果的测试!

/**
 *  test analysis的核心 PackageType 的解包的情况
 */
//测试的test 返回的是那个 commandResponse
@property(nonatomic, assign)UInt8 PackageType;

@property(nonatomic, assign)UInt8 CommandType;//CommandType的所有的了类型的测试的检测

@property(nonatomic,assign)UInt8 ModuleType;//ModuleType的所有的类型的测试的检测

//@property(nonatomic,assign)UInt16 Token;



@end

