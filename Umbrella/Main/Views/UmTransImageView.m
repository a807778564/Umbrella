//
//  UmTransImageView.m
//  Umbrella
//
//  Created by huangrensheng on 16/10/12.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmTransImageView.h"

@implementation UmTransImageView

- (instancetype)init{
    if ([super init]) {
        
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    UIImage *image = _image;
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];//在坐标中画出图片
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
