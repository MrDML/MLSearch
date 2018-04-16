//
//  UIView+MLTouch.h
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MLTouch)

/**
 是否能够响应tocuh事件
 */
@property (nonatomic, assign) BOOL unTouch;

/**
 不响应touch事件的区域
 */
@property (nonatomic, assign) CGRect unTouchRect;
@end
