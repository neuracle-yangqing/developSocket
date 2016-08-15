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

@end

