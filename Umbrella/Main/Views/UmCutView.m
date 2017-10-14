//
//  UmCutView.m
//  Umbrella
//
//  Created by huangrensheng on 16/10/31.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmCutView.h"

#define coutOrigin self.frame.origin
#define coutSize self.frame.size

@interface UmCutView()
@property (nonatomic, strong) UIView *leTo;
@property (nonatomic, strong) UIView *leLe;
@property (nonatomic, strong) UIView *riTo;
@property (nonatomic, strong) UIView *riri;
@property (nonatomic, strong) UIView *leBo;
@property (nonatomic, strong) UIView *boBo;
@property (nonatomic, strong) UIView *riBo;
@property (nonatomic, strong) UIView *boRi;

@end

@implementation UmCutView

- (instancetype)init{
    if ([super init]) {
        self.leTo = [[UIView alloc] init];
//        self.leTo.tag = 2;
//        self.leTo.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.leTo];
//        
//        self.leLe = [[UIView alloc] init];
//        self.leLe.tag = 3;
//        self.leLe.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.leLe];
//        
//        
//        self.riTo = [[UIView alloc] init];
//        self.riTo.tag = 4;
//        self.riTo.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.riTo];
//        
//        self.riri = [[UIView alloc] init];
//        self.riri.tag = 5;
//        self.riri.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.riri];
//        
//        self.leBo = [[UIView alloc] init];
//        self.leBo.tag = 6;
//        self.leBo.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.leBo];
//        
//        self.boBo = [[UIView alloc] init];
//        self.boBo.tag = 7;
//        self.boBo.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.boBo];
//        
//        
//        self.riBo = [[UIView alloc] init];
//        self.riBo.tag = 8;
//        self.riBo.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.riBo];
//        
//        self.boRi = [[UIView alloc] init];
//        self.boRi.tag = 9;
//        self.boRi.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.boRi];
//        
//        [self makeChlidsConst];
        
//        [self performSelector:@selector(updateOtherMaxFrame) withObject:nil afterDelay:0.3];

    }
    return self;
}

- (void)makeChlidsConst{
    [self.leTo mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    [self.leLe mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    [self.riTo mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    [self.riri mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    [self.leBo mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    [self.boBo mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    [self.riBo mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    [self.boRi mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    
    [self.leTo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_top);
        make.width.equalTo(@21);
        make.height.equalTo(@3);
        make.leading.equalTo(self.mas_leading).offset(-3);
    }];
    [self.leLe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(-3);
        make.height.equalTo(@21);
        make.width.equalTo(@3);
        make.trailing.equalTo(self.mas_leading);
    }];
    [self.riTo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_top);
        make.width.equalTo(@21);
        make.height.equalTo(@3);
        make.trailing.equalTo(self.mas_trailing).offset(3);
    }];
    [self.riri mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(-3);
        make.height.equalTo(@21);
        make.width.equalTo(@3);
        make.leading.equalTo(self.mas_trailing);
    }];
    [self.leBo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.width.equalTo(@21);
        make.height.equalTo(@3);
        make.leading.equalTo(self.mas_leading).offset(-3);
    }];
    
    [self.boBo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(3);
        make.height.equalTo(@21);
        make.width.equalTo(@3);
        make.trailing.equalTo(self.mas_leading);
    }];
    [self.riBo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.width.equalTo(@21);
        make.height.equalTo(@3);
        make.trailing.equalTo(self.mas_trailing).offset(3);
    }];
    
    [self.boRi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(3);
        make.height.equalTo(@21);
        make.width.equalTo(@3);
        make.leading.equalTo(self.mas_trailing);
    }];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    [self drawRecort];
    
    [self drawRectLineStartPoint:CGPointMake(0, 1.5) endPoint:CGPointMake(21, 1.5)];
    [self drawRectLineStartPoint:CGPointMake(1.5, 0) endPoint:CGPointMake(1.5, 21)];
    
    [self drawRectLineStartPoint:CGPointMake(coutSize.width-21, 1.5) endPoint:CGPointMake(coutSize.width, 1.5)];
    [self drawRectLineStartPoint:CGPointMake(coutSize.width-1.5, 0) endPoint:CGPointMake(coutSize.width-1.5, 21)];
    
    [self drawRectLineStartPoint:CGPointMake(0, coutSize.height-1.5) endPoint:CGPointMake(21, coutSize.height-1.5)];
    [self drawRectLineStartPoint:CGPointMake(1.5, coutSize.height) endPoint:CGPointMake(1.5, coutSize.height-21)];
    
    [self drawRectLineStartPoint:CGPointMake(coutSize.width-21, coutSize.height-1.5) endPoint:CGPointMake(coutSize.width, coutSize.height-1.5)];
    [self drawRectLineStartPoint:CGPointMake(coutSize.width-1.5, coutSize.height) endPoint:CGPointMake(coutSize.width-1.5, coutSize.height-21)];
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor whiteColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 3, self.frame.size.height-3);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, self.frame.size.width/2, 3);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {5,8};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor whiteColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, self.frame.size.width/2, 3);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, self.frame.size.width-6, self.frame.size.height-3);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr2[] = {5,8};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr2, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}

//画裁剪框
- (void)drawRecort{
    //创建路径并获取句柄
    CGMutablePathRef
    path = CGPathCreateMutable();
    //指定矩形
    CGRect rectangle = CGRectMake(3.0f, 3.0f,self.frame.size.width-6, self.frame.size.width-6);
    //将矩形添加到路径中
    CGPathAddRect(path,NULL,rectangle);
    //获取上下文
    CGContextRef
    currentContext = UIGraphicsGetCurrentContext();
    //将路径添加到上下文
    CGContextAddPath(currentContext,path);
    //设置矩形填充色
    [[UIColor clearColor] setFill];
    //矩形边框颜色
    [[UIColor whiteColor] setStroke];
    //边框宽度
    CGContextSetLineWidth(currentContext,2.0f);
    //绘制
    CGContextDrawPath(currentContext,kCGPathFillStroke);
    CGPathRelease(path);
}

//画边角
-(void)drawRectLineStartPoint:(CGPoint)start endPoint:(CGPoint)end{
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式
    CGContextSetLineCap(context,kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context,3.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context,1.0, 1.0, 1.0, 1.0);
    //开始绘制
    CGContextBeginPath(context);
    //画笔移动到点(31,170)
    CGContextMoveToPoint(context,start.x, start.y);
    //下一点
    CGContextAddLineToPoint(context,end.x, end.y);
    //绘制完成
    CGContextStrokePath(context);
    
}
@end
