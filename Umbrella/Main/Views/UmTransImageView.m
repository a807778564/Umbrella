//
//  UmTransImageView.m
//  Umbrella
//
//  Created by huangrensheng on 16/10/12.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmTransImageView.h"
#import "UMUtils.h"

#define selfWidh self.frame.size.width
#define selfHeight self.frame.size.height

#define COS cos(45*M_PI/180)

@interface UmTransImageView()
@property (nonatomic, strong) UMUtils *utils;
@end

@implementation UmTransImageView

- (instancetype)init{
    if ([super init]) {
        self.utils = [[UMUtils alloc] init];
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
            if ([self.utils isOther:self.checkArray]) {
                [image drawInRect:CGRectMake(fabs((selfWidh-_image.size.width)/2),-image.size.width/4, image.size.width, image.size.height)];
            }else{
                [image drawInRect:CGRectMake(-image.size.width/4,-image.size.width/4, image.size.width, image.size.height)];
            }
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
            [image drawInRect:CGRectMake(image.size.width/4,-image.size.width/4, image.size.width, image.size.height)];
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
        double threeWidth = self.frame.size.width/2*cos(45*M_PI/180) + self.frame.size.width/2;//三个三角形的图片大小
        double threeXie = sqrt(threeWidth*threeWidth+threeWidth*threeWidth);//三个三角形的图片斜边的长
        double moveHeight = fabs(threeXie-selfWidh);
        double moveWidth = fabs(sqrt(threeWidth*threeWidth/2)-selfWidh/2);
        if (self.startSan == 1) {
            if ([self.utils isOther:self.checkArray]) {
                if ([self.utils isConp:@"7" check:self.checkArray]) {
                    [image drawInRect:CGRectMake(0,-fabs(moveHeight/2+moveHeight)-5, image.size.width, image.size.height)];
                }else{
                    [image drawInRect:CGRectMake(0,-fabs(selfWidh/2-threeWidth)/2, image.size.width, image.size.height)];
                }
            }else{
                [image drawInRect:CGRectMake(-(moveWidth+moveHeight+5),-moveHeight, image.size.width, image.size.height)];
            }
        }else if (self.startSan == 2) {
            [image drawInRect:CGRectMake(-fabs(selfWidh/2-threeWidth)/2,fabs(selfWidh-threeWidth), image.size.width, image.size.height)];
        }else if (self.startSan == 3) {
            [image drawInRect:CGRectMake(-fabs(moveWidth+moveWidth),moveWidth+5, image.size.width, image.size.height)];
        }else if (self.startSan == 4) {
            [image drawInRect:CGRectMake(fabs(selfWidh-threeWidth),fabs(selfWidh/2-threeWidth)/2+fabs(selfWidh-threeWidth), image.size.width, image.size.height)];
        }else if(self.startSan == 5){
            [image drawInRect:CGRectMake(fabs(moveWidth+5),0, image.size.width, image.size.height)];
        }else if(self.startSan == 6){
            [image drawInRect:CGRectMake(fabs(selfWidh/2-threeWidth)/2+fabs(selfWidh-threeWidth),0, image.size.width, image.size.height)];
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
//        double threeWidth = self.frame.size.width/2*cos(45*M_PI/180) + self.frame.size.width/2;//三个三角形的图片大小
//        double threeXie = sqrt(threeWidth*threeWidth+threeWidth*threeWidth);//三个三角形的图片斜边的长
//        double moveHeight = fabs(threeXie-selfWidh);
        double moveWidth = fabs(sqrt(selfWidh*selfWidh/2)-selfWidh/2);
        if (self.startSan == 1) {
            if ([self.utils isOther:self.checkArray]) {
                if ([self.utils isConp:@"6" check:self.checkArray]) {
                    [image drawInRect:CGRectMake(0,-(moveWidth*2), image.size.width, image.size.height)];
                }else if([self.utils isConp:@"7" check:self.checkArray]) {
                    [image drawInRect:CGRectMake(0,-selfWidh/4, image.size.width, image.size.height)];
                }else if([self.utils isConp:@"3" check:self.checkArray]) {
                    [image drawInRect:CGRectMake(-(moveWidth*2),-(moveWidth*2), image.size.width, image.size.height)];
                }
            }else{
                [image drawInRect:CGRectMake(-selfWidh/4,0, image.size.width, image.size.height)];
            }
        }else if (self.startSan == 2) {
            [image drawInRect:CGRectMake(-(moveWidth*2),0, image.size.width, image.size.height)];
        }else if (self.startSan == 3) {
            [image drawInRect:CGRectMake(0,selfWidh/4, image.size.width, image.size.height)];
        }else if (self.startSan == 4) {
            [image drawInRect:CGRectMake(0,0, image.size.width, image.size.height)];
        }else if(self.startSan == 5){
            [image drawInRect:CGRectMake(selfWidh/4,0, image.size.width, image.size.height)];
        }
    }else if(self.sanMianCount >= 5){
        if (self.sanMianCount ==8 || fabs(image.size.width-selfWidh)<3) {
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
