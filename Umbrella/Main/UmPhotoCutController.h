//
//  UmPhotoCutController.h
//  Umbrella
//
//  Created by huangrensheng on 16/9/30.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "BaseController.h"

typedef void(^CutImageFinish)(UIImage *cutImage);

@interface UmPhotoCutController : BaseController

//@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) UIImage *hostImage;

@property (nonatomic, copy) CutImageFinish cut;

- (void)didCutImageFinish:(CutImageFinish)finish;

@end
