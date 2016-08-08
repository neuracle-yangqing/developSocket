//
//  AcpCommandFrame.h
//  socket通信
//
//  Created by neuracle on 16/8/3.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandSubHeader.h"
#import "CommandData.h"


@interface AcpCommandFrame : NSObject

@property(nonatomic, strong)CommandSubHeader * subHeader;

@property(nonatomic, strong)CommandData * CommandData;

@end
