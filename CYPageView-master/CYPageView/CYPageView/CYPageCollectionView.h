//
//  CYPageCollectionView.h
//  CYPageView
//
//  Created by aaa on 2017/7/28.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPageConfigure.h"
#import "CYTitleView.h"
#import "CYPageCollectionViewLayout.h"

@class CYPageCollectionView;

@protocol CYPageCollectionViewDataSource <NSObject>

- (NSInteger)numberOfSectionInPageCollectionView:(CYPageCollectionView *)pageCollectionView;
@optional
- (NSInteger)pageCollectionView:(CYPageCollectionView *)pageCollectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)pageCollectionView:(CYPageCollectionView *)pageCollectionView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CYPageCollectionViewDelegate <NSObject>

@optional
- (void)pageCollectionView:(CYPageCollectionView *)pageCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CYPageCollectionView : UIView

@property (nonatomic, weak) id<CYPageCollectionViewDelegate> delegate;
@property (nonatomic, weak) id<CYPageCollectionViewDataSource> dataSource;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles isTitleInTop:(BOOL)isTitleInTop style:(CYPageConfigure *)pageConfigure layout:(UICollectionViewFlowLayout *)layout;

/** 外边注册cell的方法 */
- (void)registerCellClassWithCellClass:(Class)cellClass identifier:(NSString *)identifier;

- (void)registerCellNibWithCellNib:(UINib *)cellNib identifier:(NSString *)identifier;

- (void)reloadData;

@end
