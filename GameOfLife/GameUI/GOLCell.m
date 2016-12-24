//
//  GOLCell.m
//  GameOfLife
//
//  Created by zhuxi on 2016/12/23.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "GOLCell.h"
#import "Colors.h"

@implementation GOLCell

- (instancetype)initWithLength:(CGFloat)length
{
    CGRect frame = CGRectMake(0, 0, length, length);
    if (self = [super initWithFrame:frame]) {
        self.alive = NO;
        
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = UIColorWithRGBA(112, 112, 112, 0.5).CGColor;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liveOrDie)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)liveOrDie
{
    self.alive = !self.alive;
}

- (void)setAlive:(BOOL)alive
{
    _alive = alive;
    
    if (alive) {
        [UIView animateWithDuration:0.1 animations:^{
            self.backgroundColor = [UIColor blackColor];
        }];
    }
    else {
        [UIView animateWithDuration:0.1 animations:^{
            self.backgroundColor = [UIColor whiteColor];
        }];
    }
}

@end
