//
//  CYTitleView.m
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYTitleView.h"
#import "CYPageConfigure.h"
#import "UIColor+CY.h"

@interface CYTitleView ()

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray<UILabel *> *titleLabels;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *bottomLine;
@property (nonatomic, weak) UIView *coverView;

@end

@implementation CYTitleView
#pragma mark - 懒加载
- (NSMutableArray<UILabel *> *)titleLabels {
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        _scrollView = scrollView;
        [self addSubview:scrollView];
    }
    return _scrollView;
}
- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = self.pageConfigure.scrollLineColor;
        CGRect bottomLineFrame = bottomLine.frame;
        bottomLineFrame.size.height = self.pageConfigure.scrollLineHeight;
        bottomLineFrame.origin.y = self.bounds.size.height - self.pageConfigure.scrollLineHeight;
        bottomLine.frame = bottomLineFrame;
        _bottomLine = bottomLine;
        [self.scrollView addSubview:bottomLine];
    }
    return _bottomLine;
}
- (UIView *)coverView {
    if (_coverView == nil) {
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = self.pageConfigure.coverBgColor;
        coverView.alpha = self.pageConfigure.coverAlpha;
        CGFloat coverW = self.titleLabels.firstObject.frame.size.width - 2 * self.pageConfigure.coverMargin;
        if (self.pageConfigure.isScrollEnable) {
            coverW = self.titleLabels.firstObject.frame.size.width + self.pageConfigure.coverLRMargin;
        }
        CGFloat coverH = self.pageConfigure.coverHeight;
        coverView.bounds = CGRectMake(0, 0, coverW, coverH);
        coverView.center = self.titleLabels.firstObject.center;
        if (self.pageConfigure.coverRadius) {
            coverView.layer.cornerRadius = self.pageConfigure.coverRadius;
            coverView.layer.masksToBounds = true;
        }
        _coverView = coverView;
        [self.scrollView addSubview:coverView];
    }
    return _coverView;
}
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles configure:(CYPageConfigure *)pageConfigure {
    self = [self initWithFrame:frame];
    if (self) {
        _titles = titles;
        _pageConfigure = pageConfigure;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    // 1.将UIScrollVIew添加到view中
    [self scrollView];
    // 2.将titleLabel添加到UIScrollView中
    [self setupTitleLabels];
    // 3.设置titleLabel的frame
    [self setupTitleLabelsFrame];
    // 4.添加滚动条
    if (self.pageConfigure.isShowScrollLine) {
        [self bottomLine];
    }
    // 5.添加遮罩
    if (self.pageConfigure.isShowCoverView) {
        [self coverView];
    }
}
- (void)setupTitleLabels {
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.backgroundColor = [UIColor randomColor];
        titleLabel.text = self.titles[i];
        titleLabel.font = [UIFont systemFontOfSize:self.pageConfigure.fontSize];
        titleLabel.tag = i;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = i == 0 ? self.pageConfigure.selectColor : self.pageConfigure.normalColor;
        [self.scrollView addSubview:titleLabel];
        [self.titleLabels addObject:titleLabel];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [titleLabel addGestureRecognizer:tapGes];
        titleLabel.userInteractionEnabled = true;
    }
}
- (void)setupTitleLabelsFrame {
    NSInteger count = self.titles.count;
    for (NSInteger i = 0; i < count; i++) {
        CGFloat w = 0;
        CGFloat h = self.bounds.size.height;
        CGFloat x = 0;
        CGFloat y = 0;
        if (self.pageConfigure.isScrollEnable) {//可以滚动
            w = [self.titles[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabels[i].font} context:nil].size.width;
            if (i == 0) {
                x = self.pageConfigure.itemMargin * 0.5;
                if (self.pageConfigure.isShowScrollLine) {
                    CGRect bottomLineFrame = self.bottomLine.frame;
                    bottomLineFrame.origin.x = x;
                    bottomLineFrame.size.width = w;
                    self.bottomLine.frame = bottomLineFrame;
                }
            } else {
                UILabel *preLabel = self.titleLabels[i - 1];
                x = CGRectGetMaxX(preLabel.frame) + self.pageConfigure.itemMargin;
            }
        } else {//不能滚动
            w = self.bounds.size.width / count;
            x = w * i;
            if (i == 0 && self.pageConfigure.isShowScrollLine) {
                CGRect bottomLineFrame = self.bottomLine.frame;
                bottomLineFrame.origin.x = 0;
                bottomLineFrame.size.width = w;
                self.bottomLine.frame = bottomLineFrame;
            }
        }
        self.titleLabels[i].frame = CGRectMake(x, y, w, h);
        if (self.pageConfigure.isTitleScale && i == 0) {
            self.titleLabels[i].transform = CGAffineTransformMakeScale(self.pageConfigure.scaleRange, self.pageConfigure.scaleRange);
        }
    }
    self.scrollView.contentSize = self.pageConfigure.isScrollEnable ? CGSizeMake(CGRectGetMaxX(self.titleLabels.lastObject.frame) + self.pageConfigure.itemMargin * 0.5, 0) : CGSizeZero;
}

