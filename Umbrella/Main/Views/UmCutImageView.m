//
//  UmCutImageView.m
//  Umbrella
//
//  Created by laber on 2016/10/7.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmCutImageView.h"

#define coutOrigin self.coutVeiw.frame.origin
#define coutSize self.coutVeiw.frame.size

@interface UmCutImageView()

@property (nonatomic, strong) UIView *coutVeiw;

@end

@implementation UmCutImageView

- (instancetype)init{
    if ([super init]) {
        self.coutVeiw = [[UIView alloc] init];
        self.coutVeiw.backgroundColor = [UIColor clearColor];
        self.coutVeiw.layer.borderColor = [UIColor whiteColor].CGColor;
        self.coutVeiw.layer.borderWidth = 1.0f;
        [self addSubview:self.coutVeiw];
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    UIImageView *ima = [[UIImageView alloc] initWithImage:image];
    [self addSubview:ima];
    [ima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self sendSubviewToBack:ima];
    
    if (image.size.width/image.size.height == 1) {
        [self.coutVeiw mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.coutVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(self.coutVeiw.mas_width);
        }];
    }else{
        [self.coutVeiw mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.coutVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.trailing.equalTo(self.mas_trailing).offset(-60);
            make.leading.equalTo(self.mas_leading).offset(60);
            make.height.equalTo(self.coutVeiw.mas_width);
        }];
    }
    
}

- (UIImage *)cutImageWhenBack:(UIImage *)hostImage{
    if (_image.size.width/_image.size.height == 1) {
        return [self scaleToSize:CGSizeMake(self.coutVeiw.frame.size.width, self.coutVeiw.frame.size.height) image:_image];
    }else{
        UIImage *cutImagess = [self getSubImage:self.coutVeiw.frame hostImage:hostImage];
        return [self scaleToSize:CGSizeMake(self.coutVeiw.frame.size.width, self.coutVeiw.frame.size.height) image:cutImagess];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"%@", touches);
    
    if (coutOrigin.x < 0) {
        self.coutVeiw.frame = CGRectMake(0, coutOrigin.y, coutSize.width, coutSize.height);
        return;
    }
    if (coutOrigin.x > self.frame.size.width-coutSize.width) {
        self.coutVeiw.frame = CGRectMake(self.frame.size.width-coutSize.width, coutOrigin.y, coutSize.width, coutSize.height);
        return;
    }
    if (coutOrigin.y < 0) {
        self.coutVeiw.frame = CGRectMake(coutOrigin.x, 0, coutSize.width, coutSize.height);
        return;
    }
    if (coutOrigin.y > self.frame.size.height-coutSize.height) {
        self.coutVeiw.frame = CGRectMake(coutOrigin.x, self.frame.size.height-coutSize.height, coutSize.width, coutSize.height);
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    //当前的point
    CGPoint currentP = [touch locationInView:self.coutVeiw];
    
    //以前的point
    CGPoint preP = [touch previousLocationInView:self.coutVeiw];
    
    //x轴偏移的量
    CGFloat offsetX = currentP.x - preP.x;
    
    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;
    
    self.coutVeiw.transform = CGAffineTransformTranslate(self.coutVeiw.transform, offsetX, offsetY);
    
}

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect hostImage:(UIImage *)hostImage
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(hostImage.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

//等比例缩放
-(UIImage *)scaleToSize:(CGSize)size image:(UIImage *)scaleimage
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

@end
