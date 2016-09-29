//
//  UmbrellaCheckView.h
//  Umbrella
//
//  Created by huangrensheng on 16/9/29.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UmbreCheck)(NSString *title,NSMutableArray *checkNumber);

@interface UmbrellaCheckView : UIView

@property (nonatomic, copy) UmbreCheck didCheck;

- (void)didCheckNumberFinish:(UmbreCheck)check;

@end
