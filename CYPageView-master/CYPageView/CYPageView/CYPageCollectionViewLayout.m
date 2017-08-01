//
//  CYPageCollectionViewLayout.m
//  CYPageView
//
//  Created by aaa on 2017/7/29.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYPageCollectionViewLayout.h"

@interface CYPageCollectionViewLayout ()

@property (nonatomic, assign) NSInteger maxWidth;

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cellAttrs;

@end

@implementation CYPageCollectionViewLayout
#pragma mark - 懒加载
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)cellAttrs {
    if (_cellAttrs == nil) {
        _cellAttrs = [NSMutableArray array];
    }
    return _cellAttrs;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.cols = 4;
        self.rows = 3;
        self.maxWidth = 0;
    }
    return self;
}

- (void)prepareLayout {
    // 计算item宽度&高度
    CGFloat itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * (self.cols - 1)) / self.cols;
    CGFloat itemH = (self.collectionView.bounds.size.height - self.sectionInset.top - self.sectionInset.bottom - self.minimumLineSpacing * (self.rows - 1)) / self.rows;
    
    [self.cellAttrs removeAllObjects];
    // 一共有多少组cell
    NSInteger sectionNum = self.collectionView.numberOfSections;
    //需要统计此页之前有多少页，用来计算当前改摆放cell的x值
    NSInteger prePageNum = 0;
    //每一组有多少个cell，以及每个cell显示在collectionView的位置计算
    for (NSInteger i = 0; i < sectionNum; i++) {
        //每组有多少个item
        NSInteger itemNum = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < itemNum; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            // 创建对应indexpath的attribute
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            // 计算j在该组中第几页，该页中第多少个
            NSInteger page = j / (self.cols * self.rows);
            NSInteger index = j % (self.cols * self.rows);
            // 设置attr的frame
            CGFloat itemY = self.sectionInset.top + (itemH + self.minimumLineSpacing) * (index / self.cols);
            CGFloat itemX = (prePageNum + page) * self.collectionView.bounds.size.width + self.sectionInset.left + (itemW + self.minimumInteritemSpacing) * (index % self.cols);
            attribute.frame = CGRectMake(itemX, itemY, itemW, itemH);
            [self.cellAttrs addObject:attribute];
        }
        prePageNum += (itemNum - 1) / (self.cols * self.rows) + 1;
    }
    self.maxWidth = prePageNum * self.collectionView.bounds.size.width;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.cellAttrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.maxWidth, 0);
}

@end
