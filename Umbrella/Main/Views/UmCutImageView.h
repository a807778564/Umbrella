//
//  UmCutImageView.h
//  Umbrella
//
//  Created by laber on 2016/10/7.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UmCutImageView : UIView

- (UIImage *)cutImageWhenBack:(UIImage *)hostImage;

@property (nonatomic, strong) UIImage *image;

@end
