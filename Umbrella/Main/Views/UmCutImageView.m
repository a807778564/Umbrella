//
//  UmCutImageView.m
//  Umbrella
//
//  Created by laber on 2016/10/7.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmCutImageView.h"
#import "UmCutView.h"

typedef NS_ENUM(NSInteger) {
    UmCutLeftTop,
    UmCutLeftBottom,
    UmCutRightTop,
    UmCutRightBottom,
}UmCutPostion;

#define coutOrigin self.coutVeiw.frame.origin
#define coutSize self.coutVeiw.frame.size

@interface UmCutImageView()

@property (nonatomic, strong) UmCutView *coutVeiw;

@property (nonatomic, assign) CGAffineTransform oldTrans;
@property (nonatomic, assign) BOOL isMaxSzie;
@property (nonatomic, assign) float oldWidth;
@property (nonatomic, assign) BOOL touCanTrans;
@property (nonatomic, assign) CGRect maxFrame;
@property (nonatomic, assign) CGRect maxleToFrame;
@property (nonatomic, assign) CGRect maxleLeFrame;
@property (nonatomic, assign) CGRect maxriToFrame;
@property (nonatomic, assign) CGRect maxririFrame;
@property (nonatomic, assign) CGRect maxleBoFrame;
@property (nonatomic, assign) CGRect maxboBoFrame;
@property (nonatomic, assign) CGRect maxriBoFrame;
@property (nonatomic, assign) CGRect maxboRiFrame;
@property (nonatomic, assign) UmCutPostion cutPos;
@property (nonatomic, assign) BOOL isMaxMove;
@end

@implementation UmCutImageView

- (instancetype)init{
    if ([super init]) {
        self.coutVeiw = [[UmCutView alloc] init];
        self.coutVeiw.backgroundColor = [UIColor clearColor];
//        self.coutVeiw.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.coutVeiw.layer.borderWidth = 1.0f;
        [self addSubview:self.coutVeiw];
        
        // 缩放手势
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
        [self.coutVeiw addGestureRecognizer:pinchGestureRecognizer];
    }
    return self;
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    if (self.isMaxSzie && pinchGestureRecognizer.scale>1) {
        return;
    }else{
        self.isMaxSzie = false;
    }
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        if (self.coutVeiw.frame.size.width > self.maxFrame.size.width) {
            self.coutVeiw.transform = self.oldTrans;
            self.coutVeiw.frame = self.maxFrame;
            self.isMaxSzie = YES;
        }
        pinchGestureRecognizer.scale = 1;
        self.touCanTrans = NO;
    }
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
            make.width.offset(image.size.width+5);
            make.height.equalTo(self.coutVeiw.mas_width);
        }];
    }else{
        [self.coutVeiw mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.coutVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
//            make.trailing.equalTo(self.mas_trailing).offset(-60);
//            make.leading.equalTo(self.mas_leading).offset(60);
            if (_image.size.width/_image.size.height != 1) {
                if (_image.size.width  > _image.size.height) {
                    make.width.offset(_image.size.height+5);
                }else{
                    make.width.offset(_image.size.width+5);
                }
            }
            make.height.equalTo(self.coutVeiw.mas_width);
        }];
    }
    [self performSelector:@selector(updateMaxFrame) withObject:nil afterDelay:0.5];
}

- (void)updateMaxFrame{
    CGFloat width = coutSize.width;
    self.oldWidth = width;
    if (_image.size.width/_image.size.height != 1) {
        if (_image.size.width  > _image.size.height) {
            width = _image.size.height;
        }else{
            width = _image.size.width;
        }
    }
    self.maxFrame = CGRectMake(coutOrigin.x, coutOrigin.y, width, width);
    self.oldTrans = self.coutVeiw.transform;
}

