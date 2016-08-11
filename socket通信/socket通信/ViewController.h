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

/**
 *  test 的相应的属性
 */
@property(nonatomic, assign)UInt16 headerToken;

@property(nonatomic, assign)UInt16 tailToken;

@end

