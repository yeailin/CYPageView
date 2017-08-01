//
//  CYTitleView.h
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTitleViewDelegate.h"
#import "CYContentViewDelegate.h"

@class CYPageConfigure;

@interface CYTitleView : UIView<CYContentViewDelegate>

@property (nonatomic, weak) id<CYTitleViewDelegate> delegate;

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) CYPageConfigure *pageConfigure;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles configure:(CYPageConfigure *)pageConfigure;

- (void)setTitleWithSourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;

@end
