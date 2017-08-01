//
//  CYPageConfigure.m
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYPageConfigure.h"

@implementation CYPageConfigure


- (instancetype)init {
    if (self = [super init]) {
        //设置配置文件默认值
        self.titleHeight = 44;
        self.titleWidth = [UIScreen mainScreen].bounds.size.width;
        self.normalColor = [UIColor blackColor];
        self.selectColor = [UIColor blueColor];
        self.titleViewBackgroundColor = [UIColor whiteColor];
        self.contentViewBackgroundColor = [UIColor whiteColor];
        self.fontSize = 15.0f;
        self.isScrollEnable = false;
        self.itemMargin = 30.0f;
        self.isShowScrollLine = false;
        self.scrollLineHeight = 2;
        self.scrollLineColor = [UIColor blueColor];
        self.isTitleScale = false;
        self.scaleRange = 1.2f;
        self.isShowCoverView = false;
        self.coverBgColor = [UIColor blueColor];
        self.coverLRMargin = 20;
        self.coverAlpha = 0.4;
        self.coverMargin = 8;
        self.coverHeight = 25;
        self.coverRadius = 12.5;
    }
    return self;
}

@end
