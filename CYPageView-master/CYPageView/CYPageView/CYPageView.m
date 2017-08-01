//
//  CYPageView.m
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYPageView.h"
#import "CYTitleView.h"
#import "CYContentView.h"
#import "CYPageConfigure.h"

@interface CYPageView ()

@property (nonatomic, weak) CYTitleView *titleView;
@property (nonatomic, weak) CYContentView *contentView;

@end

@implementation CYPageView
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles childVcs:(NSArray<UIViewController *> *)childVcs parentVc:(UIViewController *)parentVc configure:(CYPageConfigure *)pageConfigure {
    self = [self initWithFrame:frame];
    if (self) {
        if (titles.count != childVcs.count) {
            NSException *excp = [NSException exceptionWithName:@"titlesAndchildVcsError" reason:@"标题&控制器个数不同,请检测!!!" userInfo:nil];//监测
            [excp raise]; // 抛出异常
        }
        _titles = titles;
        _childVcs = childVcs;
        _parentVc = parentVc;
        _pageConfigure = pageConfigure;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    [self setupTitleView];
    [self setupContentView];
}
- (void)setupTitleView {
    CGRect titleFrame = CGRectMake(0, 0, self.pageConfigure.titleWidth, self.pageConfigure.titleHeight);
    CYTitleView *titleView = [[CYTitleView alloc] initWithFrame:titleFrame titles:self.titles configure:self.pageConfigure];
    [self addSubview:titleView];
    titleView.backgroundColor = self.pageConfigure.titleViewBackgroundColor;
    _titleView = titleView;
}
- (void)setupContentView {
    // 1.设置frame
    CGRect contentFrame = CGRectMake(0, self.pageConfigure.titleHeight, self.pageConfigure.titleWidth, self.bounds.size.height - self.pageConfigure.titleHeight);
    CYContentView *contentView = [[CYContentView alloc] initWithFrame:contentFrame childVcs:self.childVcs parentVc:self.parentVc];
    [self addSubview:contentView];
    contentView.backgroundColor = self.pageConfigure.contentViewBackgroundColor;
    _contentView = contentView;
    // 2.contentView&titleView代理设置
    _titleView.delegate = _contentView;
    _contentView.delegate = _titleView;
}

@end
