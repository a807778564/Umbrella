//
//  UIImage+Color.h
//  ebook
//
//  Created by lj on 14-6-9.
//  Copyright (c) 2014年 cczone. All rights reserved.
//

#import <UIKit/UIImage.h>

@interface UIImage(Color)

+ (UIImage *)imageNamedWithoutNOSelectBlue:(NSString *)_name;

+(UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size Alpha:(CGFloat)alpha;

+(UIImage *)imageWithSize:(CGSize)size;

-(UIImage*)cutWithFrame:(CGRect)frame;

+(UIImage *)imageWithColor:(UIColor *)color;

+(UIImage*)scaleToSize:(CGSize)size image:(UIImage *)scaleimage;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees startIndex:(NSMutableArray *)startIndex;

- (UIImage*)rotateImageWithAngle:(UIImage*)vImg Angle:(CGFloat)vAngle IsExpand:(BOOL)vIsExpand;

-(UIImage *)imageAtRect:(CGRect)rect;
@end
