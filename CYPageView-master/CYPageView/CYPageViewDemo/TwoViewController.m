//
//  TwoViewController.m
//  CYPageView
//
//  Created by aaa on 2017/7/31.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "TwoViewController.h"
#import "CYEmotionView.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationItem.title = @"表情键盘";
    self.view.backgroundColor = [UIColor whiteColor];
    CYEmotionView *emotionView = [[CYEmotionView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 230, self.view.bounds.size.width, 230)];
    emotionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:emotionView];
}

@end
