//
//  UIImage+Color.m
//  ebook
//
//  Created by lj on 14-6-9.
//  Copyright (c) 2014年 cczone. All rights reserved.
//

#import "UIImage+Color.h"
#import "UIColor+ColorWithHex.h"
#import <UIKit/UIKit.h>

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

@implementation UIImage(Color)

// 去掉默认的选中蓝光
+ (UIImage *)imageNamedWithoutNOSelectBlue:(NSString *)_name{
    UIImage *image = [UIImage imageNamed:_name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+(UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size Alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    img = [self imageByApplyingAlpha:alpha image:img];
    return img;
}

//设置图片透明度
+(UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage *)imageWithSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for(int i = 0;i < size.width;i++)
    {
        rect = CGRectMake(i, 0, 1, size.height);
        CGContextSetFillColorWithColor(context, [UIColor randomColor].CGColor);
        CGContextFillRect(context, rect);
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(UIImage*)cutWithFrame:(CGRect)frame
{
    CGImageRef image = CGImageCreateWithImageInRect(self.CGImage, frame);
    return [UIImage imageWithCGImage:image];

//    UIGraphicsBeginImageContext(frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    CGContextScaleCTM(context, 1.0, -1.0);
//
//    CGContextDrawImage(context, CGRectMake(-frame.origin.x, frame.origin.y-self.size.height, self.size.width, self.size.height), [self CGImage]);
//    CGContextRestoreGState(context);
//    
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
}

+(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//等比例缩放
+(UIImage*)scaleToSize:(CGSize)size image:(UIImage *)scaleimage
{
    CGFloat width = CGImageGetWidth(scaleimage.CGImage);
    CGFloat height = CGImageGetHeight(scaleimage.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [scaleimage drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees startIndex:(NSMutableArray *)startIndex
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;

    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    
    CGFloat drawX = -self.size.width / 2;
    CGFloat drawY = -self.size.height / 2;
    if ([startIndex[0] integerValue] == 2 && startIndex.count<4 && startIndex.count !=1) {
        drawX = -self.size.width;
        drawY = -self.size.height/2.5;
    }else if([startIndex[0] integerValue] == 2 && startIndex.count>3){
        drawY = - self.size.height/5;
    }else if([startIndex[0] integerValue] == 4 && startIndex.count<4){
        drawX = -self.size.width/1.1;
    }else if([startIndex[0] integerValue] == 4 && startIndex.count>3){
        drawX = -self.size.width/4;
    }else if([startIndex[0] integerValue] == 6 && startIndex.count<4){
        drawX = -self.size.width;
    }else if(startIndex.count ==1 && [startIndex[0] integerValue] == 2){
        drawX = -self.size.width/2;
        drawY = -self.size.height/2;
    }else if(startIndex.count ==1 && [startIndex[0] integerValue] == 1){
        drawX = -self.size.width/2;
        drawY = -self.size.height/2;
    }else if(startIndex.count ==1 && [startIndex[0] integerValue] == 3){
        drawX = -self.size.width/2;
        drawY = -self.size.height/2;
    }else if(startIndex.count ==1 && [startIndex[0] integerValue] == 4){
        drawX = -self.size.width/2;
        drawY = -self.size.height/4;
    }
    
    CGContextDrawImage(bitmap, CGRectMake(drawX,drawY, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage *)imageAtRect:(CGRect)rect
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(rect.size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
    
//    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
//    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
//    CGImageRelease(imageRef);
//    
//    return subImage;
    
}
@end
