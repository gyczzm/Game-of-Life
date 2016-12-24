//
//  GOLGameManager.m
//  GameOfLife
//
//  Created by zhuxi on 2016/12/23.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "GOLGameManager.h"

@interface GOLGameManager ()

@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, strong) NSArray<NSMutableArray<NSNumber *> *> *gameState;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GOLGameManager

+ (instancetype)manager{
    static GOLGameManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GOLGameManager alloc] init];
        instance.isActive = NO;
    });
    return instance;
}

- (void)startOrPause
{
    if (!self.isActive) {
        self.isActive = YES;
        self.grid.userInteractionEnabled = NO;
        [self updateGameState];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    } else {
        self.isActive = NO;
        self.grid.userInteractionEnabled = YES;
        [self.timer invalidate];
    }
}

- (void)resetState
{
    if (self.isActive) {
        [self startOrPause];
    }
    self.gameState = [self zeroState];
    [self updateGrid];
}

#pragma mark - Private Methods

//Read initial state of grid
- (void)updateGameState
{
    NSInteger length = self.grid.length;
    
    for (int col = 0; col < length; col++) {
        for (int row = 0; row < length; row++) {
            GOLCell *cell = [self.grid cellAtPoint:CGPointMake(col, row)];
            self.gameState[col][row] = [NSNumber numberWithBool:cell.alive];
        }
    }
}

//Update grid according to gameState
- (void)updateGrid
{
    NSInteger length = self.grid.length;
    
    for (int col = 0; col < length; col++) {
        for (int row = 0; row < length; row++) {
            GOLCell *cell = [self.grid cellAtPoint:CGPointMake(col, row)];
            NSNumber *alive = self.gameState[col][row];
            cell.alive = alive.boolValue;
        }
    }
}

//Count neighbors of a cell at @location
//Assume cells out of boundry are all dead
- (NSUInteger)neighborComuntForLocation:(CGPoint)location
{
    NSUInteger col = location.x;
    NSUInteger row = location.y;
    
    NSInteger length = self.grid.length;
    NSUInteger neighborCount = 0;
    
    if (col > 0) {
        //left
        if (self.gameState[col - 1][row].boolValue) neighborCount++;
        
        //upper left
        if (row > 0) {
            if (self.gameState[col - 1][row - 1].boolValue) neighborCount++;
        }
        //lower left
        if (row < length - 1) {
            if (self.gameState[col - 1][row + 1].boolValue) neighborCount++;
        }
    }
    if (col < length - 1) {
        //right
        if (self.gameState[col + 1][row].boolValue) neighborCount++;
        
        //upper right
        if (row > 0) {
            if (self.gameState[col + 1][row - 1].boolValue) neighborCount++;
        }
        //lower right
        if (row < length - 1) {
            if (self.gameState[col + 1][row + 1].boolValue) neighborCount++;
        }
    }
    if (row > 0) {
        //top
        if (self.gameState[col][row - 1].boolValue) neighborCount++;
    }
    if (row < length - 1) {
        //bottom
        if (self.gameState[col][row + 1].boolValue) neighborCount++;
    }
    
    return neighborCount;
}

//Calculate the next state and update gridView
- (void)tick
{
    NSArray<NSMutableArray<NSNumber *> *> *newState = [self zeroState];
    
    NSInteger length = self.grid.length;
    
    for (int col = 0; col < length; col++) {
        for (int row = 0; row < length; row++) {
            NSInteger neighborCount = [self neighborComuntForLocation:CGPointMake(col, row)];
            
            //A cell with less than 2 neighbors dies of underpopulation
            if (neighborCount < 2) {
                newState[col][row] = @NO;
            }
            
            //A cell with 2 or 3 neighbors can live to the next tick
            if (neighborCount >= 2 && neighborCount <= 3 && self.gameState[col][row].boolValue) {
                newState[col][row] = @YES;
            }
            
            //A dead cell with 3 neighbors comes to life
            if (neighborCount == 3) {
                newState[col][row] = @YES;
            }
            
            //A cell with more than 3 neighbors dies of overpopulation
            if (neighborCount > 3) {
                newState[col][row] = @NO;
            }
        }
    }
    
    self.gameState = newState;
    [self updateGrid];
}

//Returns a state with no alive cell
- (NSArray<NSMutableArray<NSNumber *> *> *)zeroState
{
    NSInteger length = self.grid.length;
    
    NSMutableArray *tempStateArray = [NSMutableArray arrayWithCapacity:length];
    for (int col = 0; col < length; col++) {
        NSMutableArray *colArray = [NSMutableArray arrayWithCapacity:length];
        for (int row = 0; row < length; row++) {
            [colArray addObject:@0];
        }
        [tempStateArray addObject:colArray];
    }
    return [tempStateArray copy];
}

#pragma mark - Getters & Setters

- (void)setGrid:(GOLGrid *)grid
{
    _grid = grid;
    
    self.gameState = [self zeroState];
}

@end
