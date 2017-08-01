//
//  OneViewController.m
//  CYPageView
//
//  Created by aaa on 2017/7/31.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "OneViewController.h"
#import "CYPageView.h"
#import "UIColor+CY.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationItem.title = @"左右切换页面";
    self.view.backgroundColor = [UIColor whiteColor];
    // 1.标题
    NSArray *titles = @[@"唐诗", @"月上雨梢头", @"大漠孤烟直", @"美女", @"默", @"亢龙有悔"];
    CYPageConfigure *pageConfigure = [[CYPageConfigure alloc] init];
    pageConfigure.isScrollEnable = true;
    pageConfigure.isShowScrollLine = true;
    pageConfigure.isShowCoverView = true;
    pageConfigure.isTitleScale = true;
    // 2.所有的的子控制器
    NSMutableArray *childVcs = [NSMutableArray array];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor randomColor];
        [childVcs addObject:vc];
    }
    // 3.pageView的frame
    CGRect pageFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    // 4.创建HYPageView,并且添加到控制器的view中
    CYPageView *pageView = [[CYPageView alloc] initWithFrame:pageFrame titles:titles childVcs:childVcs parentVc:self configure:pageConfigure];
    [self.view addSubview:pageView];
}

@end
