//
//  UIColor+CY.m
//  CYPageView
//
//  Created by aaa on 2017/7/6.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "UIColor+CY.h"

@implementation UIColor (CY)

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}

@end
