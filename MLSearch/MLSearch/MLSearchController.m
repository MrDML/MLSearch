//
//  MLSearchController.m
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "MLSearchController.h"

#import "UIView+MLTouch.h"
#import "UIView+MLViewContrller.h"
#import "UIView+MLFrame.h"
#import "UIViewController+MLStatusBarStyle.h"
#import "UIView+MLTableView.h"


static NSString * const CANCEL_SEARCH_KEY = @"CANCEL_SEARCH_KEY";
static NSString * const START_SEARCH_KEY = @"START_SEARCH_KEY";

@interface MLSearchController ()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation MLSearchController


- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController
{
    self = [super init];
    self.searchResultsController = searchResultsController;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelSearceEvevt) name:CANCEL_SEARCH_KEY object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startSearchEvent) name:START_SEARCH_KEY object:nil];
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.hidesNavigationBarDuringPresentation) {
         self.view.unTouchRect = CGRectMake(0, k_StatusBarHeight, [UIScreen mainScreen].bounds.size.width, k_StatusBarAndNavigationBarHeight-k_StatusBarHeight);
    }else{
         self.view.unTouchRect = CGRectMake(0, k_StatusBarAndNavigationBarHeight, [UIScreen mainScreen].bounds.size.width, 44);
    }
    [self.view addSubview:self.contentView];
    [self addChildViewController:self.searchResultsController];
    self.searchResultsController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.searchBar.frame.size.height - (iPhoneX ? 44 : 20));
    [self.contentView addSubview:self.searchResultsController.view];

}






- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"] && [self.searchResultsUpdater respondsToSelector:@selector(updateSearchResultsForSearchController:)]) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
    
}


- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:CANCEL_SEARCH_KEY object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:START_SEARCH_KEY object:nil];
    [self.searchBar removeObserver:self forKeyPath:@"text"];
    NSLog(@"已销毁");
}



#pragma mark -- lazy
- (MLSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[MLSearchBar alloc] init];
        [_searchBar addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _searchBar;
}


- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 1000000000, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.searchBar.frame.size.height - (iPhoneX ? 44 : 20))];
        _contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentView;
}

- (void)tapClick
{
   
}





#pragma mark -- 事件响应

- (void)startSearchEvent
{
    
    NSLog(@"点击了");

    if ([self.delegate respondsToSelector:@selector(willPresentSearchController:)]) {
        [self.delegate willPresentSearchController:self];
    }
    self.searchBar.ML_BelongViewController.mL_IsBarStyleLight = NO;
    [self.searchBar addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handGesture)]];
    [self.searchBar addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handGesture)]];
    
    
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [window.rootViewController addChildViewController:self];
//    UITabBarController *tab = (UITabBarController *)window.rootViewController;
//    UINavigationController *nav = tab.selectedViewController;
//    [nav.topViewController addChildViewController:self];
//    [nav.topViewController.view addSubview:self.view];
    
    NSLog(@"%@",self.view.findCurrentViewController);
    [self.view.findCurrentViewController addChildViewController:self];
    [self.view.findCurrentViewController.view addSubview:self.view];
//    NSLog(@"=======%@",nav.topViewController);
//    NSLog(@"=======%@",self.view.findCurrentViewController);

    if ([self.delegate respondsToSelector:@selector(didPresentSearchController:)]) {
        [self.delegate didPresentSearchController:self];
    }
    [self.searchBar setValue:@1 forKey:@"isEditing"];
    // 这要看他们之间是怎么建立的父子关系。如果是通过addChildViewController来添加的控制器，那么是可以在子控制器中通过self.parentViewController来访问到的。
    // self.searchBar.ML_BelongViewController.parentViewController 父视图控制器就是导航栏(UINavigationController) 首先要确定导航栏是否存在

    if (self.searchBar.ML_BelongViewController.parentViewController && [self.searchBar.ML_BelongViewController.parentViewController isKindOfClass:[UINavigationController class]] && self.hidesNavigationBarDuringPresentation) {
        
        [UIView animateWithDuration:0.2 animations:^{
            [(UINavigationController *)self.searchBar.ML_BelongViewController.parentViewController setNavigationBarHidden:YES animated:YES];

             self.contentView.y = k_StatusBarAndNavigationBarHeight;
        } completion:^(BOOL finished) {
        }];
    }
}




/**
 取消搜索
 */
- (void)cancelSearceEvevt
{
   

    if ([self.delegate respondsToSelector:@selector(willDismissSearchController:)]) {
        [self.delegate willDismissSearchController:self];
    }

    [self.searchBar setValue:@0 forKey:@"isEditing"];
    NSLog(@"%@",self.view.findCurrentViewController.childViewControllers);

    for (UIViewController *vc in self.view.findCurrentViewController.childViewControllers) {
        if ([vc isKindOfClass:[MLSearchController class]]) {
            [vc willMoveToParentViewController:nil];
            [vc removeFromParentViewController];
        }
    }

    [self.view removeFromSuperview];

    if ([self.delegate respondsToSelector:@selector(didDismissSearchController:)]) {
        [self.delegate didDismissSearchController:self];
    }

    if (self.searchBar.ML_BelongViewController.parentViewController && [self.searchBar.ML_BelongViewController.parentViewController isKindOfClass:[UINavigationController class]] && self.hidesNavigationBarDuringPresentation) {
        
        [UIView animateWithDuration:0.2 animations:^{
             [(UINavigationController *)self.searchBar.ML_BelongViewController.parentViewController setNavigationBarHidden:NO animated:YES];
             self.contentView.y = CGRectGetMaxY(self.searchBar.frame) + k_StatusBarAndNavigationBarHeight;
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)handGesture
{
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
