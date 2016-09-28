//
//  UILabel+ofen.m
//  HomeDo
//
//  Created by huangrensheng on 15/12/14.
//  Copyright © 2015年 Lynn. All rights reserved.
//

#import "UILabel+ofen.h"

@implementation UILabel (ofen)

//- (void)setFont:(UIFont *)font{
//    [self setFont:[UIFont fontWithName:font.fontName size:font.pointSize]];
//}

//- (void)awakeFromNib{
//    [super awakeFromNib];
//    [self setFont:[UIFont fontWithName:self.font.fontName size:self.font.pointSize]];
//}


+(CGSize)CompareTextSize:(NSString*)text Size:(CGSize)size FontSize:(CGFloat)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize rsize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
    rsize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;

    return rsize;
}

/**
 *  计算文本高度
 *
 *  @param text       文本内容
 *  @param number     行数
 *  @param width      文本宽度
 *  @param heightLine 行间距
 *  @param headerLine 首行缩进多少
 *  @param labelInfo  返回处理好的信息
 */
+(void)getSizeWithText:(NSString *)text textFont:(CGFloat)font numberOfLine:(int)number labelWidth:(CGFloat)width heightLine:(CGFloat)heightLine headerLine:(CGFloat)headerLine labelInfo:(labelSizeAndTextBlk)labelInfo{
    
    if (text == nil) {
        text = @"暂无简介";
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.numberOfLines = number;
    label.font = [UIFont systemFontOfSize:font];
    
    //UILabel设置行间距等属性：
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [paragraphStyle setLineSpacing:heightLine];//行间距
    [paragraphStyle setFirstLineHeadIndent:headerLine];//首行缩进
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
    
    label.attributedText = attributedString;
    
    //宽度不变，根据字的多少计算label的高度
    labelInfo([label sizeThatFits:CGSizeMake(width, MAXFLOAT)],attributedString);
}



- (UILabel *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)font{
    UILabel *label = [[UILabel alloc] init];
    
    [label setText:title];
    [label setTextColor:titleColor];
    [label setFont:[UIFont systemFontOfSize:font]];
    
    return label;
}


- (void)setLayerCornerRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setCornerRadius:radius];
}

-(void)alignTop
{
    CGSize fontSize =[self.text sizeWithFont:self.font];
    
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth =self.frame.size.width;
    
    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, theStringSize.height);
    
}
@end
