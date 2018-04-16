//
//  UIView+MLViewContrller.h
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MLViewContrller)
/** 通过view获取当前的控制器 */
- (UIViewController *)ML_BelongViewController;
- (UIViewController*)findCurrentViewController;
@end
