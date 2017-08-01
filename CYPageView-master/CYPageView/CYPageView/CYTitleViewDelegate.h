//
//  CYTitleViewDelegate.h
//  CYPageView
//
//  Created by aaa on 2017/7/6.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYTitleView;

@protocol CYTitleViewDelegate <NSObject>

- (void)titleView:(CYTitleView *)titleView targetIndex:(NSInteger)index;

@end
