//
//  UIView+MLFrame.m
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/10.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "UIView+MLFrame.h"

@implementation UIView (MLFrame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)y
{
    return self.frame.origin.y;
}



- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}


- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}


- (void)setOrigan:(CGPoint)origan
{
    CGRect frame = self.frame;
    frame.origin = origan;
    self.origan = origan;
}

- (CGPoint)origan
{
    return self.frame.origin;
}






@end
