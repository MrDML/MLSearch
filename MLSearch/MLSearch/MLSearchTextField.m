//
//  MLSearchTextField.m
//  PrivateProjects
//
//  Created by 戴明亮 on 2018/4/9.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "MLSearchTextField.h"

@implementation MLSearchTextField


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // 设置初始值
        _isTouch = YES;
    }
    return self;
}
// 判断点在不在调用者的上面
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result = [super pointInside:point withEvent:event];
    if (_isTouch) {
        return result;
    }else{
        return NO;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
