//
//  MainViewController.m
//  LottieExample
//
//  Created by York on 2017/8/13.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import "MainViewController.h"
#import <Lottie/Lottie.h>
#import "AnimRefreshHeader.h"
#import "AnimRefreshFooter.h"
#import "ButtonAnimViewController.h"
#import "LoadingAnimViewController.h"
#import "AnimTransitionViewController.h"
#import "ViewInToLayerViewController.h"

@interface MainViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Lottie Example";

    self.items = @[@"按钮动画示例+礼物动画示例",@"加载动画示例+提示动画示例",@"转场动画示例",@"添加View到Layer示例"];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];

    __weak typeof(self) weakSelf = self;
    AnimRefreshHeader *refreshHeader = [AnimRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.tableView setMj_header:refreshHeader];

    AnimRefreshFooter *refreshFooter = [AnimRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self.tableView setMj_footer:refreshFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
- (void)loadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    NSInteger row = indexPath.row;
    cell.textLabel.text = [self.items objectAtIndex:row];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSString *title = [self.items objectAtIndex:row];

    switch (row) {
        case 0:
        {
            ButtonAnimViewController *vc = [[ButtonAnimViewController alloc] init];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            LoadingAnimViewController *vc = [[LoadingAnimViewController alloc] init];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            //由于需要执行动画，必须保证在主线程执行
            dispatch_async(dispatch_get_main_queue(), ^{
                AnimTransitionViewController *vc = [[AnimTransitionViewController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            });
        }
            break;
        case 3:
        {
            ViewInToLayerViewController *vc = [[ViewInToLayerViewController alloc] init];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
