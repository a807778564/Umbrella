//
//  UmbrellaCheckView.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/29.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmbrellaCheckView.h"

@interface UmbrellaCheckView()

@property (nonatomic, strong) NSMutableArray *checkArray;
@end

@implementation UmbrellaCheckView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.checkArray = [[NSMutableArray alloc] init];
    
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

- (void)checkSanMian:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setBackgroundColor:RGBACOLOR(231, 133, 47, 1)];
        if (![self.checkArray containsObject:btn.titleLabel.text]) {
            [self.checkArray addObject:btn.titleLabel.text];
        }
    }else{
        [btn setBackgroundColor:RGBACOLOR(246, 226, 77, 1)];
        if ([self.checkArray containsObject:btn.titleLabel.text]) {
            [self.checkArray removeObject:btn.titleLabel.text];
        }
    }
}

- (void)checkSure:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"确定"]) {
        NSLog(@"确定");
    }else{
        for (UIView *sub in self.subviews) {
            if ([sub isKindOfClass:[UIButton class]]) {
                UIButton *check = (UIButton *)sub;
                if (!([check.titleLabel.text isEqualToString:@"确定"] || [check.titleLabel.text isEqualToString:@"取消"])) {
                    check.selected = NO;
                    [check setBackgroundColor:RGBACOLOR(246, 226, 77, 1)];
                }
            }
        }
        [self.checkArray removeAllObjects];
    }
    self.didCheck(btn.titleLabel.text,self.checkArray);
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
