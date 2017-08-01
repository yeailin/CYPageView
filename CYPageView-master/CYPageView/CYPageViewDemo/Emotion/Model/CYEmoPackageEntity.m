//
//  CYEmoPackageEntity.m
//  CYPageView
//
//  Created by aaa on 2017/7/30.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYEmoPackageEntity.h"

@implementation CYEmoPackageEntity

- (NSMutableArray<CYEmotionEntity *> *)emoticons {
    if (_emoticons == nil) {
        _emoticons = [NSMutableArray array];
    }
    return _emoticons;
}

- (instancetype)initWithPlistName:(NSString *)plistName {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
        NSArray *emotionArray = [NSArray arrayWithContentsOfFile:path];
        for (NSString *emoticonName in emotionArray) {
            [self.emoticons addObject:[[CYEmotionEntity alloc] initWithEmoticonName:emoticonName]];
        }
    }
    return self;
}

@end
