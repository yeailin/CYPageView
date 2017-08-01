//
//  CYBaseEntity.m
//  CYPageView
//
//  Created by aaa on 2017/7/30.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYBaseEntity.h"

@implementation CYBaseEntity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@中含有未定义的key，属性名为：%@", self, key);
}

@end
