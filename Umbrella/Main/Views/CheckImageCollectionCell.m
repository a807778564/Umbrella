//
//  CheckImageCollectionCell.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/30.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "CheckImageCollectionCell.h"

@implementation CheckImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.showImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.showImage];
        [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

@end