#pragma mark - 事件方法
- (void)titleLabelClick:(UITapGestureRecognizer *)tapGes {
    // 1.取出用户点击的View
    UILabel *targetLabel = (UILabel *)tapGes.view;
    UILabel *sourceLabel = self.titleLabels[self.currentIndex];
    // 2.调整title
    [self adjustTitleLabel:targetLabel.tag];
    // 3.调整bottomLine
    if (self.pageConfigure.isShowScrollLine) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect bottomLineFrame = self.bottomLine.frame;
            bottomLineFrame.origin.x = targetLabel.frame.origin.x;
            bottomLineFrame.size.width = targetLabel.frame.size.width;
            self.bottomLine.frame = bottomLineFrame;
        }];
    }
    // 4.通知代理
    if ([self.delegate respondsToSelector:@selector(titleView: targetIndex:)]) {
        [self.delegate titleView:self targetIndex:self.currentIndex];
    }
    // 5.调整缩放比例
    if (self.pageConfigure.isTitleScale) {
        targetLabel.transform = sourceLabel.transform;
        sourceLabel.transform = CGAffineTransformIdentity;
    }
    // 6.调整coverView的位置
    if (self.pageConfigure.isShowCoverView) {
        CGFloat coverW = self.pageConfigure.isScrollEnable ? (targetLabel.frame.size.width + self.pageConfigure.coverLRMargin) : (targetLabel.frame.size.width - 2 * self.pageConfigure.coverMargin);
        CGRect coverFrame = self.coverView.frame;
        coverFrame.size.width = coverW;
        self.coverView.frame = coverFrame;
        self.coverView.center = targetLabel.center;
    }
}
- (void)adjustTitleLabel:(NSInteger)targetIndex {
    if (targetIndex == self.currentIndex)  return;
    NSLog(@"%zd %zd", targetIndex, self.currentIndex);
    // 1.取出Label
    UILabel *targetLabel = self.titleLabels[targetIndex];
    UILabel *sourceLabel = self.titleLabels[self.currentIndex];
    // 2.切换文字的颜色
    targetLabel.textColor = self.pageConfigure.selectColor;
    sourceLabel.textColor = self.pageConfigure.normalColor;
    
    // 3.记录下标值
    self.currentIndex = targetIndex;
    
    // 4.调整位置
    if (self.pageConfigure.isScrollEnable) {
        CGFloat offsetX = targetLabel.center.x - self.scrollView.bounds.size.width * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        }
        if (offsetX > (self.scrollView.contentSize.width - self.scrollView.bounds.size.width)) {
            offsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
        }
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:true];
    }
}
#pragma mark - CYContentViewDelegate
- (void)contentView:(CYContentView *)contentView targetIndex:(NSInteger)targetIndex {
//    NSLog(@"targetIndex - %zd - currentIndex %zd", targetIndex, self.currentIndex);
    [self adjustTitleLabel:targetIndex];
}
- (void)contentView:(CYContentView *)contentView targetIndex:(NSInteger)targetIndex sourceIndex:(NSInteger)sourceIndex progress:(CGFloat)progress {
    [self setTitleWithSourceIndex:sourceIndex targetIndex:targetIndex progress:progress];
}
- (void)setTitleWithSourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress {
    //    NSLog(@"targetIndex - %zd progress - %f", targetIndex, progress);
    // 1.取出Label
    self.currentIndex = sourceIndex;
    UILabel *targetLabel = self.titleLabels[targetIndex];
    UILabel *sourceLabel = self.titleLabels[sourceIndex];
    NSLog(@"%zd %zd %zd", targetIndex, sourceIndex, self.currentIndex);
    // 2.颜色渐变
    NSArray<NSNumber *> *deltaRGB = [self getRGBDeltaWithFirstColor:self.pageConfigure.selectColor seccondColor:self.pageConfigure.normalColor];
    NSArray<NSNumber *> *selectRGB = [self getRGBWithColor:self.pageConfigure.selectColor];
    NSArray<NSNumber *> *normalRGB = [self getRGBWithColor:self.pageConfigure.normalColor];
    
    targetLabel.textColor = [UIColor colorWithRed:[normalRGB[0] integerValue] + [deltaRGB[0] integerValue] * progress green:[normalRGB[1] integerValue] + [deltaRGB[1] integerValue] * progress blue:[normalRGB[2] integerValue] + [deltaRGB[2] integerValue] * progress alpha:1];
    sourceLabel.textColor = [UIColor colorWithRed:[selectRGB[0] integerValue] - [deltaRGB[0] integerValue] * progress green:[selectRGB[1] integerValue] - [deltaRGB[1] integerValue] * progress blue:[selectRGB[2] integerValue] - [deltaRGB[2] integerValue] * progress alpha:1];
    // 3.bottomLine渐变过程
    if (self.pageConfigure.isShowScrollLine) {
        CGFloat deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
        CGFloat deltaW = targetLabel.frame.size.width - sourceLabel.frame.size.width;
        CGRect bottomLineFrame = self.bottomLine.frame;
        bottomLineFrame.origin.x = sourceLabel.frame.origin.x + deltaX * progress;
        bottomLineFrame.size.width = sourceLabel.frame.size.width + deltaW * progress;
        self.bottomLine.frame = bottomLineFrame;
    }
    // 4.缩放渐变
    if (self.pageConfigure.isTitleScale) {
        CGFloat deltaScale = self.pageConfigure.scaleRange - 1.0;
        sourceLabel.transform = CGAffineTransformMakeScale(self.pageConfigure.scaleRange - deltaScale * progress, self.pageConfigure.scaleRange - deltaScale * progress);
        targetLabel.transform = CGAffineTransformMakeScale(1.0f + deltaScale * progress, 1.0f + deltaScale * progress);
    }
    // 5.调整coverView
    if (self.pageConfigure.isShowCoverView) {
        CGFloat sourceLabelW = self.pageConfigure.isScrollEnable ? (sourceLabel.frame.size.width + self.pageConfigure.coverLRMargin) : (sourceLabel.frame.size.width - 2 * self.pageConfigure.coverMargin);
        CGFloat targetLabelW = self.pageConfigure.isScrollEnable ? (targetLabel.frame.size.width + self.pageConfigure.coverLRMargin) : (targetLabel.frame.size.width - 2 * self.pageConfigure.coverMargin);
        CGFloat deltaW = targetLabelW - sourceLabelW;
        CGFloat deltaX = targetLabel.center.x - sourceLabel.center.x;
        CGRect coverFrame = self.coverView.frame;
        coverFrame.size.width = sourceLabelW + deltaW * progress;
        self.coverView.frame = coverFrame;
        CGPoint coverPoint = self.coverView.center;
        coverPoint.x = sourceLabel.center.x + deltaX * progress;
        self.coverView.center = coverPoint;
    }
    self.currentIndex = targetIndex;
}
#pragma mark - 颜色操作
- (NSArray *)getRGBDeltaWithFirstColor:(UIColor *)firstColor seccondColor:(UIColor *)seccondColor {
    NSArray<NSNumber *> *firstRGB = [self getRGBWithColor:firstColor];
    NSArray<NSNumber *> *secondRGB = [self getRGBWithColor:seccondColor];
    return @[@([firstRGB[0] integerValue] - [secondRGB[0] integerValue]), @([firstRGB[1] integerValue] - [secondRGB[1] integerValue]), @([firstRGB[2] integerValue] - [secondRGB[2] integerValue])];
}
- (NSArray<NSNumber *> *)getRGBWithColor:(UIColor *)color {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}


@end












