//
//  GOLGrid.m
//  GameOfLife
//
//  Created by zhuxi on 2016/12/23.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "GOLGrid.h"

@interface GOLGrid ()

@property (nonatomic, strong) NSArray<NSArray<GOLCell *> *> *cells;

@end

@implementation GOLGrid

- (GOLCell *)cellAtPoint:(CGPoint)point
{
    NSUInteger col = point.x;
    NSUInteger row = point.y;
    
    if (row >= self.length || col >= self.length) {
        return nil;
    }
    
    return self.cells[col][row];
}

- (void)layoutSubviews
{
    CGFloat cellLength = MIN(self.frame.size.height, self.frame.size.width) / self.length;
    
    for (int col = 0; col < self.length; col++) {
        for (int row = 0; row < self.length; row++) {
            GOLCell *cell = [self cellAtPoint:CGPointMake(col, row)];
            CGPoint cellOrigin = CGPointMake(col * cellLength, row * cellLength);
            cell.frame = CGRectMake(cellOrigin.x, cellOrigin.y, cellLength, cellLength);
        }
    }
}

- (void)setLength:(NSInteger)length
{
    _length = length;
    
    CGFloat cellLength = MIN(self.frame.size.height, self.frame.size.width) / length;
    
    NSMutableArray *tempCellArray = [NSMutableArray arrayWithCapacity:length];
    for (int col = 0; col < length; col++) {
        NSMutableArray *cellColArray = [NSMutableArray arrayWithCapacity:length];
        for (int row = 0; row < length; row++) {
            GOLCell *cell = [[GOLCell alloc] initWithLength:cellLength];
            CGPoint cellOrigin = CGPointMake(col * cellLength, row * cellLength);
            cell.frame = CGRectMake(cellOrigin.x, cellOrigin.y, cellLength, cellLength);
            [self addSubview:cell];
            [cellColArray addObject:cell];
        }
        [tempCellArray addObject:[cellColArray copy]];
    }
    _cells = [tempCellArray copy];
}

@end
