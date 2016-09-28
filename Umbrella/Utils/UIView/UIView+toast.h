//
//  UIView+toast.h
//  ebook
//
//  Created by lj on 14-6-19.
//  Copyright (c) 2014年 cczone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (toast)

- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point;
- (UIView *)getToastView:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)point;
-(void)makeToast:(NSString *)message;

- (void)setLayerBorderWidth:(CGFloat)width borderCorlor:(UIColor *)color corner:(CGFloat)corner;
@end
