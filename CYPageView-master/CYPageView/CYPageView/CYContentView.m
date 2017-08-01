//
//  CYContentView.m
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYContentView.h"
#import "UIColor+CY.h"

NSString * const kContentCellID = @"kContentCellID";

@interface CYContentView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) CGFloat startOffsetX;
@property (nonatomic, assign) BOOL isForbidScroll;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CYContentView

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
        collectionView.pagingEnabled = true;
        collectionView.bounces = false;
        collectionView.scrollsToTop = false;
        collectionView.showsHorizontalScrollIndicator = false;
        [self addSubview:collectionView];
        _collectionView = collectionView;
        
    }
    return _collectionView;
}
#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray<UIViewController *> *)childVcs parentVc:(UIViewController *)parentVc {
    self = [self initWithFrame:frame];
    if (self) {
        _childVcs = childVcs;
        _parentVc = parentVc;
        _startOffsetX = 0;
        _isForbidScroll = false;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    // 1.将所有子控制器添加到父控制器中
    for (UIViewController *childVc in self.childVcs) {
        [self.parentVc addChildViewController:childVc];
    }
    // 2.添加UICollection用于展示内容
    [self collectionView];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childVcs.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIViewController *childVc = self.childVcs[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self contentEndScroll];
    scrollView.scrollEnabled = true;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self contentEndScroll];
    } else {
        scrollView.scrollEnabled = false;
    }
}
- (void)contentEndScroll {
    // 0.判断是否是禁止状态
    if (self.isForbidScroll) return;
    // 1.获取滚动到的位置
    NSInteger currentIndex = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    // 2.通知titleView进行调整
    if ([self.delegate respondsToSelector:@selector(contentView:targetIndex:)]) {
        [self.delegate contentView:self targetIndex:currentIndex];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isForbidScroll = false;
    self.startOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 0.判断和开始时的偏移量是否一致
    if (self.startOffsetX == scrollView.contentOffset.x || self.isForbidScroll) {
        return;
    }
    // 1.定义targetIndex/progress
    NSInteger targetIndex = 0;
    CGFloat progress = 0.0;
    
    // 2.给targetIndex/progress赋值
    NSInteger currentIndex = self.startOffsetX / scrollView.bounds.size.width;
    
    if (self.startOffsetX < scrollView.contentOffset.x) { // 左滑动
        targetIndex = currentIndex + 1;
        if (targetIndex > self.childVcs.count - 1) {
            targetIndex = self.childVcs.count - 1;
        }
        progress = (scrollView.contentOffset.x - self.startOffsetX) / scrollView.bounds.size.width;
    } else { // 右滑动
        targetIndex = currentIndex - 1;
        if (targetIndex < 0) {
            targetIndex = 0;
        }
        progress = (self.startOffsetX - scrollView.contentOffset.x) / scrollView.bounds.size.width;
    }
    // 3.通知代理
    if ([self.delegate respondsToSelector:@selector(contentView:targetIndex:sourceIndex:progress:)]) {
        [self.delegate contentView:self targetIndex:targetIndex sourceIndex:currentIndex progress:progress];
    }
}

#pragma mark - CYTitleViewDelegate
- (void)titleView:(CYTitleView *)titleView targetIndex:(NSInteger)index {
    self.isForbidScroll = true;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
}

@end












