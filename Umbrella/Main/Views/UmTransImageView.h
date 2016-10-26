//
//  UmTransImageView.h
//  Umbrella
//
//  Created by huangrensheng on 16/10/12.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UmTransImageView : UIView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) NSInteger startSan;

@property (nonatomic, assign) NSInteger sanMianCount;

@property (nonatomic, strong) NSMutableArray *checkArray;

@property (nonatomic, assign) NSUInteger treeStartInde;//三个伞面开始的

@end