- (UIImage *)cutImageWhenBack:(UIImage *)hostImage{
    if (_image.size.width/_image.size.height == 1) {
        UIImage *cutImagess = [self getSubImage:self.coutVeiw.frame hostImage:hostImage];
        return [self scaleToSize:CGSizeMake(self.maxFrame.size.width, self.maxFrame.size.height) image:cutImagess];
    }else{
        UIImage *cutImagess = [self getSubImage:self.coutVeiw.frame hostImage:hostImage];
        return [self scaleToSize:CGSizeMake(self.maxFrame.size.width, self.maxFrame.size.height) image:cutImagess];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.touCanTrans = NO;
//    self.coutVeiw.center = CGPointMake(coutSize.width/2, coutSize.height/2);
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.coutVeiw];

    if (currentP.x < 15 && currentP.y < 15) {
        self.touCanTrans = YES;
        self.cutPos = UmCutLeftTop;
    }
    if ((currentP.x >(coutSize.width)-15&&currentP.y<15)||(currentP.x>(self.oldWidth)-15&&currentP.y<15)) {
        self.touCanTrans = YES;
        self.cutPos = UmCutRightTop;
    }
    if ((currentP.x<15 && currentP.y>(coutSize.height) -15) || (currentP.x<15 &&currentP.y>(self.oldWidth)-15)) {
        self.touCanTrans = YES;
        self.cutPos = UmCutLeftBottom;
    }
    if (((currentP.x >(coutSize.width)-15)&&currentP.y>(coutSize.height)-15)||((currentP.x >(self.oldWidth)-15)&&currentP.y>(self.oldWidth)-15)) {
        self.touCanTrans = YES;
        self.cutPos = UmCutRightBottom;
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
//    NSLog(@"%@", touches);
    UITouch *touch = [touches anyObject];
    
    //当前的point
    CGPoint currentP = [touch locationInView:self.coutVeiw];
    
    //以前的point
    CGPoint preP = [touch previousLocationInView:self.coutVeiw];
    
    //x轴偏移的量
    CGFloat offsetX = currentP.x - preP.x;
    
    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;
    if (self.touCanTrans) {
//        if (coutOrigin.x < -2.5) {
//            self.coutVeiw.frame = CGRectMake(-2.5, coutOrigin.y, coutSize.width, coutSize.height);
//        }
//        if (coutOrigin.y < -2.5) {
//            self.coutVeiw.frame = CGRectMake(coutOrigin.x, -2.5, coutSize.width, coutSize.height);
//        }
//        if (coutOrigin.x < -5) {
//            self.isMaxMove = YES;
//            return;
//        }
//        if (coutOrigin.x > self.frame.size.width-coutSize.width+5) {
//            self.isMaxMove = YES;
//            return;
//        }
//        if (coutOrigin.y < -5) {
//            self.isMaxMove = YES;
//            return;
//        }
//        if (coutOrigin.y > self.frame.size.height-coutSize.height+5) {
//            self.isMaxMove = YES;
//            return;
//        }
        if (self.cutPos == UmCutLeftTop) {
            self.coutVeiw.frame = CGRectMake(coutOrigin.x+offsetX, coutOrigin.y+offsetX, coutSize.width-offsetX, coutSize.height-offsetX);
        }
        if (self.cutPos == UmCutRightTop) {
            self.coutVeiw.frame = CGRectMake(coutOrigin.x, coutOrigin.y-offsetX, coutSize.width+offsetX, coutSize.height+offsetX);
        }
        if (self.cutPos == UmCutLeftBottom) {
            self.coutVeiw.frame = CGRectMake(coutOrigin.x+offsetX, coutOrigin.y, coutSize.width-offsetX, coutSize.height-offsetX);
        }
        if (self.cutPos == UmCutRightBottom){
            self.coutVeiw.frame = CGRectMake(coutOrigin.x, coutOrigin.y, coutSize.width+offsetX, coutSize.height+offsetX);
        }
//        self.coutVeiw.transform = CGAffineTransformScale(self.coutVeiw.transform, preP.x/currentP.x, preP.x/currentP.x);
//        if (self.coutVeiw.frame.size.width > self.maxFrame.size.width) {
//            self.coutVeiw.transform = self.oldTrans;
//            self.coutVeiw.frame = self.maxFrame;
//            self.isMaxSzie = YES;
//        }
        NSLog(@"缩放");
    }else{
        if (coutOrigin.x < -2.5) {
            self.coutVeiw.frame = CGRectMake(-2.5, coutOrigin.y, coutSize.width, coutSize.height);
            return;
        }
        if (coutOrigin.x > self.frame.size.width-coutSize.width+2.5) {
            self.coutVeiw.frame = CGRectMake(self.frame.size.width-coutSize.width+2.5, coutOrigin.y, coutSize.width, coutSize.height);
            return;
        }
        if (coutOrigin.y < -2.5) {
            self.coutVeiw.frame = CGRectMake(coutOrigin.x, -2.5, coutSize.width, coutSize.height);
            return;
        }
        if (coutOrigin.y > self.frame.size.height-coutSize.height+2.5) {
            self.coutVeiw.frame = CGRectMake(coutOrigin.x, self.frame.size.height-coutSize.height+2.5, coutSize.width, coutSize.height);
            return;
        }
        self.coutVeiw.transform = CGAffineTransformTranslate(self.coutVeiw.transform, offsetX, offsetY);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_image.size.width  > _image.size.height) {
        if (coutOrigin.x+coutSize.width > _image.size.height+5) {
            self.coutVeiw.frame = CGRectMake(coutOrigin.x, coutOrigin.y, _image.size.height+5-coutOrigin.x, _image.size.height+5-coutOrigin.x);
        }
        if (self.coutVeiw.frame.size.width > _image.size.height+5) {
            self.coutVeiw.transform = self.oldTrans;
            self.coutVeiw.frame = CGRectMake(-2.5, -2.5, _image.size.height+5, _image.size.height+5);
        }
    }else{
        if (coutOrigin.x+coutSize.width > _image.size.width+5) {
            self.coutVeiw.frame = CGRectMake(coutOrigin.x, coutOrigin.y, _image.size.width+5-coutOrigin.x, _image.size.width+5-coutOrigin.x);
        }
        if (self.coutVeiw.frame.size.width > _image.size.width+5) {
            self.coutVeiw.transform = self.oldTrans;
            self.coutVeiw.frame = CGRectMake(-2.5, -2.5, _image.size.width+5, _image.size.width+5);
        }
    }
//    if (self.isMaxMove) {
//        if (_image.size.width  > _image.size.height) {
//            self.coutVeiw.frame = CGRectMake(coutOrigin.x, coutOrigin.y, _image.size.height+5, _image.size.height+5);
//        }else{
//            self.coutVeiw.frame = CGRectMake(coutOrigin.x, coutOrigin.y, _image.size.width+5, _image.size.width+5);
//        }
//        if (coutOrigin.x < -2.5) {
//            self.coutVeiw.frame = CGRectMake(-2.5, coutOrigin.y, coutSize.width, coutSize.height);
//            return;
//        }
//        if (coutOrigin.x > self.frame.size.width-coutSize.width+2.5) {
//            self.coutVeiw.frame = CGRectMake(self.frame.size.width-coutSize.width+2.5, coutOrigin.y, coutSize.width, coutSize.height);
//            return;
//        }
//        if (coutOrigin.y < -2.5) {
//            self.coutVeiw.frame = CGRectMake(coutOrigin.x, -2.5, coutSize.width, coutSize.height);
//            return;
//        }
//        if (coutOrigin.y > self.frame.size.height-coutSize.height+2.5) {
//            self.coutVeiw.frame = CGRectMake(coutOrigin.x, self.frame.size.height-coutSize.height+2.5, coutSize.width, coutSize.height);
//            return;
//        }
//        self.isMaxMove = NO;
//    }
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
