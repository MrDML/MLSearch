//
//  UIView+MLTouch.m
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "UIView+MLTouch.h"
#import <objc/message.h>

static const char * MLUNTOUCH_KEY = "MLUNTOUCH_KEY";
static const char * MLTOUCHRECT_KEY = "MLTOUCHRECT_KEY";

@implementation UIView (MLTouch)


+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pointInside:withEvent:)), class_getInstanceMethod(self, @selector(ML_PointInside:withEvent:)));
    
}


- (void)setUnTouch:(BOOL)unTouch
{
    objc_setAssociatedObject(self, MLUNTOUCH_KEY, [NSNumber numberWithInt:unTouch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)unTouch
{
    return objc_getAssociatedObject(self, MLUNTOUCH_KEY) ? [objc_getAssociatedObject(self, MLUNTOUCH_KEY) boolValue] : NO;
}


- (void)setUnTouchRect:(CGRect)unTouchRect
{
    objc_setAssociatedObject(self, MLTOUCHRECT_KEY, [NSValue valueWithCGRect:unTouchRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (CGRect)unTouchRect
{
    return objc_getAssociatedObject(self, MLTOUCHRECT_KEY) ? [objc_getAssociatedObject(self, MLTOUCHRECT_KEY) CGRectValue] : CGRectZero;
}





- (BOOL)ML_PointInside:(CGPoint)point withEvent:(UIEvent *)event
{
   
    if (self.unTouch == YES) {
        return NO;
    }
    if (self.unTouchRect.origin.x == 0 && self.unTouchRect.origin.y && self.unTouchRect.size.height == 0 && self.unTouchRect.size.width == 0) {
        [self ML_PointInside:point withEvent:event];
    }
    NSLog(@"%@",NSStringFromCGRect(self.unTouchRect));
    if (CGRectContainsPoint(self.unTouchRect, point)) {
        return NO;
    }else{
        NSLog(@"==== %d",[self ML_PointInside:point withEvent:event]);
        return [self ML_PointInside:point withEvent:event];
    }
    
    
    
}
















@end
