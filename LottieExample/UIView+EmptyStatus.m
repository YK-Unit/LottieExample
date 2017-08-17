//
//  UIView+EmptyStatus.m
//  LottieExample
//
//  Created by York on 2017/8/15.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import "UIView+EmptyStatus.h"
#import <objc/runtime.h>
#import <Lottie/Lottie.h>


@interface UIView()

@property (nonatomic,strong) LOTAnimationView *animView;
@property (nonatomic,strong) UILabel *tipsLabel;

@end

@implementation UIView (EmptyStatus)

- (LOTAnimationView *)animView {
    LOTAnimationView *animView = objc_getAssociatedObject(self, _cmd);

    if (!animView) {
        animView = [LOTAnimationView animationNamed:@"EmptyStatus"];
        objc_setAssociatedObject(self,_cmd,animView, OBJC_ASSOCIATION_RETAIN);
    }

    return animView;
}

- (UILabel *)tipsLabel {
    UILabel *tipsLabel = objc_getAssociatedObject(self, _cmd);

    if (!tipsLabel) {
        tipsLabel = [[UILabel alloc] init];
        tipsLabel.textColor = [UIColor purpleColor];
        tipsLabel.font = [UIFont systemFontOfSize:15];

        objc_setAssociatedObject(self,_cmd,tipsLabel, OBJC_ASSOCIATION_RETAIN);
    }

    return tipsLabel;
}

- (void)showEmptyStatus:(BOOL)showed withTips:(NSString *)tips {
    if (showed) {
        if ([self.animView isDescendantOfView:self] == NO) {
            self.animView.frame = CGRectMake((self.frame.size.width - 200)/2, (self.frame.size.height - 102)/2 - 70, 200, 102);
            self.animView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:self.animView];

            self.animView.loopAnimation = YES;
            [self.animView play];
        }

        if ([self.tipsLabel isDescendantOfView:self] == NO) {
            self.tipsLabel.text = tips;
            [self.tipsLabel sizeToFit];
            CGRect tipsLabelFrame = self.tipsLabel.frame;
            tipsLabelFrame.origin.x = (self.frame.size.width - tipsLabelFrame.size.width)/2;
            tipsLabelFrame.origin.y = CGRectGetMaxY(self.animView.frame);
            self.tipsLabel.frame = tipsLabelFrame;
            [self addSubview:self.tipsLabel];
        }

        [self bringSubviewToFront:self.animView];
        [self bringSubviewToFront:self.tipsLabel];
    } else {
        [self.animView stop];
        [self.animView removeFromSuperview];

        [self.tipsLabel removeFromSuperview];
    }
}


@end
