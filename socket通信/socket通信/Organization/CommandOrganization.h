//
//  CommandOrganization.h
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandOrganization : NSObject
/*
 所有的命令行的属性的表
 */
@property(nonatomic, assign)Byte * sendHello;

@property(nonatomic, assign)Byte * sendReset;

@property(nonatomic,assign)Byte * sendStart;

@end