//
//  CYEmoPackageEntity.h
//  CYPageView
//
//  Created by aaa on 2017/7/30.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYEmotionEntity.h"

@interface CYEmoPackageEntity : NSObject

@property (nonatomic, strong) NSMutableArray<CYEmotionEntity *> *emoticons;

- (instancetype)initWithPlistName:(NSString *)plistName;

@end
