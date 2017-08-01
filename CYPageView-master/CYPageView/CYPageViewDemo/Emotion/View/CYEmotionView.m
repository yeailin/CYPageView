//
//  CYEmotionView.m
//  CYPageView
//
//  Created by aaa on 2017/7/29.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYEmotionView.h"
#import "CYEmotionCell.h"
#import "CYPageConfigure.h"
#import "CYPageCollectionViewLayout.h"
#import "CYPageCollectionView.h"
#import "UIColor+CY.h"
#import "CYEmotionVM.h"

static NSString *kEmotionCellIdentifier = @"CYEmotionCell";

@interface CYEmotionView ()<CYPageCollectionViewDelegate, CYPageCollectionViewDataSource>

@end

@implementation CYEmotionView
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    //标题
    NSArray *titles = @[@"普通", @"专属粉丝", @"pp", @"qq"];
    CYPageConfigure *pageConfigure = [[CYPageConfigure alloc] init];
    pageConfigure.isShowScrollLine = true;
    //实例化表情界面
    CYPageCollectionViewLayout *layout = [[CYPageCollectionViewLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.cols = 7;
    layout.rows = 3;
    CYPageCollectionView *pageCollectionView = [[CYPageCollectionView alloc] initWithFrame:self.bounds titles:titles isTitleInTop:false style:pageConfigure layout:layout];
    //注册cell
    [pageCollectionView registerCellNibWithCellNib:[UINib nibWithNibName:kEmotionCellIdentifier bundle:nil] identifier:kEmotionCellIdentifier];
    pageCollectionView.dataSource = self;
    pageCollectionView.delegate = self;
    [self addSubview:pageCollectionView];
}
#pragma mark - CYPageCollectionViewDelegate, CYPageCollectionViewDataSource
- (NSInteger)numberOfSectionInPageCollectionView:(CYPageCollectionView *)pageCollectionView {
    return [CYEmotionVM sharedEmotionVM].packages.count;
}
- (NSInteger)pageCollectionView:(CYPageCollectionView *)pageCollectionView numberOfItemsInSection:(NSInteger)section {
    return [CYEmotionVM sharedEmotionVM].packages[section].emoticons.count;
}
- (UICollectionViewCell *)pageCollectionView:(CYPageCollectionView *)pageCollectionView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYEmotionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEmotionCellIdentifier forIndexPath:indexPath];
    cell.emotionEntity = [CYEmotionVM sharedEmotionVM].packages[indexPath.section].emoticons[indexPath.row];
    return cell;
}
- (void)pageCollectionView:(CYPageCollectionView *)pageCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%zd组第%zd个", indexPath.section, indexPath.row);
}

@end
