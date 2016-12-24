//
//  UIView+IBInspect.h
//  GameOfLife
//
//  Created by zhuxi on 2016/12/24.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IBInspect)

@property (nonatomic) IBInspectable CGFloat layerCornerRadius;
@property (nonatomic) IBInspectable UIColor *layerBorderColor;
@property (nonatomic) IBInspectable CGFloat layerBorderWidth;
@property (nonatomic) IBInspectable UIColor *layerShadowColor;
@property (nonatomic) IBInspectable CGFloat layerShadowOpacity;
@property (nonatomic) IBInspectable CGSize layerShadowOffset;
@property (nonatomic) IBInspectable CGFloat layerShadowRadius;

@end
