//
//  CYContentViewDelegate.h
//  CYPageView
//
//  Created by aaa on 2017/7/6.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYContentView;

@protocol CYContentViewDelegate <NSObject>

- (void)contentView:(CYContentView *)contentView targetIndex:(NSInteger)targetIndex;

@optional
- (void)contentView:(CYContentView *)contentView targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;

- (void)contentView:(CYContentView *)contentView targetIndex:(NSInteger)targetIndex sourceIndex:(NSInteger)sourceIndex progress:(CGFloat)progress;

@end
