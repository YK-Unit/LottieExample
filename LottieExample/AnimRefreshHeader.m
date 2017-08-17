//
//  AnimRefreshHeader.m
//  LottieExample
//
//  Created by York on 2017/8/13.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import "AnimRefreshHeader.h"
#import <Lottie/Lottie.h>

@interface AnimRefreshHeader()

@property (nonatomic,strong) LOTAnimationView *animView;

@end

@implementation AnimRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];

    self.backgroundColor = [UIColor whiteColor];

    // 设置控件的高度
    self.mj_h = 80;

    //anim
    self.animView = [LOTAnimationView animationNamed:@"RefreshHeaderAnim"];
    self.animView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.animView];
    self.animView.loopAnimation = YES;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

    self.animView.bounds = CGRectMake(0, 0, 80, 80);
    self.animView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
            [self.animView stop];
            break;
        case MJRefreshStatePulling:
            [self.animView pause];
            break;
        case MJRefreshStateRefreshing:
            [self.animView play];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];

    if (self.state != MJRefreshStateIdle) return;

    self.animView.animationProgress = pullingPercent;
}


@end
