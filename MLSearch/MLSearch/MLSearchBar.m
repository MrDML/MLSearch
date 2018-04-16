//
//  MLSearchBar.m
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "MLSearchBar.h"
#import "MLSearchTextField.h"
#import "UIView+MLFrame.h"
#import "UIView+MLViewContrller.h"
#import "UIView+MLTableView.h"

static NSString * const CANCEL_SEARCH_KEY = @"CANCEL_SEARCH_KEY";
static NSString * const START_SEARCH_KEY = @"START_SEARCH_KEY";
@interface MLSearchBar ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) MLSearchTextField *textfield;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, assign) BOOL isEditing;
@end

@implementation MLSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    // 高度统一设定44 
    frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        [self addSubview:self.bgImageView];
        [self addSubview:self.textfield];
        [self addSubview:self.rightButton];
        [self addSubview:self.cancelButton];

        [self registNotifications];
    }
    return self;
}


- (void)registNotifications
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStatusBarOrientationChange) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}


/**
 设备方向
 */
- (void)onDeviceOrientationChange
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    if (orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown || orientation == UIDeviceOrientationUnknown ) { return; }
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"====");
        }
            break;
        case UIInterfaceOrientationPortrait:{
             NSLog(@"====");
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
           
             NSLog(@"====");
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"====");
        }
            break;
        default:
            break;
    }
}

- (void)onStatusBarOrientationChange
{
    // 获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (currentOrientation == UIInterfaceOrientationPortrait) {
        NSLog(@"竖直方向");
    } else {

    }
}


- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
      UITableView *tableView = self.ML_BelongViewController.view.ML_tableView;
    if (_isEditing) {
        
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            tableView.y = k_StatusBarAndNavigationBarHeight;
        } else {
            self.ML_BelongViewController.automaticallyAdjustsScrollViewInsets = NO;
            // Fallback on earlier versions
        }
        
        
        self.textfield.isTouch = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.height = 44+k_StatusBarHeight;
            tableView.y = 0;
            self.textfield.x = 10;
            self.bgImageView.width = [UIScreen mainScreen].bounds.size.width - 20 - 40;
            self.rightButton.x = [UIScreen mainScreen].bounds.size.width - 38 - 40;
            self.cancelButton.x = [UIScreen mainScreen].bounds.size.width - 40;

            self.bgImageView.y = 8 + k_StatusBarHeight;
            self.textfield.y =  0 + k_StatusBarHeight;
            self.rightButton.y = 8 + k_StatusBarHeight;
            self.cancelButton.y=  0 + k_StatusBarHeight;

        } completion:^(BOOL finished) {
            self.textfield.width = [UIScreen mainScreen].bounds.size.width - 20 - 38 - 40;
            [self.textfield becomeFirstResponder];
        }];


        

    }else{
        self.textfield.text = @"";
        self.text = @"";
        
        NSLog(@"取消按钮");
        self.textfield.isTouch = NO;

        [UIView animateWithDuration:0.2 animations:^{
            self.height = 44;
            tableView.y = k_StatusBarAndNavigationBarHeight;
            self.textfield.x = [UIScreen mainScreen].bounds.size.width * 0.5 - 20;
            self.bgImageView.width = [UIScreen mainScreen].bounds.size.width - 20;
            self.cancelButton.x = [UIScreen mainScreen].bounds.size.width;
            self.rightButton.x = [UIScreen mainScreen].bounds.size.width - 10 - 28;

            self.bgImageView.y = 8 ;
            self.textfield.y =  0;
            self.rightButton.y = 8;
            self.cancelButton.y=  0;
            
            NSLog(@"执行动画");

        } completion:^(BOOL finished) {
            
            self.textfield.width = [UIScreen mainScreen].bounds.size.width * 0.5 - 28;
            
            if (@available(iOS 11.0, *)) {
                tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            } else {
                self.ML_BelongViewController.automaticallyAdjustsScrollViewInsets = YES;
                // Fallback on earlier versions
            }
            tableView.y = 0;
            NSLog(@"完成动画");
           [self.textfield resignFirstResponder];
        }];
        
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
        
    }
}


/**
 取消搜索
 */
- (void)cancelSearchAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CANCEL_SEARCH_KEY object:self];
}


- (void)startSearceAction
{
    if (self.isEditing) {
        return;
        NSLog(@"已处于编辑状态");
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:START_SEARCH_KEY object:self];
}


#pragma mark - UITextFieldDelegate
// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarDidBeginEditing:)]) {
        [self.delegate searchBarDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.isEditing) {
        return;
        NSLog(@"已处于编辑状态");
    }
    if ([self.delegate respondsToSelector:@selector(searchBarDidBeginEditing:)]) {
        [self.delegate searchBarDidBeginEditing:self];
    }
}

- (void)textFieldDidChange
{
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:self.textfield.text];
    }
    self.text = self.textfield.text;
    if (self.textfield.text.length) {
        [_rightButton setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateHighlighted];
    } else {
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
    }
}



#pragma mark - lazy

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, [UIScreen mainScreen].bounds.size.width - 20, 44 - 16)];
        _bgImageView.image = [UIImage imageNamed:@"widget_searchbar_textfield"];
        _bgImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startSearceAction)];
        [_bgImageView addGestureRecognizer:tapgesture];
    }
    return _bgImageView;
}


- (MLSearchTextField *)textfield
{
    if (!_textfield) {
        _textfield = [[MLSearchTextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5 - 20 , 0 , [UIScreen mainScreen].bounds.size.width * 0.5 - 28, 44)];
//        _textfield.backgroundColor = [UIColor greenColor];
        _textfield.font = [UIFont systemFontOfSize:16];
        _textfield.placeholder = @"搜索";
        _textfield.leftView = self.searchIcon;
        _textfield.leftViewMode = UITextFieldViewModeAlways;
        _textfield.isTouch = NO;
        _textfield.delegate = self;
        [_textfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _textfield;
}


- (UIImageView *)searchIcon
{
    if (!_searchIcon) {
        _searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchContactsBarIcon"]];
        _searchIcon.frame = CGRectMake(0, 0, _searchIcon.image.size.width, _searchIcon.image.size.width);
        _searchIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _searchIcon;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
        _rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 28, 8, 28, 28);
        }
    
    return _rightButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        // 85, 183, 55, 1.0
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0 , 40, 44);
        [_cancelButton setTitleColor:[UIColor colorWithRed:85/255.0 green:183/255.0 blue:55/255.0 alpha:1] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton setTitle:@"取消  " forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelSearchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


- (void)dealloc
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"SearchBar 已销毁");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
