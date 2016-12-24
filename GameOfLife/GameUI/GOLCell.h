//
//  GOLCell.h
//  GameOfLife
//
//  Created by zhuxi on 2016/12/23.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOLCell : UIView

@property (nonatomic, assign) BOOL alive;

- (instancetype)initWithLength:(CGFloat)length;

@end
