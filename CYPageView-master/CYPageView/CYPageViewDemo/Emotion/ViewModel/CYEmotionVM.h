//
//  CYEmotionVM.h
//  CYPageView
//
//  Created by aaa on 2017/7/30.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYEmoPackageEntity.h"

@interface CYEmotionVM : NSObject

@property (nonatomic, strong) NSMutableArray<CYEmoPackageEntity *> *packages;

+ (instancetype)sharedEmotionVM;

@end
