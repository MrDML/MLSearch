//
//  MLSearchController.h
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSearchDefin.h"
#import "MLSearchBar.h"
@class MLSearchController;

@protocol MLSearchControllerDelegate <NSObject>

@optional
- (void)willPresentSearchController:(MLSearchController *)searchController;
- (void)didPresentSearchController:(MLSearchController *)searchController;
- (void)willDismissSearchController:(MLSearchController *)searchController;
- (void)didDismissSearchController:(MLSearchController *)searchController;
// Called after the search controller's search bar has agreed to begin editing or when 'active' is set to YES. If you choose not to present the controller yourself or do not implement this method, a default presentation is performed on your behalf.
- (void)presentSearchController:(MLSearchController *)searchController;
@end

@protocol MLSearchResultsUpdating <NSObject>
@required
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(MLSearchController *)searchController;
@end



@interface MLSearchController : UIViewController

@property (nonatomic, weak) id <MLSearchControllerDelegate>delegate;
@property (nonatomic, weak) id <MLSearchResultsUpdating> searchResultsUpdater;

//是否需要隐藏现有的导航栏
@property (nonatomic, assign) BOOL hidesNavigationBarDuringPresentation;
@property (nonatomic, strong) MLSearchBar *searchBar;
@property (nonatomic, strong) UIViewController *searchResultsController;
- (instancetype)initWithSearchResultsController:(nullable UIViewController *)searchResultsController;
@end
