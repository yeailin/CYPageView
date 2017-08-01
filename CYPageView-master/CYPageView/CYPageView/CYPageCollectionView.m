//
//  CYPageCollectionView.m
//  CYPageView
//
//  Created by aaa on 2017/7/28.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYPageCollectionView.h"

#define pageControlH 20.0f
@interface CYPageCollectionView ()<CYTitleViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, assign) BOOL isTitleInTop;
@property (nonatomic, strong) CYPageConfigure *pageConfigure;
@property (nonatomic, strong) CYPageCollectionViewLayout *layout;
@property (nonatomic, strong) NSIndexPath *sourceIndexPath;

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) CYTitleView *titleView;

@end

@implementation CYPageCollectionView
#pragma mark - 懒加载
- (CYTitleView *)titleView {
    if (_titleView == nil) {
        CGFloat titleViewY = self.isTitleInTop ? 0 : self.bounds.size.height - self.pageConfigure.titleHeight;
        CGRect titleViewFrame = CGRectMake(0, titleViewY, self.bounds.size.width, self.pageConfigure.titleHeight);
        CYTitleView *titleView = [[CYTitleView alloc] initWithFrame:titleViewFrame titles:self.titles configure:self.pageConfigure];
        titleView.delegate = self;
        titleView.backgroundColor = self.pageConfigure.titleViewBackgroundColor;
        [self addSubview:titleView];
        _titleView = titleView;
    }
    return _titleView;
}
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        CGFloat pageControlY = self.isTitleInTop ? (self.bounds.size.height - pageControlH) : (self.bounds.size.height - self.pageConfigure.titleHeight - pageControlH);
        CGRect pageControlFrame = CGRectMake(0, pageControlY, self.bounds.size.width, pageControlH);
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
        pageControl.backgroundColor = [UIColor grayColor];
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat collectionViewY = self.isTitleInTop ? self.pageConfigure.titleHeight : 0;
        CGRect collectionViewFrame = CGRectMake(0, collectionViewY, self.bounds.size.width, self.bounds.size.height - self.pageConfigure.titleHeight - pageControlH);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:self.layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = true;
        collectionView.bounces = false;
        collectionView.scrollsToTop = false;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.backgroundColor = [UIColor blackColor];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        
    }
    return _collectionView;
}
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles isTitleInTop:(BOOL)isTitleInTop style:(CYPageConfigure *)pageConfigure layout:(CYPageCollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame]) {
        self.sourceIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        self.titles = titles;
        self.isTitleInTop = isTitleInTop;
        self.pageConfigure = pageConfigure;
        self.layout = layout;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    [self titleView];
    [self pageControl];
    [self collectionView];
}
#pragma mark - 注册cell的方法
- (void)registerCellClassWithCellClass:(Class)cellClass identifier:(NSString *)identifier {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}
- (void)registerCellNibWithCellNib:(UINib *)cellNib identifier:(NSString *)identifier {
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:identifier];
}
- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource ? [self.dataSource numberOfSectionInPageCollectionView:self] : 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger itemCount = self.dataSource ? [self.dataSource pageCollectionView:self numberOfItemsInSection:section] : 0;
    if (section == 0) {
        self.pageControl.numberOfPages = (itemCount - 1) / (self.layout.cols * self.layout.rows) + 1;
    }
    return itemCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource pageCollectionView:self collectionView:collectionView cellForItemAtIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate pageCollectionView:self didSelectItemAtIndexPath:indexPath];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewEndScroll];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewEndScroll];
    }
}
// 处理滚动结束
- (void)scrollViewEndScroll {
    //首先，可以拿到当前屏幕上的一个point，然后根据这个point取到对应cell的indexPath，需要注意的是，要确保这个point的位置是在某个cell上面的
    CGPoint point = CGPointMake(self.layout.sectionInset.left + 1 + self.collectionView.contentOffset.x, self.layout.sectionInset.top + 1 + self.collectionView.contentOffset.y);
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (!indexPath) {
        return;
    }
    if (indexPath.section != self.sourceIndexPath.section) {
        //这一组有个cell
        NSInteger itemCount = self.dataSource ? [self.dataSource pageCollectionView:self numberOfItemsInSection:indexPath.section] : 1;
        //这一组页数
        self.pageControl.numberOfPages = (itemCount - 1) / (self.layout.cols * self.layout.rows) + 1;
        [self.titleView setTitleWithSourceIndex:self.sourceIndexPath.section targetIndex:indexPath.section progress:1];
        self.sourceIndexPath = indexPath;
    }
    
    self.pageControl.currentPage = indexPath.item / (self.layout.cols * self.layout.rows);
}
#pragma mark - CYTitleViewDelegate
- (void)titleView:(CYTitleView *)titleView targetIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
//    NSInteger sectionCount = self.dataSource ? [self.dataSource numberOfSectionInPageCollectionView:self] : 0;
//    if (index != sectionCount - 1) {
//        CGPoint contentOffset = self.collectionView.contentOffset;
//        contentOffset.x -= self.layout.sectionInset.left;
//        self.collectionView.contentOffset = contentOffset;
//    }
    CGPoint contentOffset = self.collectionView.contentOffset;
    contentOffset.x -= self.layout.sectionInset.left;
    self.collectionView.contentOffset = contentOffset;
    [self scrollViewEndScroll];
}
@end













