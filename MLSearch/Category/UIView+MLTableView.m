//
//  UIView+MLTableView.m
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/11.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "UIView+MLTableView.h"

@implementation UIView (MLTableView)


- (UIView *)ML_tableView
{
    if (self.subviews.count == 0 || self.subviews == nil) {
        return nil;
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITableView class]] ) {
            UITableView *tableView = (UITableView *)view;
            Class MLSearchBar =  NSClassFromString(@"MLSearchBar");
            if ([tableView.tableHeaderView isKindOfClass:MLSearchBar]) {
                return tableView;
                break;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }
     return nil;
}


/**
 

 */


@end
