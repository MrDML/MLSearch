//
//  MLSearchBar.h
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSearchDefin.h"

@class MLSearchBar;

@protocol MLSearchBarDelegate <NSObject>

@optional
- (void)searchBarDidBeginEditing:(MLSearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(MLSearchBar *)searchBar;
- (void)searchBar:(MLSearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

@interface MLSearchBar : UIView
@property (nonatomic, assign) id <MLSearchBarDelegate>delegate;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *text;
@end
