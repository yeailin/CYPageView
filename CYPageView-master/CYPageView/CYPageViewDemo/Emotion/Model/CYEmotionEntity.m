//
//  CYEmotionEntity.m
//  CYPageView
//
//  Created by aaa on 2017/7/30.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYEmotionEntity.h"

@implementation CYEmotionEntity

- (instancetype)initWithEmoticonName:(NSString *)emoticonName {
    if (self = [super init]) {
        self.emoticonName = emoticonName;
    }
    return self;
}

@end
