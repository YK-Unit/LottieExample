//
//  SplashView.m
//  LottieExample
//
//  Created by York on 2017/8/12.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import "SplashView.h"
#import <Lottie/Lottie.h>

@interface SplashView()

@property (nonatomic,strong) LOTAnimationView *animationView;

@end

@implementation SplashView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    self.animationView = [LOTAnimationView animationNamed:@"LottieLogo"];
    self.animationView.contentMode = UIViewContentModeScaleAspectFill;
    self.animationView.frame = self.bounds;
    [self addSubview:self.animationView];

    return self;
}

- (void)showOnView:(UIView *)containerView withAnimationCompleter:(void(^)())completer {
    if (!containerView) {
        return;
    }

    [containerView addSubview:self];
    [self.animationView playWithCompletion:^(BOOL animationFinished) {
        if (completer) {
            completer();
        }
    }];
}


@end
