//
//  CYEmotionCell.m
//  CYPageView
//
//  Created by aaa on 2017/7/29.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "CYEmotionCell.h"

@interface CYEmotionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@end

@implementation CYEmotionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setEmotionEntity:(CYEmotionEntity *)emotionEntity {
    _emotionEntity = emotionEntity;
    _picView.image = [UIImage imageNamed:emotionEntity.emoticonName];
}

@end
