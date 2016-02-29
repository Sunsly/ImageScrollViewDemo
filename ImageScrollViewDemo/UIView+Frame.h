//
//  UIView+Frame.h
//  Runtimes
//
//  Created by 辉 on 16/1/27.
//  Copyright © 2016年 辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/**
 *  view 的宽度
 */
@property (nonatomic,assign) CGFloat width;
/**
 *  view 的高度
 */
@property (nonatomic,assign) CGFloat height;
/**
 *  距离左侧的大小
 */
@property (nonatomic,assign) CGFloat leftX;
/**
 *  距离上侧的大小
 */
@property (nonatomic,assign) CGFloat topY;

/**
 *  x中心的
 */
@property (nonatomic,assign) CGFloat centerX;
/**
 *  y中心点
 */
@property (nonatomic,assign) CGFloat centerY;
/**
 *  右侧x
 */
@property (nonatomic,assign) CGFloat rightX;
/**
 *   下侧y
 */
@property (nonatomic,assign) CGFloat bottomY;
@end
