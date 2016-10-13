//
//  UmTransImageView.m
//  Umbrella
//
//  Created by huangrensheng on 16/10/12.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmTransImageView.h"

#define selfWidh self.frame.size.width
#define selfHeight self.frame.size.height

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
    
    if (self.startSan==1 && self.sanMianCount ==1) {
        [image drawInRect:CGRectMake(selfWidh-_image.size.width, 0, selfWidh, selfHeight)];//在坐标中画出图片
    }else if(self.startSan==2 && self.sanMianCount ==1){
        [image drawInRect:CGRectMake(0, fabs(selfWidh-_image.size.width), selfWidh, selfHeight)];//在坐标中画出图片
    }
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
