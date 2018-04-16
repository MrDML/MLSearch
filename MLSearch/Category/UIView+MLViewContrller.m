//
//  UIView+MLViewContrller.m
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "UIView+MLViewContrller.h"

@implementation UIView (MLViewContrller)

/**
 根据view得到当前viewController
 此方法是以 “消息响应者链” 为根据 。
 
 UIView先响应，如果响应不了，那么如果它有控制器的话就会把消息丢给它的控制器响应，如果没有控制器，那么就丢给它的superView来响应。

 @return 返回一个归属的控制器
 */
- (UIViewController *)ML_BelongViewController
{
    //通过响应者链，获得view所在的视图控制器
    UIResponder *next = [self nextResponder];
    do {
         //判断响应者对象是否是视图控制器类型
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

- (UIViewController*)findCurrentViewController
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    
    while (true) {
        
        if (topViewController.presentedViewController) {
            
            topViewController = topViewController.presentedViewController; // 直接是控制器
            
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            
            topViewController = [(UINavigationController *)topViewController topViewController]; //2.进入该分支 获取到导航栏顶部的控制器
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController; // 1, 出来是导航栏 然后再次循环
            
        } else {
            break; // 跳出循环
        }
        
        NSLog(@"一直无线循环");
    }
    return topViewController;
}

- (UIViewController *)getCurrentViewController
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        //2、通过navigationcontroller弹出VC
        NSLog(@"subviews == %@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){//1、tabBarController
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //或者 UINavigationController * nav = tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){//2、navigationController
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{//3、viewControler
        result = nextResponder;
    }
    return result;
}



//- (UIViewController *)currentShowViewController
//{
//
//
//
//}
//










@end
