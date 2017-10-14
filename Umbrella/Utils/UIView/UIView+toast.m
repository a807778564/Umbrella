//
//  UIView+toast.m
//  ebook
//
//  Created by lj on 14-6-19.
//  Copyright (c) 2014年 cczone. All rights reserved.
//

#import "UIView+toast.h"

static const CGFloat CSToastVerticalPadding     = 10.0;
static const CGFloat CSToastDefaultDuration     = 3.0;
static const NSString * CSToastDefaultPosition  = @"bottom";
static const CGFloat CSToastFadeDuration        = 0.2;

@implementation UIView (toast)

- (void)setLayerBorderWidth:(CGFloat)width borderCorlor:(UIColor *)color corner:(CGFloat)corner{
    [self.layer setCornerRadius:corner];
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
}

- (void)showToast:(UIView *)toast {
    [self showToast:toast duration:CSToastDefaultDuration position:CSToastDefaultPosition];
}

- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point {
    toast.center = [self centerPointForPosition:point withToast:toast];
    toast.alpha = 0.0;
    [self addSubview:toast];
    
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:CSToastFadeDuration
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              toast.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [toast removeFromSuperview];
                                          }];
                     }];
}

- (CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        // convert string literals @"Center", @"bottom", @"center", or any point wrapped in an NSValue object into a CGPoint
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height / 2) + CSToastVerticalPadding);
        } else if([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - CSToastVerticalPadding);
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    NSLog(@"Warning: Invalid position for toast.");
    return [self centerPointForPosition:CSToastDefaultPosition withToast:toast];
}

- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)point
{
    if(!message || message.length == 0)
        return;
    [self showToast:[self getToastView:message] duration:interval position:point];
}

-(void)makeToast:(NSString *)message
{
    [self makeToast:message duration:0.5 position:@"center"];
}

-(UIView *)getToastView:(NSString *)message
{
    UIButton *btn = [UIButton buttonWithFrame:CGRectZero Font:[UIFont systemFontOfSize:15] TextColor:[UIColor whiteColor] Text:message];
    CGSize size = [UILabel CompareTextSize:message Size:CGSizeMake(MAXFLOAT, 100) FontSize:15];
    btn.frame = CGRectMake(0, 0, size.width+ 30, size.height+ 15);
    btn.backgroundColor = [UIColor grayColor];
    btn.alpha = 0.9;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    btn.userInteractionEnabled = NO;
    
//    btn.layer.shadowColor = [UIColor greenColor].CGColor;
//    btn.layer.shadowOffset = CGSizeMake(-5, 5);
//    btn.layer.shadowOpacity = 1;
    return btn;
}


- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

- (void)setDefaultAnchorPointforView:(UIView *)view
{
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:view];
}
@end
