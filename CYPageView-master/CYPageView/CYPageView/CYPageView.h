//
//  CYPageView.h
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPageConfigure.h"

@interface CYPageView : UIView

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) CYPageConfigure *pageConfigure;

@property (nonatomic, strong) NSArray<UIViewController *> *childVcs;
@property (nonatomic, strong) UIViewController *parentVc;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles childVcs:(NSArray<UIViewController *> *)childVcs parentVc:(UIViewController *)parentVc configure:(CYPageConfigure *)pageConfigure;

@end
