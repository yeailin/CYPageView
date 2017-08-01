//
//  CYPageConfigure.h
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CYPageConfigure : NSObject

/** 标题高度 默认44 */
@property (nonatomic, assign) CGFloat titleHeight;
/** 标题宽度 默认手机屏幕宽度 */
@property (nonatomic, assign) CGFloat titleWidth;
/** 标题普通状态下颜色 默认blackColor */
@property (nonatomic, strong) UIColor *normalColor;
/** 标题选中状态下颜色 默认blueColor */
@property (nonatomic, strong) UIColor *selectColor;
/** 标题view背景颜色 默认whiteColor */
@property (nonatomic, strong) UIColor *titleViewBackgroundColor;
/** contentView背景颜色 默认whiteColor */
@property (nonatomic, strong) UIColor *contentViewBackgroundColor;
/** 标题字体大小 默认15.0f */
@property (nonatomic, assign) CGFloat fontSize;
/** 标题是否可以滚动 默认false */
@property (nonatomic, assign) BOOL isScrollEnable;
/** titleView距离左边间距 默认30.0f */
@property (nonatomic, assign) CGFloat itemMargin;
/** 是否显示下面的滚动条 false */
@property (nonatomic, assign) BOOL isShowScrollLine;
/** 滚动条高度 默认2 */
@property (nonatomic, assign) CGFloat scrollLineHeight;
/** 滚动条颜色 默认blueColor */
@property (nonatomic, strong) UIColor *scrollLineColor;

/** 标题字体缩放功能 默认false */
@property (nonatomic, assign) BOOL isTitleScale;
/** 标题字体缩放比例 默认1.2 */
@property (nonatomic, assign) CGFloat scaleRange;
/** 是否显示标题上的遮罩 默认false */
@property (nonatomic, assign) BOOL isShowCoverView;
/** 标题的遮罩左右距离 标题能滚动的时候 默认20 */
@property (nonatomic, assign) CGFloat coverLRMargin;
/** 标题上遮罩的背景颜色 默认blueColor */
@property (nonatomic, strong) UIColor *coverBgColor;
/** 标题上遮罩的透明度 默认0.4 */
@property (nonatomic, assign) CGFloat coverAlpha;
/** 标题上遮罩的间距 默认8 */
@property (nonatomic, assign) CGFloat coverMargin;
/** 标题上遮罩的高度 默认25 */
@property (nonatomic, assign) CGFloat coverHeight;
/** 标题上遮罩的圆角 默认12.5 */
@property (nonatomic, assign) CGFloat coverRadius;

@end
