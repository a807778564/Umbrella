//
//  UmbrellaImageCheck.h
//  Umbrella
//
//  Created by huangrensheng on 16/9/29.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChoseImage)(UIImage *image);

@interface UmbrellaImageCheck : UIView

@property (nonatomic, strong) NSString *cageteId;

@property (nonatomic, copy) ChoseImage chose;

- (void)didChoseImage:(ChoseImage)choseImage;

@end
