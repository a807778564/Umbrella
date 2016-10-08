//
//  UmPhotoCutController.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/30.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmPhotoCutController.h"
#import "UmCutImageView.h"

#define selfWidth self.view.frame.size.width
#define selfHeight self.view.frame.size.height

@interface UmPhotoCutController ()

@property (nonatomic, strong) UmCutImageView *showImageView;

@property (nonatomic, assign) BOOL canMove;

@end

@implementation UmPhotoCutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = RGBACOLOR(246, 226, 77, 1);
    self.title = @"裁剪图片";
    self.view.backgroundColor = RGBACOLOR(34, 34, 34, 1);
    [self setLeftArrow];
    self.showImageView = [[UmCutImageView alloc] init];
    self.showImageView.userInteractionEnabled = YES;
    //自适应图片宽高比例
    self.showImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.showImageView];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        if ((self.hostImage.size.width/self.hostImage.size.height)==1) {
            make.trailing.equalTo(self.view.mas_trailing).offset(-60);
            make.leading.equalTo(self.view.mas_leading).offset(60);
            make.height.equalTo(self.showImageView.mas_width);
            self.canMove = YES;
        }else{
            if ((self.hostImage.size.height*selfWidth/self.hostImage.size.width) < (selfWidth-120)) {
                make.width.offset(selfWidth);
                make.height.offset(selfWidth-120);
                self.hostImage = [self scaleToSize:CGSizeMake(self.hostImage.size.width*(selfWidth-120)/self.hostImage.size.height, selfWidth-120) image:self.hostImage];
            }else{
                make.width.offset(selfWidth);
                make.height.offset(self.hostImage.size.height*selfWidth/self.hostImage.size.width);
                self.hostImage = [self scaleToSize:CGSizeMake(selfWidth, self.hostImage.size.height*selfWidth/self.hostImage.size.width) image:self.hostImage];
            }
            
        }
    }];
    [self.showImageView setImage:self.hostImage];
    
    
}

//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size image:(UIImage *)scaleimage
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

- (void)doLeftAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    self.cut([self.showImageView cutImageWhenBack:self.hostImage]);
}


- (void)didCutImageFinish:(CutImageFinish)finish{
    self.cut = finish;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
