//
//  UIView+Frame.m
//  Runtimes
//
//  Created by 辉 on 16/1/27.
//  Copyright © 2016年 辉. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}


-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height
{
    return self.frame.size.height;
}


-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(CGFloat)centerX
{
    return self.center.x;
}


-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}


-(void)setLeftX:(CGFloat)leftX
{

    CGRect frame = self.frame;
    frame.origin.x = leftX;
    self.frame = frame;
}
-(CGFloat)leftX
{
    return self.frame.origin.x;
}


-(void)setTopY:(CGFloat)topY
{
    CGRect frame = self.frame;
    frame.origin.y = topY;
    self.frame = frame;
}
-(CGFloat)topY
{
    return self.frame.origin.y;
}


-(void)setRightX:(CGFloat)rightX
{
    CGRect frame = self.frame;
    frame.origin.y = rightX;
    self.frame = frame;
}
-(CGFloat)rightX
{
    return self.frame.origin.x + self.frame.size.width;
}


-(void)setBottomY:(CGFloat)bottomY
{
    CGRect frame = self.frame;
    frame.origin.y = bottomY;
    self.frame = frame;
}
-(CGFloat)bottomY
{
    return self.frame.size.height + self.frame.origin.y;
}



@end
