//
//  UILabel+ofen.h
//  HomeDo
//
//  Created by huangrensheng on 15/12/14.
//  Copyright © 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^labelSizeAndTextBlk)(CGSize size , NSAttributedString *text);

@interface UILabel (ofen)

+(CGSize)CompareTextSize:(NSString*)text Size:(CGSize)size FontSize:(CGFloat)fontSize;

+(void)getSizeWithText:(NSString *)text textFont:(CGFloat)font numberOfLine:(int)number labelWidth:(CGFloat)width heightLine:(CGFloat)heightLine headerLine:(CGFloat)headerLine labelInfo:(labelSizeAndTextBlk)labelInfo;

- (UILabel *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)font;

- (void)setLayerCornerRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

-(void)alignTop;  // 顶部对齐

@end
