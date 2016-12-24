//
//  GOLGameManager.h
//  GameOfLife
//
//  Created by zhuxi on 2016/12/23.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GOLGrid.h"

@interface GOLGameManager : NSObject

@property (nonatomic, strong) GOLGrid *grid;

+ (instancetype)manager;
//TODO: Add speed control
- (void)startOrPause;
- (void)resetState;

@end
