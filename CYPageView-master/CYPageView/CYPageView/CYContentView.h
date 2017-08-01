//
//  CYContentView.h
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTitleView.h"
#import "CYTitleViewDelegate.h"
#import "CYContentViewDelegate.h"

@interface CYContentView : UIView<CYTitleViewDelegate>

@property (nonatomic, weak) id<CYContentViewDelegate> delegate;

@property (nonatomic, strong) NSArray<UIViewController *> *childVcs;

@property (nonatomic, strong) UIViewController *parentVc;

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray<UIViewController *> *)childVcs parentVc:(UIViewController *)parentVc;

@end
