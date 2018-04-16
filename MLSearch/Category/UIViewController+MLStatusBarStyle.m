//
//  UIViewController+MLStatusBarStyle.m
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/11.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "UIViewController+MLStatusBarStyle.h"
#import <objc/message.h>

static const char * MLSTATUSBARSTYLE_KEY = "MLSTATUSBARSTYLE_KEY";

@implementation UIViewController (MLStatusBarStyle)

- (void)setML_IsBarStyleLight:(BOOL)mL_IsBarStyleLight
{
    objc_setAssociatedObject(self, MLSTATUSBARSTYLE_KEY, [NSNumber numberWithBool:mL_IsBarStyleLight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)mL_IsBarStyleLight
{
    return  objc_getAssociatedObject(self, MLSTATUSBARSTYLE_KEY) ?  [objc_getAssociatedObject(self, MLSTATUSBARSTYLE_KEY) boolValue] : NO;
}


/*
 UIStatusBarStyleDefault                                     = 0, // Dark content, for use on light backgrounds
 UIStatusBarStyleLightContent
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.mL_IsBarStyleLight ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

@end
