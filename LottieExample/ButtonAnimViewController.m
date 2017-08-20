//
//  ButtonAnimViewController.m
//  LottieExample
//
//  Created by York on 2017/8/13.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import "ButtonAnimViewController.h"
#import <Lottie/Lottie.h>

@interface ButtonAnimViewController ()

@property (nonatomic,strong) LOTAnimationView *switchButton;
@property (nonatomic,assign) BOOL isOff;

@property (nonatomic,strong) LOTAnimationView *editButton;
@property (nonatomic,assign) BOOL isEditing;

@property (nonatomic,strong) LOTAnimationView *playButton;
@property (nonatomic,assign) BOOL isPlaying;

@end

@implementation ButtonAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

    self.switchButton = [LOTAnimationView animationNamed:@"Switch"];
    self.switchButton.contentMode = UIViewContentModeScaleAspectFit;
    //switchButton的width和height从AE文件中获得
    self.switchButton.frame = CGRectMake(10, 100, 216/2, 116/2);
    UITapGestureRecognizer *switchButtonTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchButtonClicked)];
    [self.switchButton addGestureRecognizer:switchButtonTapGR];
    [self.view addSubview:self.switchButton];
    [self.switchButton setValue:[UIColor orangeColor] forKeypath:@"Background 2.Shape 1.Fill 1.Color" atFrame:@(0)];
    [self.switchButton setValue:[UIColor blueColor] forKeypath:@"Background 2.Shape 1.Fill 1.Color" atFrame:@(13)];
    [self.switchButton logHierarchyKeypaths];

    self.editButton = [LOTAnimationView animationNamed:@"Edit"];
    self.editButton.contentMode = UIViewContentModeScaleAspectFit;
    //editButton的width和height从AE文件中获得
    self.editButton.frame = CGRectMake(150, 100, 124/2, 124/2);
    UITapGestureRecognizer *editButtonTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editButtonClicked)];
    [self.editButton addGestureRecognizer:editButtonTapGR];
    [self.view addSubview:self.editButton];
    [self.editButton setProgressWithFrame:@(54)];

    self.playButton = [LOTAnimationView animationNamed:@"Play-Pause"];
    self.playButton.contentMode = UIViewContentModeScaleAspectFit;
    //playButton的width和height从AE文件中获得
    self.playButton.frame = CGRectMake(230, 100, 160/2, 160/2);
    UITapGestureRecognizer *playButtonTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playButtonClicked)];
    [self.playButton addGestureRecognizer:playButtonTapGR];
    [self.view addSubview:self.playButton];
    [self.playButton setProgressWithFrame:@(50)];


    UIButton *giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    giftButton.frame = CGRectMake(10, 200, 240, 30);
    [giftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [giftButton setTitle:@"播放高级礼物动画" forState:UIControlStateNormal];
    [giftButton addTarget:self action:@selector(giftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:giftButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
- (void)switchButtonClicked {
    if (self.isOff) {
        [self.switchButton playFromFrame:@(13) toFrame:@(0) withCompletion:nil];
        NSLog(@"打开开关...");
    } else {
        [self.switchButton playFromFrame:@(0) toFrame:@(13) withCompletion:nil];
        NSLog(@"关闭开关...");
    }

    self.isOff = !self.isOff;
}

- (void)editButtonClicked {
    if (self.isEditing) {
        [self.editButton setProgressWithFrame:@(166)];
        [self.editButton playFromFrame:@(166) toFrame:@(218) withCompletion:nil];

        NSLog(@"结束编辑...");
    } else {
        [self.editButton setProgressWithFrame:@(54)];
        [self.editButton playFromFrame:@(54) toFrame:@(105) withCompletion:nil];

        NSLog(@"开始编辑...");
    }

    self.isEditing = !self.isEditing;
}

- (void)playButtonClicked {
    __weak typeof(self) weakSelf = self;


    self.playButton.loopAnimation = NO;
    self.playButton.autoReverseAnimation = NO;

    if (self.isPlaying) {
        [self.playButton setProgressWithFrame:@(180)];
        [self.playButton playFromFrame:@(180) toFrame:@(213) withCompletion:^(BOOL animationFinished) {
        }];

    } else {
        [self.playButton setProgressWithFrame:@(50)];
        [self.playButton playFromFrame:@(50) toFrame:@(90) withCompletion:^(BOOL animationFinished) {
            weakSelf.playButton.loopAnimation = YES;
            weakSelf.playButton.autoReverseAnimation = YES;
            [weakSelf.playButton playFromFrame:@(90) toFrame:@(180) withCompletion:^(BOOL animationFinished) {
            }];
        }];
    }

    self.isPlaying = !self.isPlaying;
}

- (void)giftButtonClicked:(UIButton *)button {
    button.enabled = NO;

    LOTAnimationView *giftAnimationView = [LOTAnimationView animationNamed:@"HappyBirthday"];
    giftAnimationView.frame = CGRectMake(10, 240, 400, 300);
    [self.view addSubview:giftAnimationView];

    __weak LOTAnimationView *weakGiftAnimationView = giftAnimationView;
    [giftAnimationView playWithCompletion:^(BOOL animationFinished) {
        [UIView animateWithDuration:0.5 animations:^{
            weakGiftAnimationView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [weakGiftAnimationView removeFromSuperview];
        }];

        button.enabled = YES;
    }];
}

@end
