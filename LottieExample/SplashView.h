//
//  SplashView.h
//  LottieExample
//
//  Created by York on 2017/8/12.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashView : UIView

- (void)showOnView:(UIView *)containerView withAnimationCompleter:(void(^)())completer;

@end
