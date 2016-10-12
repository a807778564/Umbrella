//
//  UmbrellaView.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/28.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmbrellaView.h"

#define centerSelf CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
#define defaultColor RGBACOLOR(250, 250, 250, 1)

@implementation UmbrellaView

- (instancetype)init{
    if ([super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self drawTrianglePath];
}

- (void)setCheckImages:(NSMutableDictionary *)checkImages{
    _checkImages = checkImages;
    [self setNeedsDisplay];
}

// 画三角形
- (void)drawTrianglePath {
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(self.frame.size.width/2, 0)];
    [path1 addLineToPoint:centerSelf];
    [path1 addLineToPoint:[self calcCircleCoordinateWithCenter:centerSelf andWithAngle:45 andWithRadius:self.frame.size.width/2]];
    
    [path1 closePath];
    //设置线宽
    path1.lineWidth = 1;
    //设置填充颜色 [UIColor colorWithPatternImage:[UIImage imageNamed:@"test.png"]]
    UIColor *fillColor = _checkImages[@"8"]?[UIColor colorWithPatternImage:_checkImages[@"8"]]:RGBACOLOR(250, 250, 250, 1);
    [fillColor set];
    [path1 fill];
    //设置画笔颜色
    UIColor *strokeColor = [UIColor grayColor];
    [strokeColor set];
    //根据我们设置的各个点连线
    [path1 stroke];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [path2 addLineToPoint:[self calcCircleCoordinateWithCenter:centerSelf andWithAngle:45 andWithRadius:self.frame.size.width/2]];
    [path2 addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    [path2 closePath];
    //设置线宽
    path2.lineWidth = 1;
    //设置填充颜色
    UIColor *fillColor2 = _checkImages[@"7"]?[UIColor colorWithPatternImage:_checkImages[@"7"]]:RGBACOLOR(250, 250, 250, 1);
    [fillColor2 set];
    [path2 fill];
    //设置画笔颜色
    UIColor *strokeColor2 = [UIColor grayColor];
    [strokeColor2 set];
    //根据我们设置的各个点连线
    [path2 stroke];
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [path3 addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    [path3 addLineToPoint:[self calcCircleCoordinateWithCenter:centerSelf andWithAngle:-45 andWithRadius:self.frame.size.width/2]];
    [path3 closePath];
    //设置线宽
    path3.lineWidth = 1;
    //设置填充颜色
    UIColor *fillColor3 = _checkImages[@"6"]?[UIColor colorWithPatternImage:_checkImages[@"6"]]:RGBACOLOR(250, 250, 250, 1);
    [fillColor3 set];
    [path3 fill];
    //设置画笔颜色
    UIColor *strokeColor3 = [UIColor grayColor];
    [strokeColor3 set];
    //根据我们设置的各个点连线
    [path3 stroke];
    
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [path4 addLineToPoint:[self calcCircleCoordinateWithCenter:centerSelf andWithAngle:-45 andWithRadius:self.frame.size.width/2]];
    [path4 addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height)];
    [path4 closePath];
    //设置线宽
    path4.lineWidth = 1;
    //设置填充颜色
    UIColor *fillColor4 = _checkImages[@"5"]?[UIColor colorWithPatternImage:_checkImages[@"5"]]:RGBACOLOR(250, 250, 250, 1);
    [fillColor4 set];
    [path4 fill];
    //设置画笔颜色
    UIColor *strokeColor4 = [UIColor grayColor];
    [strokeColor4 set];
    //根据我们设置的各个点连线
    [path4 stroke];
    
    UIBezierPath *path5 = [UIBezierPath bezierPath];
    [path5 moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [path5 addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height)];
    [path5 addLineToPoint:[self calcCircleCoordinateWithCenter:centerSelf andWithAngle:225 andWithRadius:self.frame.size.width/2]];
    [path5 closePath];
    //设置线宽
    path5.lineWidth = 1;
    //设置填充颜色
    UIColor *fillColor5 = _checkImages[@"4"]?[UIColor colorWithPatternImage:_checkImages[@"4"]]:RGBACOLOR(250, 250, 250, 1);
    [fillColor5 set];
    [path5 fill];
    //设置画笔颜色
    UIColor *strokeColor5 = [UIColor grayColor];
    [strokeColor5 set];
    //根据我们设置的各个点连线
    [path5 stroke];
    
    UIBezierPath *path6 = [UIBezierPath bezierPath];
    [path6 moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [path6 addLineToPoint:[self calcCircleCoordinateWithCenter:centerSelf andWithAngle:225 andWithRadius:self.frame.size.width/2]];
    [path6 addLineToPoint:CGPointMake(0, self.frame.size.height/2)];
    [path6 closePath];
    //设置线宽
    path6.lineWidth = 1;
    //设置填充颜色
    UIColor *fillColor6 = _checkImages[@"3"]?[UIColor colorWithPatternImage:_checkImages[@"3"]]:RGBACOLOR(250, 250, 250, 1);
    [fillColor6 set];
    [path6 fill];
    //设置画笔颜色
    UIColor *strokeColor6 = [UIColor grayColor];
    [strokeColor6 set];
    //根据我们设置的各个点连线
    [path6 stroke];
    
    UIBezierPath *path7 = [UIBezierPath bezierPath];
    [path7 moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [path7 addLineToPoint:CGPointMake(0, self.frame.size.height/2)];
    [path7 addLineToPoint:[self calcCircleCoordinateWithCenter:centerSelf andWithAngle:135 andWithRadius:self.frame.size.width/2]];
    [path7 closePath];
    //设置线宽
    path7.lineWidth = 1;
    //设置填充颜色
//    UIColor *fillColor7 = _checkImages[@"2"]?[UIColor colorWithPatternImage:_checkImages[@"2"]]:RGBACOLOR(250, 250, 250, 1);
//    [fillColor7 set];
//    [path7 fill];
    UIImage *ima7 = _checkImages[@"2"];
    [ima7 drawAtPoint:CGPointMake(0, 0)];
    //设置画笔颜色
    UIColor *strokeColor7 = [UIColor grayColor];
    [strokeColor7 set];
    //根据我们设置的各个点连线
    [path7 stroke];
    
    UIBezierPath *path8 = [UIBezierPath bezierPath];
    [path8 moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [path8 addLineToPoint:[self calcCircleCoordinateWithCenter:centerSelf andWithAngle:135 andWithRadius:self.frame.size.width/2]];
    [path8 addLineToPoint:CGPointMake(self.frame.size.width/2, 0)];
    [path8 closePath];
    //设置线宽
    path8.lineWidth = 1;
    //设置填充颜色
    UIColor *fillColor8 = _checkImages[@"1"]?[UIColor colorWithPatternImage:_checkImages[@"1"]]:RGBACOLOR(250, 250, 250, 1);
    [fillColor8 set];
    [path8 fill];
    UIImage *ima8 = _checkImages[@"1"];
    if (_checkImages.count == 1) {
        [ima8 drawAtPoint:CGPointMake(33, 0)];
    }
    [path8 fill];
    //设置画笔颜色
    UIColor *strokeColor8 = [UIColor grayColor];
    [strokeColor8 set];
    //根据我们设置的各个点连线
    [path8 stroke];
}

#pragma mark 计算圆圈上点在IOS系统中的坐标
-(CGPoint)calcCircleCoordinateWithCenter:(CGPoint)center  andWithAngle:(CGFloat)angle andWithRadius:(CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
