//
//  MLSearchDefin.h
//  MLSearch
//
//  Created by 戴明亮 on 2018/4/16.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#ifndef MLSearchDefin_h
#define MLSearchDefin_h
/*! 状态栏高度 iPhoneX :20 + 44 ,iPhone:20*/
#define  k_StatusBarHeight    [UIApplication sharedApplication].statusBarFrame.size.height
/*! 导航栏的高度 */
#define  k_NavigationBarHeight  44.f

/*! 状态栏高度 + 导航栏高度 */
#define  k_StatusBarAndNavigationBarHeight   (k_StatusBarHeight + k_NavigationBarHeight)

/*! 适配iPhone X Tabbar距离底部的距离 */
#define  K_TabbarSafeBottomMargin         (k_StatusBarHeight > 20 ? 34.f : 0.f)

/*! 适配iPhone X Tabbar高度 */
#define  K_TabbarHeight         (49.f + K_TabbarSafeBottomMargin)

/** 设备是否为iiPhone X  分辨率375x812，像素750x1624，@3x */
#define  iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)

#endif /* MLSearchDefin_h */
