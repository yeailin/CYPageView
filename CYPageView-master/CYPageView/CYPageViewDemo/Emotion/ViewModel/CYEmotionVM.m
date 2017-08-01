//
//  CYEmotionVM.m
//  CYPageView
//
//  Created by aaa on 2017/7/30.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYEmotionVM.h"

static CYEmotionVM *emotionVM_;
@implementation CYEmotionVM

- (NSMutableArray<CYEmoPackageEntity *> *)packages {
    if (_packages == nil) {
        _packages = [NSMutableArray array];
    }
    return _packages;
}

+ (instancetype)sharedEmotionVM {
    if (emotionVM_ == nil) {
        emotionVM_ = [[CYEmotionVM alloc] init];
    }
    return emotionVM_;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.packages addObject:[[CYEmoPackageEntity alloc] initWithPlistName:@"QHNormalEmotionSort.plist"]];
        [self.packages addObject:[[CYEmoPackageEntity alloc] initWithPlistName:@"QHSohuGifSort.plist"]];
        [self.packages addObject:[[CYEmoPackageEntity alloc] initWithPlistName:@"QHNormalEmotionSort.plist"]];
        [self.packages addObject:[[CYEmoPackageEntity alloc] initWithPlistName:@"QHSohuGifSort.plist"]];
    }
    return self;
}

@end
