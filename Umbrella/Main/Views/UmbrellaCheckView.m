//
//  UmbrellaCheckView.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/29.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmbrellaCheckView.h"

@interface UmbrellaCheckView()

@end

@implementation UmbrellaCheckView

- (void)awakeFromNib{
    [super awakeFromNib];
    float corner = (self.frame.size.width - 16*2 - 21*3);
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *check = (UIButton *)sub;
            if ([check.titleLabel.text isEqualToString:@"确定"] || [check.titleLabel.text isEqualToString:@"取消"]) {
                check.layer.cornerRadius = 2;
                [check addTarget:self action:@selector(checkSure:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [check addTarget:self action:@selector(checkSanMian:) forControlEvents:UIControlEventTouchUpInside];
                check.layer.cornerRadius = corner/8;
            }
        }
    }
}

- (void)setCheckArray:(NSMutableArray *)checkArray{
    _checkArray = checkArray;
    [self makeCons];
}

- (void)makeCons{
    float corner = (self.frame.size.width - 16*2 - 21*3);
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *check = (UIButton *)sub;
            if ([check.titleLabel.text isEqualToString:@"确定"] || [check.titleLabel.text isEqualToString:@"取消"]) {
                check.layer.cornerRadius = 4;
            }else{
                check.layer.cornerRadius = corner/8;
            }
        }
    }
}

- (void)setOldCheck:(NSMutableArray *)oldCheck{
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *check = (UIButton *)sub;
            if (!([check.titleLabel.text isEqualToString:@"确定"] || [check.titleLabel.text isEqualToString:@"取消"])) {
                UIButton *check = (UIButton *)sub;
                if (oldCheck.count <= 0) {
                    check.selected = NO;
                    [check setBackgroundColor:RGBACOLOR(246, 226, 77, 1)];
                }else{
                    for (NSNumber *checkNumber in oldCheck) {
                        if ([check.titleLabel.text  integerValue] == [checkNumber integerValue] ) {
                            check.selected = YES;
                            [check setBackgroundColor:RGBACOLOR(231, 133, 47, 1)];
                            break;
                        }else{
                            check.selected = NO;
                            [check setBackgroundColor:RGBACOLOR(246, 226, 77, 1)];
                        }
                    }
                }
            }
        }
    }
}

- (void)checkSanMian:(UIButton *)btn{
    if (_checkArray == nil) {
        _checkArray = [[NSMutableArray alloc] init];
    }
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setBackgroundColor:RGBACOLOR(231, 133, 47, 1)];
        if (![_checkArray containsObject:btn.titleLabel.text]) {
            [_checkArray addObject:btn.titleLabel.text];
        }
    }else{
        [btn setBackgroundColor:RGBACOLOR(246, 226, 77, 1)];
        if ([_checkArray containsObject:btn.titleLabel.text]) {
            [_checkArray removeObject:btn.titleLabel.text];
        }
    }
}

- (void)checkSure:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"确定"]) {
        NSLog(@"确定");
    }else{
        [_checkArray removeAllObjects];
    }
    self.didCheck(btn.titleLabel.text,_checkArray);
}

- (void)didCheckNumberFinish:(UmbreCheck)check{
    self.didCheck = check;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
