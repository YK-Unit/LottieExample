//
//  LoadingAnimViewController.m
//  LottieExample
//
//  Created by York on 2017/8/15.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import "LoadingAnimViewController.h"
#import <Lottie/Lottie.h>
#import "MBProgressHUD.h"
#import "UIView+EmptyStatus.h"

@interface HUDCustomView : UIView

@property (nonatomic,strong) LOTAnimationView *animView;

@end

@implementation HUDCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 60, 60)];
    if (self) {
        self.animView = [LOTAnimationView animationNamed:@"Loading"];
        self.animView.frame = self.bounds;
        [self addSubview:self.animView];
        self.animView.loopAnimation = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self.animView play];
    } else {
        [self.animView stop];
    }
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(60, 60);
}

@end


@interface LoadingAnimViewController ()

@end

@implementation LoadingAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    HUDCustomView *hudCustomView = [[HUDCustomView alloc] init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = hudCustomView;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        [self showEmptyTips];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showEmptyTips {
    [self.view showEmptyStatus:YES withTips:@"您当前没有任何订单~"];
}

@end

