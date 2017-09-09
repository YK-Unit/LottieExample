//
//  ViewInToLayerViewController.m
//  LottieExample
//
//  Created by York on 2017/9/9.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import "ViewInToLayerViewController.h"
#import <Lottie/Lottie.h>

@interface ViewInToLayerViewController ()

@property (nonatomic,strong) LOTAnimationView *rectView;

@end

@implementation ViewInToLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.rectView = [LOTAnimationView animationNamed:@"RectComp"];
    self.rectView.frame = CGRectMake(10, 80, 200, 200);
    [self.view addSubview:self.rectView];

    UIButton *addLayerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addLayerButton.frame = CGRectMake(10, 300, 240, 30);
    [addLayerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addLayerButton setTitle:@"添加子视图到Layer层" forState:UIControlStateNormal];
    [addLayerButton addTarget:self action:@selector(addLayerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addLayerButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLayerButtonClicked:(id)sender {
    NSArray *layerNames = @[@"Green Solid 1",@"Shape Layer 1",@"Shape Layer 2",@"Shape Layer 3",@"Shape Layer 4"];
    for (NSString *layerName in layerNames) {
        CGRect subRectViewFrame = CGRectMake(0, 0, 15, 15);
        UIView *subRectView = [[UIView alloc] initWithFrame:subRectViewFrame];
        subRectViewFrame = [self.rectView convertRect:subRectViewFrame toLayerNamed:nil];
        subRectView.frame = subRectViewFrame;
        subRectView.backgroundColor = [UIColor whiteColor];
        [self.rectView addSubview:subRectView toLayerNamed:layerName applyTransform:YES];
    }
}

@end
