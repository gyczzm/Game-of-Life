//
//  GOLGrid.h
//  GameOfLife
//
//  Created by zhuxi on 2016/12/23.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GOLCell.h"

@interface GOLGrid : UIView
//Number of cells per edge
@property (nonatomic, assign) NSInteger length;

- (GOLCell *)cellAtPoint:(CGPoint)point;

@end
