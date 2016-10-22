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

#define COS cos(45*M_PI/180)

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
    NSLog(@"cos%.2f",cos(45*M_PI/180));
    if (self.startSan==1 && self.sanMianCount ==1) {
        [image drawInRect:CGRectMake(selfWidh-_image.size.width, 0, image.size.width, image.size.height)];//在坐标中画出图片
    }else if(self.startSan==2 && self.sanMianCount ==1){
        [image drawInRect:CGRectMake(-fabs(selfWidh-_image.size.width), fabs(selfWidh-_image.size.width), image.size.height, image.size.width)];//在坐标中画出图片
    }else if(self.startSan==3 && self.sanMianCount ==1){
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];//在坐标中画出图片
    }else if(self.startSan==4 && self.sanMianCount ==1){
        [image drawInRect:CGRectMake(fabs(selfWidh-_image.size.width), 0, image.size.width, image.size.height)];//在坐标中画出图片
    }else if(self.startSan==5 && self.sanMianCount ==1){
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];//在坐标中画出图片
    }else if(self.startSan==6 && self.sanMianCount ==1){
        [image drawInRect:CGRectMake(0, -fabs(selfWidh-_image.size.width)*2, image.size.height, image.size.width)];//在坐标中画出图片
    }else if(self.startSan==7 && self.sanMianCount ==1){
        [image drawInRect:CGRectMake(0, fabs(selfWidh-_image.size.height), image.size.width, image.size.height)];//在坐标中画出图片
    }else if(self.startSan==8 && self.sanMianCount ==1){
        [image drawInRect:CGRectMake(-fabs(selfWidh-_image.size.width)*2, -fabs(selfWidh-_image.size.width), image.size.height, image.size.width)];//在坐标中画出图片
    }else if(self.sanMianCount ==2){
        if (self.startSan == 1) {
            [image drawInRect:CGRectMake(-image.size.width/4,-image.size.width/4, image.size.width, image.size.height)];
        }else if (self.startSan == 2) {
            [image drawInRect:CGRectMake(-fabs(selfWidh/2-_image.size.width),fabs((selfWidh-_image.size.width)/2), image.size.width, image.size.height)];
        }else if (self.startSan == 3) {
            [image drawInRect:CGRectMake(-image.size.width/4,image.size.width/4, image.size.width, image.size.height)];
        }else if (self.startSan == 4) {
            [image drawInRect:CGRectMake(fabs((selfWidh-_image.size.width)/2),selfWidh/2, image.size.width, image.size.height)];
        }else if(self.startSan == 5){
            [image drawInRect:CGRectMake(image.size.width/4,image.size.width/4, image.size.width, image.size.height)];
        }else if(self.startSan == 6){
            [image drawInRect:CGRectMake(selfWidh/2,fabs((selfWidh-_image.size.width)/2), image.size.width, image.size.height)];
        }else if(self.startSan == 7){
            [image drawInRect:CGRectMake(selfWidh/4,-selfWidh/4, image.size.width, image.size.height)];
        }

//        if (self.startSan ==2) {
//            [image drawInRect:CGRectMake((selfHeight-(selfHeight*cos(45*M_PI/180))*2), selfHeight-(selfHeight*cos(45*M_PI/180)), image.size.width, image.size.height)];//在坐标中画出图片
//        }else if(self.startSan == 3){
//            [image drawInRect:CGRectMake((selfHeight-(selfHeight*cos(45*M_PI/180))*2), -fabs(selfHeight*cos(45*M_PI/180)), image.size.width, image.size.height)];//在坐标中画出图片
//        }else if(self.startSan == 4){
//            [image drawInRect:CGRectMake(fabs(selfHeight-(selfHeight*cos(45*M_PI/180))), 0, image.size.width, image.size.height)];//在坐标中画出图片
//        }else if(self.startSan == 5){
//            [image drawInRect:CGRectMake(-fabs(selfHeight*cos(45*M_PI/180)), 0, image.size.width, image.size.height)];//在坐标中画出图片
//        }else if(self.startSan == 6){
//            [image drawInRect:CGRectMake(0, -fabs(selfHeight*cos(45*M_PI/180)), image.size.width, image.size.height)];//在坐标中画出图片
//        }else if(self.startSan == 7){
//            [image drawInRect:CGRectMake(0, fabs(selfHeight-(selfHeight*cos(45*M_PI/180))), image.size.width, image.size.height)];//在坐标中画出图片
//        }
    }else if(self.sanMianCount == 3){
        if (self.startSan == 1) {
            [image drawInRect:CGRectMake(-selfWidh/4-selfWidh/8,-selfWidh/4, image.size.width, image.size.height)];
        }else if (self.startSan == 2) {
            [image drawInRect:CGRectMake(-fabs(selfWidh/2-_image.size.width)/2,fabs(selfWidh-_image.size.width), image.size.width, image.size.height)];
        }else if (self.startSan == 3) {
            [image drawInRect:CGRectMake(-fabs(selfWidh-_image.size.width),fabs(selfWidh-_image.size.width)/2, image.size.width, image.size.height)];
        }else if (self.startSan == 4) {
            [image drawInRect:CGRectMake(fabs(selfWidh-_image.size.width),fabs(selfWidh/2-_image.size.width)/2, image.size.width, image.size.height)];
        }else if(self.startSan == 5){
            [image drawInRect:CGRectMake(selfWidh/8,0, image.size.width, image.size.height)];
        }else if(self.startSan == 6){
            [image drawInRect:CGRectMake(fabs(selfWidh/2-_image.size.width)/2,0, image.size.width, image.size.height)];
        }
//        float x = fabs((fabs(selfHeight-(selfHeight*cos(45*M_PI/180)))*cos(45*M_PI/180)));
//        if (self.treeStartInde == 2) {
//            [image drawInRect:CGRectMake(-x, -fabs(image.size.width-selfHeight)+x, image.size.width, image.size.height)];//在坐标中画出图片
//        }else if(self.treeStartInde == 4){
//            [image drawInRect:CGRectMake(-fabs(image.size.width-selfHeight)*2+x, x, image.size.width, image.size.height)];//在坐标中画出图片
//        }else if(self.treeStartInde == 6){
//            [image drawInRect:CGRectMake(x, fabs(image.size.width-selfHeight)-x, image.size.width, image.size.height)];//在坐标中画出图片
//        }
    }else if(self.sanMianCount == 4){
        if (self.startSan == 1) {
            [image drawInRect:CGRectMake(-selfWidh/4,0, image.size.width, image.size.height)];
        }else if (self.startSan == 2) {
            [image drawInRect:CGRectMake(-selfWidh/2.5,0, image.size.width, image.size.height)];
        }else if (self.startSan == 3) {
            [image drawInRect:CGRectMake(0,selfWidh/4, image.size.width, image.size.height)];
        }else if (self.startSan == 4) {
            [image drawInRect:CGRectMake(0,0, image.size.width, image.size.height)];
        }else if(self.startSan == 5){
            [image drawInRect:CGRectMake(selfWidh/4,0, image.size.width, image.size.height)];
        }
    }else if(self.sanMianCount >= 5){
        if (self.sanMianCount ==8) {
            [image drawInRect:CGRectMake(0,0, image.size.width, image.size.height)];
        }else{
            [image drawInRect:CGRectMake(-selfWidh/5,-selfWidh/5, image.size.width, image.size.height)];
        }
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
